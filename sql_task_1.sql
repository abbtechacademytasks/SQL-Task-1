-- Tapşırıq 1
CREATE SCHEMA magaza;
SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'magaza';

-- Tapşırıq 2
CREATE TABLE magaza.kateqoriyalar (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(50) NOT NULL UNIQUE,
    tesvir VARCHAR(200)
);

SELECT id, ad, tesvir FROM magaza.kateqoriyalar;

-- Tapşırıq 3
CREATE TABLE magaza.mehsullar (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(100) NOT NULL,
    qiymet DECIMAL(10, 2) NOT NULL CHECK (qiymet > 0),
    stok INTEGER NOT NULL CHECK (stok >= 0),
    kateqoriya_id INT REFERENCES magaza.kateqoriyalar(id)
);

SELECT id, ad, qiymet, stok, kateqoriya_id FROM magaza.mehsullar;

-- Tapşırıq 4
CREATE TABLE magaza.musteriler (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    sehir VARCHAR(50),
    qeydiyyat_tarixi DATE DEFAULT CURRENT_DATE
);

SELECT id, ad, soyad, email, sehir, qeydiyyat_tarixi FROM magaza.musteriler;

-- Tapşırıq 5
CREATE TABLE magaza.sifarisler (
    id SERIAL PRIMARY KEY,
    musteri_id INT REFERENCES magaza.musteriler(id),
    mehsul_id INT REFERENCES magaza.mehsullar(id),
    say INTEGER NOT NULL CHECK (say >= 1),
    tarix DATE,
    status VARCHAR(20)
);

SELECT id, musteri_id, mehsul_id, say, tarix, status FROM magaza.sifarisler;

-- Tapşırıq 6
ALTER TABLE magaza.musteriler ADD COLUMN telefon VARCHAR(20);

SELECT id, ad, soyad, email, sehir, qeydiyyat_tarixi, telefon FROM magaza.musteriler;

-- Tapşırıq 7
ALTER TABLE magaza.mehsullar RENAME COLUMN stok TO stok_sayi;

SELECT id, ad, qiymet, stok_sayi, kateqoriya_id FROM magaza.mehsullar;

-- Tapşırıq 8
CREATE INDEX idx_mehsul_kateqoriya ON magaza.mehsullar(kateqoriya_id);

SELECT schemaname, tablename, indexname, indexdef FROM pg_indexes
WHERE schemaname = 'magaza' AND tablename = 'mehsullar';

-- Tapşırıq 9
INSERT INTO magaza.kateqoriyalar (ad, tesvir) VALUES
('Elektronika', 'Elektron cihazlar və aksesuarlar'),
('Geyim', 'Kişi və qadın geyimləri'),
('Kitab', 'Kitablar və ədəbiyyat'),
('İdman', 'İdman avadanlıqları və geyimləri');

SELECT id, ad, tesvir FROM magaza.kateqoriyalar;

-- Tapşırıq 10
INSERT INTO magaza.mehsullar (ad, qiymet, stok_sayi, kateqoriya_id) VALUES
('Smartfon', 599.99, 50, 1),
('Laptop', 999.99, 30, 1),
('Tablet', 299.99, 40, 1),
('T-shirt', 19.99, 100, 2),
('Jeans', 49.99, 80, 2),
('Kərək', 14.99, 0, 2),
('Kitab: SQL Təlimatı', 29.99, 200, 3),
('Kitab: Python Proqramlaşdırma', 39.99, 150, 3),
('Kitab: Data Science', 49.99, 120, 3),
('Basketbol Topu', 39.99, 60, 4),
('Futbol Topu', 29.99, 0, 4),
('Ayaqqabı qaçış üçün', 89.99, 40, 4);

SELECT id, ad, qiymet, stok_sayi, kateqoriya_id FROM magaza.mehsullar;

-- Tapşırıq 11
INSERT INTO magaza.musteriler (ad, soyad, email, sehir, telefon, qeydiyyat_tarixi) VALUES
('Ali', 'Hüseynov', 'ali.huseynov@gmail.com', 'Bakı', '1234567890', '2023-01-01'),
('Leyla', 'Quliyeva', 'leyla.quliyeva@rambler.ru', 'Bakı', '0987654323', '2023-01-02'),
('Fatima', 'Aliyeva', 'fatima.aliyeva@gmail.com', 'Gəncə', '0987654322', '2023-01-03'),
('Rashad', 'Huseynli', 'rashad.huseynli@hotmail.com', 'Sumqayıt', '1122334466', '2023-01-04'),
('Elvin', 'Mammadov', 'elvin.mammadov@mail.ru', 'Şəki', NULL, '2023-01-05'),
('Ilkin', 'Mammadov', 'ilkin.mammadov@asoiu.edu.az', 'Lənkəran', '1122334455', '2023-01-06');

SELECT id, ad, soyad, email, sehir, qeydiyyat_tarixi, telefon FROM magaza.musteriler;

-- Tapşırıq 12
INSERT INTO magaza.sifarisler (musteri_id, mehsul_id, say, tarix, status) VALUES
(1, 1, 2, '2023-01-10', 'gozleyir'),
(2, 4, 1, '2023-01-11', 'gozleyir'),
(3, 7, 3, '2023-01-12', 'gozleyir'),
(4, 10, 1, '2023-01-13', 'gonderildi'),
(5, 2, 1, '2023-01-14', 'gonderildi'),
(6, 5, 2, '2023-01-15', 'gonderildi'),
(1, 3, 1, '2023-01-16', 'catdirildi'),
(2, 6, 4, '2023-01-17', 'catdirildi'),
(3, 8, 2, '2023-01-18', 'catdirildi'),
(4, 9, 1, '2023-01-19', 'legv edildi'),
(5, 11, 3, '2023-01-20', 'legv edildi'),
(6, 12, 1, '2023-01-21', 'legv edildi');

SELECT id, musteri_id, mehsul_id, say, tarix, status FROM magaza.sifarisler;
SELECT status, COUNT(*) AS sifaris_sayi FROM magaza.sifarisler GROUP BY status;

-- Tapşırıq 13
SELECT id, ad, qiymet, kateqoriya_id FROM magaza.mehsullar WHERE kateqoriya_id = (
    SELECT id
    FROM magaza.kateqoriyalar
    WHERE ad = 'Elektronika'
);

UPDATE magaza.mehsullar SET qiymet = qiymet * 1.10 WHERE kateqoriya_id = (
    SELECT id
    FROM magaza.kateqoriyalar
    WHERE ad = 'Elektronika'
);

SELECT id, ad, qiymet, kateqoriya_id FROM magaza.mehsullar WHERE kateqoriya_id = (
    SELECT id
    FROM magaza.kateqoriyalar
    WHERE ad = 'Elektronika'
);

-- Tapşırıq 14
SELECT id, ad, soyad, email, sehir, qeydiyyat_tarixi, telefon FROM magaza.musteriler WHERE telefon IS NULL;

UPDATE magaza.musteriler SET telefon = '+994500000000' WHERE telefon IS NULL;

SELECT id, ad, soyad, email, sehir, qeydiyyat_tarixi, telefon FROM magaza.musteriler WHERE telefon = '+994500000000';
SELECT id, ad, soyad, email, sehir, qeydiyyat_tarixi, telefon FROM magaza.musteriler WHERE telefon IS NULL;

-- Tapşırıq 15
SELECT id, musteri_id, mehsul_id, say, tarix, status FROM magaza.sifarisler WHERE status = 'legv edildi';
DELETE FROM magaza.sifarisler WHERE status = 'legv edildi';
SELECT id, musteri_id, mehsul_id, say, tarix, status FROM magaza.sifarisler WHERE status = 'legv edildi';
SELECT status, COUNT(*) AS sifaris_sayi FROM magaza.sifarisler GROUP BY status;
SELECT COUNT(*) AS umumi_sifaris_sayi FROM magaza.sifarisler;

-- Tapşırıq 16
SELECT id, ad, qiymet FROM magaza.mehsullar WHERE qiymet > 100;

-- Tapşırıq 17
SELECT id, ad, stok_sayi FROM magaza.mehsullar WHERE stok_sayi = 0;

-- Tapşırıq 18
SELECT id, ad, soyad, sehir FROM magaza.musteriler WHERE sehir <> 'Bakı';

-- Tapşırıq 19
SELECT id, ad, qiymet FROM magaza.mehsullar WHERE qiymet BETWEEN 50 AND 200;

-- Tapşırıq 20
SELECT id, musteri_id, mehsul_id, status FROM magaza.sifarisler WHERE status in ('gozleyir', 'gonderildi');

-- Tapşırıq 21
SELECT id, ad, qiymet FROM magaza.mehsullar WHERE ad LIKE 'A%';

-- Tapşırıq 22
SELECT id, ad, soyad, email FROM magaza.musteriler WHERE email LIKE '%gmail%';

-- Tapşırıq 23
SELECT id, ad, soyad, telefon FROM magaza.musteriler WHERE telefon is NULL;
-- Tapşırıq 14-dən sonra NULL telefon qalmadığı üçün nəticə 0 sətirdir

-- Tapşırıq 24
SELECT id, ad, qiymet, stok_sayi FROM magaza.mehsullar WHERE stok_sayi > 5 AND qiymet > 100;

-- Tapşırıq 25
SELECT id, ad, qiymet FROM magaza.mehsullar ORDER BY qiymet ASC;
-- by default olaraq ASC istifadə olunur, amma taskda tələb olunur deyə yazdım

-- Tapşırıq 26
SELECT id, ad, soyad, qeydiyyat_tarixi FROM magaza.musteriler ORDER BY qeydiyyat_tarixi DESC;

-- Tapşırıq 27
SELECT id, ad, kateqoriya_id, qiymet FROM magaza.mehsullar ORDER BY kateqoriya_id ASC, qiymet DESC;
-- by default olaraq ASC istifadə olunur, amma taskda tələb olunur deyə yazdım

-- Tapşırıq 28
SELECT id, ad, qiymet FROM magaza.mehsullar ORDER BY qiymet DESC LIMIT 3;

-- Tapşırıq 29
BEGIN;

INSERT INTO magaza.mehsullar (ad, qiymet, stok_sayi, kateqoriya_id) VALUES
    ('Kamera', 299.99, 15, (
        SELECT id FROM magaza.kateqoriyalar
        WHERE ad = 'Elektronika'
        ));

SELECT id, ad, qiymet, stok_sayi, kateqoriya_id FROM magaza.mehsullar WHERE ad = 'Kamera';

ROLLBACK;

SELECT id, ad, qiymet, stok_sayi, kateqoriya_id FROM magaza.mehsullar WHERE ad = 'Kamera';
-- ROLLBACK-dən sonra əlavə edilən məhsul saxlanılmadı ona görədə nəticə 0 sətirdi.
-- SERIAL üçün yaradılan sequence geri qaytarılmır, yəni 13 artıq istifadə olunmuş sayılır,
-- buna görədə növbəti INSERT 14 ID-sini alır.

-- Tapşırıq 30
SELECT id, ad, soyad, email, sehir FROM magaza.musteriler WHERE email = 'ilkin.mammadov@asoiu.edu.az';

BEGIN;

UPDATE magaza.musteriler SET sehir = 'Quba' WHERE email = 'ilkin.mammadov@asoiu.edu.az';
-- UPDATE-dən sonra dəyişiklik cari transaction daxilində görünür, amma COMMIT olunmadığı üçün daimi deyil.

SELECT id, ad, soyad, email, sehir FROM magaza.musteriler WHERE email = 'ilkin.mammadov@asoiu.edu.az';

COMMIT;

SELECT id, ad, soyad, email, sehir FROM magaza.musteriler WHERE email = 'ilkin.mammadov@asoiu.edu.az';
-- COMMIT-dən sonra şəhər dəyişikliyi bazada saxlanıldı.

-- Tapşırıq 31
SELECT COUNT(*) AS sifaris_sayi, SUM(say) AS umumi_say FROM magaza.sifarisler;

BEGIN;

INSERT INTO magaza.sifarisler (musteri_id, mehsul_id, say, tarix, status) VALUES
(1, 1, 5, '2023-01-22', 'gozleyir');

SAVEPOINT sp1;

INSERT INTO magaza.sifarisler (musteri_id, mehsul_id, say, tarix, status) VALUES
(1, 2, 3, '2023-01-23', 'gozleyir');

SELECT COUNT(*) AS sifaris_sayi, SUM(say) AS umumi_say FROM magaza.sifarisler;

ROLLBACK TO sp1;

SELECT COUNT(*) AS sifaris_sayi, SUM(say) AS umumi_say FROM magaza.sifarisler;

COMMIT;

SELECT COUNT(*) AS sifaris_sayi, SUM(say) AS umumi_say FROM magaza.sifarisler;
-- ROLLBACK TO sp1 yalnız ikinci sifarişi ləğv etdi.
-- Birinci sifariş COMMIT olundu və nəticədə 10 sifariş qaldı.

-- Tapşırıq 32
BEGIN;

SAVEPOINT xetadan_evvel;

SELECT * FROM magaza.movcud_olmayan_cedvel;
-- [42P01] ERROR: relation "magaza.movcud_olmayan_cedvel" does not exist

SELECT id, ad FROM magaza.kateqoriyalar;
-- [25P02] ERROR: current transaction is aborted, commands ignored until end of transaction block

ROLLBACK TO SAVEPOINT xetadan_evvel;

SELECT id, ad, tesvir FROM magaza.kateqoriyalar;

COMMIT;
-- Burada artıq xətadan əvvəlki savepoint-ə geri dönərək cədvəli uğurla sorğuladıq və COMMIT etdik.


-- ƏLAVƏ DƏRS MATERİALLARINDAN NÜMUNƏLƏR:

-- INNER JOIN
SELECT m.id AS mehsul_id, m.ad AS mehsul_ad, m.qiymet, k.ad AS kateqoriya_ad FROM magaza.mehsullar m
JOIN magaza.kateqoriyalar k ON m.kateqoriya_id = k.id;

-- LEFT JOIN
SELECT m.id AS musteri_id, m.ad, m.soyad, COUNT(s.id) AS sifaris_sayi FROM magaza.musteriler m
    LEFT JOIN magaza.sifarisler s ON m.id = s.musteri_id
GROUP BY m.id, m.ad, m.soyad
ORDER BY m.id;

-- RIGHT JOIN
SELECT m.id AS musteri_id, m.ad, m.soyad, COUNT(s.id) AS sifaris_sayi FROM magaza.sifarisler s
    RIGHT JOIN magaza.musteriler m ON s.musteri_id = m.id
GROUP BY m.id, m.ad, m.soyad
ORDER BY m.id;

-- HAVING, MİN, MAX, AVG, COUNT

SELECT
    k.id AS kateqoriya_id,
    k.ad AS kateqoriya_ad,
    COUNT(m.id) AS mehsul_sayi,
    ROUND(AVG(m.qiymet), 2) AS orta_qiymet,
    MIN(m.qiymet) AS minimum_qiymet,
    MAX(m.qiymet) AS maksimum_qiymet
FROM magaza.kateqoriyalar k JOIN magaza.mehsullar m ON k.id = m.kateqoriya_id
GROUP BY k.id, k.ad
HAVING COUNT(m.id) >= 2
ORDER BY k.id;

-- EXPLAIN ANALYZE: sorğunun icra planının yoxlanılması
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, ad, qiymet, kateqoriya_id
FROM magaza.mehsullar
WHERE kateqoriya_id = 1;

--Index Scan using idx_mehsul_kateqoriya on mehsullar  (cost=0.15..8.17 rows=1 width=242) (actual time=0.056..0.091 rows=3 loops=1)
--Index Cond: (kateqoriya_id = 1)
--  Buffers: shared hit=3 dirtied=1
--Planning Time: 0.069 ms
--Execution Time: 0.119 ms
