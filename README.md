
---
# Şehirler Arası Ulaşım Ağı Veri Tabanı

### Projede Emeği Geçenler:
225260304 – Ahmet Bulut  
205260060 – Mehmet Dürmüş
215260036 Serhat Özgan

---

## 1. Varlıklar ve Nitelikler

| Varlık        | Açıklama                                      | Nitelikler                                                 |
|---------------|-----------------------------------------------|------------------------------------------------------------|
| Şehir         | Bu varlık her bir şehri temsil eder.          | şehir_id (PK), şehir_adı, şehir_bölgesi                    |
| Otogar        | Her şehirde bir veya daha fazla otogar olabilir. | otogar_id (PK), otogar_adı, şehir_id (FK), adres        |
| Otobüs        | Şehirler arası taşımacılık için araç varlığı. | otobüs_id (PK), plakası, kapasite, model, firma_id (FK)    |
| Firma         | Otobüslerin ait olduğu ulaşım firmaları.      | firma_id (PK), firma_adı, iletişim_bilgileri               |
| Sefer         | Belirli bir tarih ve saatte gerçekleşen ulaşım hareketi. | sefer_id (PK), kalkış_otogar_id (FK), varış_otogar_id (FK), tarih, saat, otobüs_id (FK), fiyat |
| Rezervasyon   | Yolcuların seferlere yaptıkları rezervasyon bilgileri. | rezervasyon_id (PK), yolcu_id (FK), sefer_id (FK), koltuk_no, satın_alma_tarihi |
| Yolcu         | Ulaşım ağını kullanan bireyler.               | yolcu_id (PK), ad_soyad, telefon, email                    |

---

## 2. İlişkiler ve Sayısal Kısıtlamalar

| İlişki           | Açıklama                                                                                              | Sayısal Kısıtlama |
|------------------|-------------------------------------------------------------------------------------------------------|--------------------|
| **Şehir - Otogar**   | Bir şehirde bir veya birden fazla otogar bulunabilir, fakat her otogar yalnızca bir şehirde yer alır. | **1:N**           |
| **Firma - Otobüs**   | Her firma birden fazla otobüse sahip olabilir, fakat her otobüs sadece bir firmaya ait olabilir.      | **1:N**           |
| **Otogar - Sefer**   | Her otogar birden fazla seferin başlangıç ve bitiş noktası olabilir.                                  | **1:N**           |
| **Otobüs - Sefer**   | Her otobüs, birden fazla sefere çıkabilir, fakat bir seferde yalnızca bir otobüs kullanılır.           | **1:N**           |
| **Sefer - Rezervasyon** | Bir seferde birden fazla rezervasyon olabilir, fakat bir rezervasyon tek bir sefere yapılır.        | **1:N**           |
| **Yolcu - Rezervasyon** | Bir yolcu birden fazla rezervasyon yapabilir, ancak her rezervasyon tek bir yolcuya aittir.         | **1:N**           |
| **Şehir - Firma** | Her şehirde birden fazla firma olabilir, ancak bazı firmalar birden fazla şehirde hizmet verebilir. | **N:M**          |
| **Otogar - Yolcu** | Bazı otogarlar, belirli yolcular için abonelik sunabilir; bir yolcu birden fazla otogara kayıtlı olabilir ve her otogar birden fazla yolcuyu barındırabilir. | **N:M** |
| **Rezervasyon - Koltuk** | Her rezervasyon bir yolcunun belirli bir koltuğa atanmasını gerektirir; bir koltuk yalnızca bir rezervasyona atanır (her rezervasyon için tek bir koltuk atanabilir). | **1:1**           |

---

## 3. E-R Diyagramı


---

## 4. Kullanıcı Rolleri ve Gereksinimler

| Kullanıcı Rolü       | Gereksinimler                                              |
|----------------------|------------------------------------------------------------|
| Yolcu Kullanıcı Rolü | Sefer araması yapabilme, rezervasyon oluşturabilme         |
| Firma Yönetici Rolü  | Firma otobüslerini ve sefer bilgilerini yönetebilme        |
| Sistem Yöneticisi Rolü | Tüm otogar ve şehir bilgilerini düzenleyebilme          |

---

