\# Bölüm C – ON DELETE Davranışları



\## 1. Foreign Key Silme Politikaları



| Foreign Key | ON DELETE Politikası | Gerekçe |

|---|---|---|

| `fk\_training\_session\_trainer` | RESTRICT | Bir antrenörün verdiği seanslar varken antrenörün silinmesini engeller. |

| `fk\_registration\_member` | CASCADE | Bir üye silindiğinde o üyeye ait kayıtlar da silinir. |

| `fk\_registration\_session` | CASCADE | Bir seans silindiğinde o seansa ait kayıtlar da silinir. |



Bu tasarımda CASCADE ve RESTRICT olmak üzere iki farklı silme politikası kullanılmıştır.



\## 2. CASCADE Davranışının Kanıtı



Aşağıdaki SQL işlemleri, bir üye silindiğinde ona bağlı kayıtların da silindiğini gösterir:



```sql

BEGIN;



\-- Test için mevcut üyeyi bir seansa kaydet.

INSERT INTO session\_registration (member\_id, session\_id)

VALUES (1, 1);



\-- Silme öncesindeki kayıt sayısı.

SELECT COUNT(\*) AS before\_delete

FROM session\_registration

WHERE member\_id = 1;



\-- Üyeyi sil.

DELETE FROM member

WHERE member\_id = 1;



\-- Silme sonrasındaki kayıt sayısı.

SELECT COUNT(\*) AS after\_delete

FROM session\_registration

WHERE member\_id = 1;



ROLLBACK;

```



Beklenen sonuç:

\- Silme öncesinde kayıt sayısı: 1

\- Silme sonrasında kayıt sayısı: 0



`ROLLBACK` işlemi test verilerini geri alır.



\## 3. RESTRICT ve NO ACTION Farkı



RESTRICT, ilişkili kayıt bulunduğunda silme işlemini hemen engeller. NO ACTION ise varsayılan olarak işlemin sonunda foreign key kontrolü yapar; ertelenebilir bir constraint kullanıldığında kontrol daha sonraya bırakılabilir.
