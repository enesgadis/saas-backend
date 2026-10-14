Ticket.create!([
  {
    title: "Kargo Gecikmesi ve Teslimat Bilgisi",
    description: "Siparişim 5 gün önce verildi fakat hala kargoya verilmedi. Acil bilgi ve gerekiyorsa hızlandırma rica ediyorum.",
    status: "open",
    ai_draft_reply: "Merhaba, siparişinizdeki gecikme için özür dileriz. Lojistik birimimizle iletişime geçilmiş olup paketiniz gün içinde öncelikli olarak kargo firmasına teslim edilecektir. Takip numaranız SMS ile tarafınıza iletilecektir.",
    ai_suggested_action: "Kargo Önceliği Ver & Takip No İlet"
  },
  {
    title: "Ürün Arızalı Geldi - İade Talebi",
    description: "Satın aldığım klavyenin bazı tuşları basmıyor. Ürünü iade edip ücretimin kartıma geri yatırılmasını istiyorum.",
    status: "open",
    ai_draft_reply: "Merhaba, yaşadığınız aksaklık için özür dileriz. İade süreciniz sisteme işlenmiştir. 734920 anlaşma koduyla en yakın Yurtiçi Kargo şubesinden paketi ücretsiz gönderebilirsiniz. Ürün elimize ulaştığında 2 iş günü içinde iadeniz tamamlanacaktır.",
    ai_suggested_action: "İade Onayı & Kargo Kodu Gönder"
  }
])
