\# COME 381 – Ödev 2



\## Klasör İçeriği



\- `constraints.sql`: Bölüm A – Constraint tanımları

\- `violations.sql`: Bölüm B – Constraint ihlal testleri

\- `violations\_output.txt`: PostgreSQL testlerinin gerçek çıktısı

\- `on\_delete.md`: Bölüm C – ON DELETE politikaları

\- `seed.sql`: Bölüm D – Test verileri

\- `algebra.md`: Bölüm D – İlişkisel cebir açıklamaları

\- `algebra.sql`: Bölüm D – SQL sorguları



\## Çalıştırma Sırası



Komutlar proje ana dizininden çalıştırılmalıdır:



1\. `psql -d come381\_test -f sql/schema.sql`

2\. `psql -d come381\_test -f week-05/constraints.sql`

3\. `psql -d come381\_test -f week-05/violations.sql`

4\. `psql -d come381\_test -f week-05/seed.sql`

5\. `psql -d come381\_test -f week-05/algebra.sql`



Önemli: `violations.sql` test başlangıcında tabloları TRUNCATE ile temizler. Bu nedenle `seed.sql`, ihlal testlerinden sonra çalıştırılmalıdır.



\## Bölüm B – NULL Testi



`category` sütununda CHECK kısıtlaması bulunmasına rağmen NOT NULL kısıtlaması bulunmamaktadır. NULL testi sırasında bu sütuna NULL değeri eklenmiş ve işlem başarılı olmuştur.



PostgreSQL'de CHECK koşulu FALSE olduğunda satır reddedilir. Koşul NULL/UNKNOWN olduğunda ise CHECK ihlali oluşmaz. NULL değerini de yasaklamak için ayrıca NOT NULL kısıtlaması gerekir.



\## Bölüm C – ON DELETE



Üye ve seans silindiğinde bunlara bağlı kayıtlar CASCADE ile silinir. Bir antrenörün ilişkili seansı varsa RESTRICT silme işlemini engeller. CASCADE davranışı `on\_delete.md` dosyasındaki test ile gösterilmiştir.



\## Bölüm D – İlişkisel Cebir



D1–D6 sorguları PostgreSQL üzerinde çalıştırılmıştır.



\- D4 için EXCEPT ve NOT EXISTS aynı sonucu vermiştir.

\- D5 self-join sorgusu aynı uzmanlık alanındaki antrenörleri bulmuştur.

\- D6 division sorgusu bütün seans kategorilerine katılan üyeyi bulmuştur.



D4 testinde hiçbir seansa kayıt olmayan Emre Kurt; D6 testinde ise yalnızca iki kategoriye katılan ve bir kategoriyi kaçıran Ayşe Kaya kullanılmıştır. Bu veriler sorguların farklı durumları ayırt etmesini sağlar.
