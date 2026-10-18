Ticket.create!([
  {
    customer_name: "Caner Yılmaz",
    customer_email: "caner.yilmaz@email.com",
    title: "Araçta Eşya Unutuldu: Siyah Sırt Çantası (#UB-89214)",
    description: "Dün gece 23:45'te Beşiktaş - Kadıköy yolculuğumu tamamladım. 34 TFM 42 plakalı aracın arka koltuğunda siyah deri sırt çantamı unuttum. İçinde şirket bilgisayarım var, sürücüye ulaşamıyorum acil destek rica ederim.",
    status: "open",
    department: "Kayıp Eşya & Sürücü Masası",
    ai_draft_reply: "Merhaba Caner Bey, araçta eşyanızı unuttuğunuz için üzgünüz. 34 TFM 42 plakalı aracın sürücüsü ile acil operasyonel hattan iletişime geçildi. Güvenliğiniz adına telefon numaranız maskelenerek sürücüye aktarılmış olup teslimat için sizinle 15 dakika içinde iletişime geçmesi talimatı verilmiştir.",
    ai_suggested_action: "Sürücüye Acil Bildirim & Maskeli İletişim Sağla",
    time_saved_minutes: 25
  },
  {
    customer_name: "Selin Demir",
    customer_email: "selin.demir@kurumsal.com",
    title: "Rota Sapması ve Mükerrer Köprü Ücreti İtirazı",
    description: "Havalimanı transferimde sürücü navigasyon dışına çıkarak köprü geçişini mükerrer yansıtmış. 450 TL tahmini ücret yerine hesabımdan 920 TL tahsil edildi. GPS telemetrisinin incelenmesini ve haksız farkın iadesini talep ediyorum.",
    status: "open",
    department: "Ücret & Rota Uyuşmazlıkları Birimi",
    ai_draft_reply: "Merhaba Selin Hanım, yolculuk telemetri ve GPS kayıtlarınız incelenmiştir. Optimum rotanın 14 km dışına çıkıldığı ve fazladan gişe geçişi yapıldığı doğrulanmıştır. 470 TL'lik tutar farkı kayıtlı kredi kartınıza anında iade edilmiş olup 1-3 iş günü içinde hesabınıza yansıyacaktır.",
    ai_suggested_action: "GPS Sapmasını Doğrula & 470 TL Anında İade Geç",
    time_saved_minutes: 20
  },
  {
    customer_name: "Büşra Aydın",
    customer_email: "busra.aydin@domain.com",
    title: "Kritik Güvenlik İhlali: Sürüş Esnasında Telefon Kullanımı",
    description: "Seyir halindeyken sürücü sürekli telefonla video izledi ve emniyet şeridini ihlal etti. Kendisini uyardığımda sözlü tartışma çıkardı, yolcu güvenliğini hiçe saydı.",
    status: "in_progress",
    department: "Yolcu & Sürüş Emniyeti (Trust & Safety)",
    ai_draft_reply: "Merhaba Büşra Hanım, paylaştığınız güvenlik ihlali en yüksek öncelikle işleme alınmıştır. Yolcu ve sürüş emniyeti politikamız gereğince ilgili sürücü hesabı güvenlik soruşturması tamamlanana kadar geçici olarak askıya alınmış ve Uber Emniyet Masası tarafından ifadeye çağrılmıştır.",
    ai_suggested_action: "Sürücüyü Askıya Al & Güvenlik Soruşturması Başlat",
    time_saved_minutes: 35
  }
])
