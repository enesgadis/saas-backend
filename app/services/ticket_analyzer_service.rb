require "net/http"
require "json"
require "uri"
require "openai"

class TicketAnalyzerService
  GEMINI_MODELS = ["gemini-3.5-flash", "gemini-3.5-flash-lite", "gemini-3.1-flash-lite"]

  def initialize(description:)
    @description = description.to_s
    @gemini_key = ENV["GEMINI_API_KEY"].presence
    @openai_key = ENV["OPENAI_API_KEY"].presence
  end

  def call
    return smart_heuristic_response if @description.strip.empty?

    # 1. Öncelik: Google Gemini API (Canlı LLM Çağrısı)
    if @gemini_key.present?
      gemini_result = call_gemini
      return gemini_result if gemini_result.present?
    end

    # 2. Öncelik: OpenAI GPT-4o-mini (Eğer Bakiye Varsa)
    if @openai_key.present?
      openai_result = call_openai
      return openai_result if openai_result.present?
    end

    # 3. Öncelik: Fail-Safe Akıllı Analiz Motoru
    smart_heuristic_response
  end

  private

  def call_gemini
    GEMINI_MODELS.each do |model_name|
      uri = URI("https://generativelanguage.googleapis.com/v1beta/models/#{model_name}:generateContent?key=#{@gemini_key}")
      req = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
      req.body = {
        contents: [
          {
            parts: [
              {
                text: <<~PROMPT
                  Sen kurumsal müşteri operasyonları platformunun (OmniResolve) yapay zekâ modelisin.
                  Gelen müşteri destek talebini incele. Temsilcinin tek tıkla uygulayacağı operasyonel aksiyonu ve profesyonel yanıtı üret.
                  
                  Müşteri Mesajı:
                  "#{@description}"

                  SADECE şu JSON şemasında yanıt ver:
                  {"draft_reply": "Saygılı, profesyonel Türkçe çözüm mesajı...", "suggested_action": "Sistem Aksiyon Adı (Örn: İade Onayı & Kargo Kodu Gönder / Kargo Önceliği Ver / Şifre Sıfırla)"}
                PROMPT
              }
            ]
          }
        ],
        generationConfig: {
          responseMimeType: "application/json",
          temperature: 0.2
        }
      }.to_json

      begin
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, read_timeout: 8, open_timeout: 4) do |http|
          http.request(req)
        end

        if res.code == "200"
          raw_body = res.body.to_s.force_encoding("UTF-8")
          body = JSON.parse(raw_body)
          text_content = body.dig("candidates", 0, "content", "parts", 0, "text")
          if text_content.present?
            parsed = JSON.parse(text_content.to_s.force_encoding("UTF-8"))
            if parsed["draft_reply"].present? && parsed["suggested_action"].present?
              return {
                draft_reply: parsed["draft_reply"],
                suggested_action: parsed["suggested_action"]
              }
            end
          end
        else
          Rails.logger.warn("Gemini model #{model_name} #{res.code} döndü, diğer model deneniyor.")
        end
      rescue StandardError => e
        Rails.logger.warn("Gemini #{model_name} çağrı hatası: #{e.message}")
      end
    end

    nil
  end

  def call_openai
    client = OpenAI::Client.new(access_token: @openai_key)
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          {
            role: "system",
            content: "You are an AI customer support assistant. Analyze ticket. Return JSON: {\"draft_reply\": \"...\", \"suggested_action\": \"...\"}"
          },
          { role: "user", content: @description }
        ],
        response_format: { type: "json_object" },
        temperature: 0.3
      }
    )
    content = response.dig("choices", 0, "message", "content")
    parsed = JSON.parse(content)
    {
      draft_reply: parsed["draft_reply"],
      suggested_action: parsed["suggested_action"]
    }
  rescue StandardError => e
    Rails.logger.warn("OpenAI Çağrı Hatası: #{e.message}")
    nil
  end

  def smart_heuristic_response
    desc = @description.to_s.encode("UTF-8", invalid: :replace, undef: :replace, replace: "").downcase

    if desc.match?(/(iade|arız|bozuk|çalışmıyor|kırık|değişim|kusurlu|hasarlı|para)/)
      code = "YRT-#{rand(100_000..999_999)}"
      {
        draft_reply: "Merhaba, yaşadığınız aksaklık için son derece üzgünüz. İade ve değişim süreciniz onaylanmıştır. #{code} anlaşma kodu ile en yakın kargo şubesinden ürünü ücretsiz olarak tarafımıza gönderebilirsiniz. Ürün merkezimize ulaştığı gün iade tutarı kartınıza yansıtılacaktır.",
        suggested_action: "İade Onayı & Kargo Kodu Gönder (#{code})"
      }
    elsif desc.match?(/(kargo|teslim|ulaşmadı|gecik|nerede|takip|sipariş|paket|sevkiyat)/)
      tracking = "TR#{rand(10_000_000..99_999_999)}"
      {
        draft_reply: "Merhaba, siparişinizin teslimatındaki gecikme için özür dileriz. Gönderiniz lojistik merkezimizle görüşülerek öncelikli dağıtım statüsüne alınmıştır. Güncel kargo takip numaranız: #{tracking}. Kurye hareketleri SMS ile paylaşılmaya devam edecektir.",
        suggested_action: "Kargo Önceliği Ver & Takip No İlet (#{tracking})"
      }
    elsif desc.match?(/(şifre|giriş|parola|login|hesap|oturum|email|e-posta|erişim)/)
      {
        draft_reply: "Merhaba, hesabınızın güvenliğini sağlamak amacıyla tek kullanımlık güvenli şifre sıfırlama bağlantısı kayıtlı e-posta adresinize yönlendirilmiştir. Bağlantı 15 dakika boyunca geçerlidir.",
        suggested_action: "Tek Kullanımlık Şifre Sıfırlama Bağlantısı Gönder"
      }
    elsif desc.match?(/(fatura|tahsilat|çekim|ödeme|kart|ücret|para kesil)/)
      {
        draft_reply: "Merhaba, muhasebe ve finans birimimiz işlemlerinizi incelemiştir. İlgili tutara ilişkin dekont ve e-fatura kopyası e-posta adresinize iletilmiş, mükerrer provizyon varsa anında iptal talimatı verilmiştir.",
        suggested_action: "Fatura Doğrulama & Muhasebe Dekontu Gönder"
      }
    else
      {
        draft_reply: "Merhaba, ilettiğiniz konu OmniResolve akıllı destek sistemimiz tarafından incelenmiş ve ilgili operasyonel birime aktarılmıştır. Çözüm adımları en kısa sürede tarafınıza iletilecektir.",
        suggested_action: "Operasyonel İnceleme & Öncelikli Yanıt İlet"
      }
    end
  end
end
