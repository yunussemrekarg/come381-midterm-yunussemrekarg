\## Ödev 2



\### Bölüm E – AI Kullanımı



\*\*AI aracına verilen prompt (aynen):\*\*



Gym yönetim sistemi için PostgreSQL kullanarak relational division (bölme) işlemini gerçekleştiren bir SQL sorgusu yaz. member, session\_registration ve training\_session tablolarını kullan. Sistemde bulunan bütün seans kategorilerinde en az bir seansa katılmış üyeleri bul. Sorguda iç içe NOT EXISTS kullan ve her üyenin bütün kategorilere katılmış olmasını garanti et. Sorguyu açıkla.



\*\*AI tarafından önerilen yaklaşım:\*\*



İç içe NOT EXISTS kullanılır. Dış NOT EXISTS, sistemdeki kategorilerden üyenin katılmadığı herhangi bir kategori bulunup bulunmadığını kontrol eder. Böyle bir kategori yoksa üye sonuçlara eklenir.



\*\*Kullanılan SQL sorgusu:\*\*



```sql

SELECT DISTINCT m.member\_id, m.first\_name, m.last\_name

FROM member m

WHERE NOT EXISTS (

&#x20;   SELECT 1

&#x20;   FROM (

&#x20;       SELECT DISTINCT category

&#x20;       FROM training\_session

&#x20;   ) AS all\_categories

&#x20;   WHERE NOT EXISTS (

&#x20;       SELECT 1

&#x20;       FROM session\_registration sr

&#x20;       JOIN training\_session ts ON sr.session\_id = ts.session\_id

&#x20;       WHERE sr.member\_id = m.member\_id

&#x20;         AND ts.category = all\_categories.category

&#x20;   )

);

```



\*\*Test ve karşılaştırma:\*\*



Sorgu kendi PostgreSQL veritabanımda çalıştırılmıştır. Sonuç olarak yalnızca Ali Yilmaz bulunmuştur. Ali, sistemdeki fitness, wellness ve sports kategorilerinin tamamında en az bir seansa katılmıştır.



Ayşe Kaya ise fitness ve wellness kategorilerine katılmış, ancak sports kategorisine katılmamıştır. Bu nedenle sonuçlarda yer almamıştır.



\*\*Değerlendirme:\*\*



AI tarafından önerilen sorgu doğru sonuç vermiştir. Yakın geçiş testi olarak bütün kategorilere katılmayan Ayşe Kaya verisi kullanılmıştır. Böylece sorgunun yalnızca bazı kategorilere katılan üyeleri yanlışlıkla sonuçlara eklemediği doğrulanmıştır.
