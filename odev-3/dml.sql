\set VERBOSITY verbose

BEGIN;

-- Güncelleme öncesi sıcak içecek fiyatlarını görüntüle.
SELECT name, price
FROM product
WHERE category = 'Sıcak İçecek'
ORDER BY product_id;

-- Sıcak içeceklerin fiyatını 5 TL artır.
UPDATE product
SET price = price + 5
WHERE category = 'Sıcak İçecek';

-- Güncelleme sonrası fiyatları görüntüle.
SELECT name, price
FROM product
WHERE category = 'Sıcak İçecek'
ORDER BY product_id;

-- Olmayan ürün numarasıyla hatalı kayıt eklemeyi dene.
INSERT INTO order_item (order_id, product_id, quantity)
VALUES (1, 999, 1);

-- İşlemleri geri al.
ROLLBACK;

-- Geri alma sonrası fiyatları tekrar görüntüle.
SELECT name, price
FROM product
WHERE category = 'Sıcak İçecek'
ORDER BY product_id;