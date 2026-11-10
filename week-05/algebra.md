\# Bölüm D – İlişkisel Cebir



\## Veri Kümesi



Sorgular gym yönetim sistemindeki `member`, `trainer`, `training\_session` ve `session\_registration` tabloları üzerinde çalıştırılmıştır.



\## D1 – Belirli bir tarihteki planlanmış seanslar



\*\*Soru:\*\* 1 Aralık 2026 tarihinde planlanmış seansların tarihini, başlangıç saatini ve kapasitesini listeleyin.



\*\*İlişkisel cebir:\*\*



\\\[

\\pi\_{session\\\_date,start\\\_time,capacity}

(\\sigma\_{session\\\_date='2026-12-01' \\land status='scheduled'}(training\\\_session))

\\]



\*\*SQL karşılığı:\*\* `algebra.sql` dosyasındaki D1 sorgusu.



\*\*DISTINCT:\*\* İlişkisel cebirde projeksiyon tekrarları kaldırır. SQL'de aynı davranışı sağlamak için `DISTINCT` kullanılır.



\## D2 – Üyelerin katıldığı seanslar



\*\*Soru:\*\* Üyelerin adlarını ve katıldıkları seansların tarihlerini listeleyin.



\*\*İlişkisel cebir:\*\*



\\\[

\\pi\_{first\\\_name,last\\\_name,session\\\_date}

(member \\bowtie session\\\_registration \\bowtie training\\\_session)

\\]



\*\*SQL karşılığı:\*\* `algebra.sql` dosyasındaki D2 sorgusu.



\*\*DISTINCT:\*\* Bir üye birden fazla seansa katılabilir. Tekrarlanan sonuç satırlarını kaldırmak için SQL'de `DISTINCT` kullanılır.



\## D3 – İki kategoriye katılan üyeler



\*\*Soru:\*\* Hem fitness hem wellness kategorisindeki seanslara katılan üyeleri bulun.



\*\*İlişkisel cebir:\*\*



\\\[

\\pi\_{member\\\_id}(FitnessMembers)

\\cap

\\pi\_{member\\\_id}(WellnessMembers)

\\]



\*\*SQL karşılığı:\*\* `algebra.sql` dosyasındaki D3 sorgusu.



\*\*DISTINCT:\*\* Küme işlemleri tekrarları kaldırır. SQL'de `INTERSECT` de bu davranışı sağlar.



\## D4 – Hiçbir seansa kayıt olmayan üyeler



\*\*Soru:\*\* Hiçbir antrenman seansına kayıt olmayan üyeleri bulun.



\*\*İlişkisel cebir:\*\*



\\\[

\\pi\_{member\\\_id}(member)

\-

\\pi\_{member\\\_id}(session\\\_registration)

\\]



\*\*SQL karşılığı:\*\* `algebra.sql` dosyasında hem `EXCEPT` hem de `NOT EXISTS` kullanılmıştır.



\*\*DISTINCT:\*\* İlişkisel cebir küme mantığıyla çalışır. SQL'de `EXCEPT` tekrarları kaldırır; `NOT EXISTS` ise eşleşme kontrolü yapar.



\## D5 – Antrenör ve seans bilgileri



\*\*Soru:\*\* Antrenörün adı ile seansın tarihini listeleyin.



\*\*İlişkisel cebir:\*\*



\\\[

\\rho\_{T}(trainer)

\\bowtie\_{T.trainer\\\_id=S.trainer\\\_id}

\\rho\_{S}(training\\\_session)

\\]



\*\*SQL karşılığı:\*\* `algebra.sql` dosyasındaki D5 sorgusu.



\*\*DISTINCT:\*\* Aynı antrenör birden fazla seans verebilir. Tekrarları kaldırmak için SQL'de `DISTINCT` kullanılır.



\## D6 – Tüm kategorilere katılan üyeler (Division)



\*\*Soru:\*\* Sistemde bulunan bütün seans kategorilerinde en az bir seansa katılmış üyeleri bulun.



\*\*İlişkisel cebir:\*\*



\\\[

R(member\\\_id,category)

\\div

C(category)

\\]



Burada R, üyelerin katıldığı kategorileri; C ise sistemdeki tüm kategorileri temsil eder.



\*\*SQL karşılığı:\*\* `algebra.sql` dosyasında iç içe `NOT EXISTS` kullanılmıştır.



\*\*Yöntem açıklaması:\*\* İç içe `NOT EXISTS`, bir üyenin katılmadığı herhangi bir kategori bulunup bulunmadığını kontrol eder. Eksik kategorisi olmayan üyeler sonuçta yer alır.



\*\*DISTINCT:\*\* Bölme işlemi üye kimliklerini küme olarak döndürür. SQL sorgusunda tekrarları önlemek için `DISTINCT` kullanılır.



\## D1 için İlişkisel Kalkül



\\\[

\\{t \\mid training\\\_session(t)

\\land t.session\\\_date='2026-12-01'

\\land t.status='scheduled'\\}

\\]



Bu ifade, 1 Aralık 2026 tarihinde planlanmış olan seansları tanımlar.
