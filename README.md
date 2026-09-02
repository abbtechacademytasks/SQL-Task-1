# SQL Task 1 - Onlayn mağaza verilənlər bazası

Bu layihədə PostgreSQL üzərində `magaza` sxemi yaradılır və kateqoriyalar, məhsullar, müştərilər və sifarişlər idarə olunur.

## Tapşırıqların siyahısı

### DDL

1. `magaza` sxemini yaratmaq.
2. `kateqoriyalar` cədvəlini yaratmaq.
3. `mehsullar` cədvəlini yaratmaq.
4. `musteriler` cədvəlini yaratmaq.
5. `sifarisler` cədvəlini yaratmaq.
6. `musteriler` cədvəlinə `telefon` sütunu əlavə etmək.
7. `mehsullar.stok` sütununu `stok_sayi` olaraq adlandırmaq.
8. `mehsullar(kateqoriya_id)` üçün `idx_mehsul_kateqoriya` indeksini yaratmaq.

### DML

9. Dörd kateqoriya əlavə etmək.
10. Ən azı on məhsul əlavə etmək.
11. Altı müştəri əlavə etmək.
12. Müxtəlif statuslarla on iki sifariş əlavə etmək.
13. Elektronika məhsullarının qiymətini 10% artırmaq.
14. Telefonu `NULL` olan müştərilərin telefonunu yeniləmək.
15. Statusu `legv edildi` olan sifarişləri silmək.

### DQL: filtrləmə

16. Qiyməti 100-dən böyük məhsulları tapmaq.
17. Stok sayı sıfır olan məhsulları tapmaq.
18. Şəhəri Bakı olmayan müştəriləri tapmaq.
19. Qiyməti 50-200 aralığında olan məhsulları tapmaq.
20. Statusu `gozleyir` və ya `gonderildi` olan sifarişləri tapmaq.
21. Adı `A` hərfi ilə başlayan məhsulları tapmaq.
22. Email ünvanında `gmail` olan müştəriləri tapmaq.
23. Telefonu `NULL` olan müştəriləri tapmaq.
24. Qiyməti 100-dən və stok sayı 5-dən böyük məhsulları tapmaq.

### DQL: sıralama

25. Məhsulları qiymətə görə artan sıra ilə göstərmək.
26. Müştəriləri qeydiyyat tarixinə görə azalan sıra ilə göstərmək.
27. Məhsulları kateqoriyaya görə artan, qiymətə görə azalan sıra ilə göstərmək.
28. Ən bahalı üç məhsulu göstərmək.

### TCL

29. Məhsul əlavə edib nəticəni yoxlamaq və `ROLLBACK` etmək.
30. Müştərinin şəhərini dəyişib `COMMIT` etmək.
31. İki sifariş arasında `SAVEPOINT` yaradıb yalnız ikinci sifarişi geri qaytarmaq.
32. Transaction daxilində qəsdən xəta yaradıb düzgün sorğu ilə işi davam etdirmək.

## İstifadə olunan mövzular

- DDL: `CREATE`, `ALTER`, constraint-lər və index;
- DML: `INSERT`, `UPDATE`, `DELETE`;
- DQL: `WHERE`, `BETWEEN`, `IN`, `LIKE`, `IS NULL`, `ORDER BY`, `LIMIT`;
- TCL: `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`;
- əlavə olaraq `JOIN`, `GROUP BY`, `HAVING`, aqreqat funksiyalar və `EXPLAIN ANALYZE`.

## Fayllar

- `compose.yaml` - PostgreSQL 17 konteynerinin konfiqurasiyası;
- `sql_task_1.sql` - 32 tapşırıq və əlavə dərs nümunələri.