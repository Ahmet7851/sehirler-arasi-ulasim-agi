# 1. Varlıklar ve Nitelikler

Projede yer alması gereken temel varlıklar:

| Varlık          | Açıklama                                       | Nitelikler                                                    |
|-----------------|------------------------------------------------|---------------------------------------------------------------|
| Şehir           | Bu varlık her bir şehri temsil edecek.         | şehir_id (PK), şehir_adı, şehir_bölgesi                       |
| Otogar (Terminal) | Her şehirde bir veya daha fazla otogar olabilir. | otogar_id (PK), otogar_adı, şehir_id (FK), adres           |
| Otobüs          | Şehirler arası taşımacılık için araç varlığı.  | otobüs_id (PK), plakası, kapasite, model, firma_id (FK)       |
| Firma           | Otobüslerin ait olduğu ulaşım firmaları.       | firma_id (PK), firma_adı, iletişim_bilgileri                  |
| Sefer (Yolculuk) | Belirli bir tarih ve saatte gerçekleşen ulaşım hareketi. | sefer_id (PK), kalkış_otogar_id (FK), varış_otogar_id (FK), tarih, saat, otobüs_id (FK), fiyat |
| Rezervasyon     | Yolcuların seferlere yaptıkları rezervasyon bilgileri. | rezervasyon_id (PK), yolcu_id (FK), sefer_id (FK), koltuk_no, satın_alma_tarihi |
| Yolcu           | Ulaşım ağını kullanan bireyler.               | yolcu_id (PK), ad_soyad, telefon, email                       |

## 2. İlişkiler ve Sayısal Kısıtlamalar

| İlişki           | Açıklama                                                                                              | Sayısal Kısıtlama |
|------------------|-------------------------------------------------------------------------------------------------------|--------------------|
| Şehir - Otogar   | Bir şehirde bir veya birden fazla otogar bulunabilir, fakat her otogar yalnızca bir şehirde yer alır. | 1:N               |
| Firma - Otobüs   | Her firma birden fazla otobüse sahip olabilir, fakat her otobüs sadece bir firmaya ait olabilir.      | 1:N               |
| Otogar - Sefer   | Her otogar birden fazla seferin başlangıç ve bitiş noktası olabilir.                                  | 1:N               |
| Otobüs - Sefer   | Her otobüs birden fazla sefere çıkabilir, fakat bir seferde yalnızca bir otobüs kullanılır.           | 1:N               |
| Sefer - Rezervasyon | Bir seferde birden fazla rezervasyon olabilir, fakat bir rezervasyon tek bir sefere yapılır.        | 1:N               |
| Yolcu - Rezervasyon | Bir yolcu birden fazla rezervasyon yapabilir, ancak her rezervasyon tek bir yolcuya aittir.         | 1:N               |

## 3. E-R Diyagramı

Bu gereksinimlere göre E-R diyagramınızı oluştururken, yukarıdaki varlıkları ve ilişkileri diyagram üzerinde gösterebilirsiniz. Varlıkları dikdörtgen içinde, ilişkileri ise elmas şeklinde çizip, kısıtlamaları (1:1, 1:N, N:M) belirtebilirsiniz.

## 4. Kullanıcı Rolleri ve Gereksinimler

Farklı kullanıcı türlerine göre gereksinimlerinizi belirleyin:

| Kullanıcı Rolü       | Gereksinimler                                              |
|----------------------|------------------------------------------------------------|
| Yolcu Kullanıcı Rolü | Sefer araması yapabilme, rezervasyon oluşturabilme         |
| Firma Yönetici Rolü  | Firma otobüslerini ve sefer bilgilerini yönetebilme        |
| Sistem Yöneticisi Rolü | Tüm otogar ve şehir bilgilerini düzenleyebilme          |
