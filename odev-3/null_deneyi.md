# NULL Deneyleri

## Deney 1: COUNT(*) ve COUNT(phone)

**Sorgu:**
SELECT COUNT(*) AS toplam_musteri, COUNT(phone) AS telefonu_olan_musteri FROM customer;

**Gerçek sonuç:** COUNT(*) = 8, COUNT(phone) = 5.

**Yorum:** COUNT(*) bütün satırları sayar. COUNT(phone) ise NULL olmayan telefon değerlerini sayar. Üç müşterinin telefon bilgisi NULL olduğu için sonuçlar farklıdır.

## Deney 2: AVG(age) ve SUM(age) / COUNT(*)

**Sorgu:**
SELECT AVG(age), SUM(age) / COUNT(*) FROM customer;

**Gerçek sonuç:** AVG(age) = 20.8333333333333333, SUM(age) / COUNT(*) = 15.

**Yorum:** AVG(age) NULL yaşları hesaba katmaz. SUM(age) de NULL değerleri toplama dahil etmez. COUNT(*) ise sekiz satırın tamamını sayar. Ayrıca PostgreSQL tam sayı bölmesinde küsurat kısmını atar; 125 / 8 sonucu 15 olur.
