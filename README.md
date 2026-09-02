# SQL Task 1 - Onlayn mağaza verilənlər bazası

Bu layihədə PostgreSQL üzərində `magaza` sxemi yaradılır və kateqoriyalar, məhsullar, müştərilər və sifarişlər idarə olunur.

## İstifadə olunan mövzular

- DDL: `CREATE`, `ALTER`, constraint-lər və index;
- DML: `INSERT`, `UPDATE`, `DELETE`;
- DQL: `WHERE`, `BETWEEN`, `IN`, `LIKE`, `IS NULL`, `ORDER BY`, `LIMIT`;
- TCL: `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`;
- əlavə olaraq `JOIN`, `GROUP BY`, `HAVING`, aqreqat funksiyalar və `EXPLAIN ANALYZE`.

## Fayllar

- `compose.yaml` - PostgreSQL 17 konteynerinin konfiqurasiyası;
- `sql_task_1.sql` - 32 tapşırıq və əlavə dərs nümunələri.

## PostgreSQL-i işə salmaq

```powershell
docker compose up -d
docker compose ps
```

Lokal qoşulma məlumatları:

| Parametr | Dəyər |
|---|---|
| Host | `localhost` |
| Port | `5432` |
| Database | `sql_task_1` |
| User | `postgres` |
| Password | `postgres` |

Bu məlumatlar yalnız lokal tədris mühiti üçündür.

## İcra qaydası

`sql_task_1.sql` faylını DataGrip və ya başqa PostgreSQL klientində açıb tapşırıqları sıra ilə icra etmək lazımdır. Hər əməliyyatdan sonra nəticə `SELECT` sorğusu ilə yoxlanılır.

`Tapşırıq 32` daxilində xəta qəsdən yaradılır. Əvvəl `42P01`, sonra transaction-ın aborted vəziyyətini göstərən `25P02` alınır. `ROLLBACK TO SAVEPOINT` icra edildikdən sonra düzgün sorğu işləyir və transaction `COMMIT` ilə bağlanır. Bu hissəni eyni connection daxilində addım-addım icra etmək lazımdır.

## Dayandırmaq

```powershell
docker compose down
```
