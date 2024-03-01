# ELT Docker with Airflow and DBT

Repository ini berisi project khusus Extract, Load, dan Transform (ELT) dengan menggunakan Docker, PostgreSQL untuk database, framework Data Build Tool (DBT) dan Apache Airflow
<br>
<br>

# DBT

## Install DBT (Windows)

- Pastikan sudah terinstal python di windows [(Python)](https://www.python.org/)
- Buat virtual environtment python : 
```
python -m venv dbt-env
```
- Ubah ke folder virtual environtment yang baru dibuat :
```
 cd dbt-env
 ```
- Aktifkan virtual environtment di terminal : 
```
.\Script\activate
```
- Install DBT core dan plugin postgress : 
```
python -m pip install dbt-postgres
```
- Cek DBT sudah terinstal : 
```
dbt --version
```

## DBT Initialize

Setelah install DBT, selanjutnya initialize DBT di folder project
```
dbt init
```
Lalu isikan konfigurasi berikut pada terminal :

- dbt project = custom_postgres (nama project DBT, bebas)
- hostname = host.docker.internal (jika memakai Docker)
- port = 5434 (Sesuaikan dengan port pada container pada host, bisa diganti sesuai port target DBT)
- user = postgres (sesuaikan dengan target container)
- pass = secret (sesuaikan dengan target container)
- dbname = destination_db (sesuaikan dengan target container)
- schema = public
- threads = 1

Konfigurasi tersebut akan tersimpan di `C:\Users\<Username>\.dbt\profiles.yml`

- Selanjutnya buka folder DBT project -> dbt_project.yml
- Pada bagian models -> custom_postgres -> example -> +materialized: view
- Ganti `view` dengan `table` agar hasil dari DBT terlihat

## Models
- Model yang akan dibuat dari database target DBT tersimpan di folder `models/example` yang berupa file SQL.
- Pada folder tersebut terdapat file `sources.yml` yang berisi tentang sumber data yang digunakan untuk DBT
- Juga terdapat file `schema.yml` yang berisi tentang skema dari model yang dibuat, terdiri dari tabel dengan masing-masing kolomnya.

## Macros
- Macro dapat mempermudah pengerjaan DBT, yaitu dengan menyimpan potongan kode yang dapat digunakan berkali-kali di file lain.
- Tersimpan di folder `macros` dan berupa file SQL.
- Untuk membuat macro dapat menggunakan penulisan berikut :
```
{% macro <nama macro>() %}

    <Tulis potongan kode disini>

{% endmacro %}
```
- Untuk menggunakan macro di file lain :
```
{{ <nama macro>() }}
```
<br>
<br>

# PostgreSQL

PostgreSQL yang digunakan sebagai database berada pada Docker Container. Untuk mengakses dan melihat database PostgreSQL, dapat menggunakan command berikut di terminal :
```
docker exec -it <nama-container> psql -U <username>
```

Contoh :
```
docker exec -it elt-airflow-destination_postgres-1 psql -U postgres
```

Setelah masuk ke PostgreSQL, dapat menggunakan command berikut :
- \l = untuk melihat semua database\
contoh hasil :
```
List of databases
      Name      |  Owner   | Encoding |  Collate   |   Ctype    | ICU Locale | Locale Provider |   Access privileges
----------------+----------+----------+------------+------------+------------+-----------------+-----------------------
 destination_db | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
 postgres       | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            |
 template0      | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
                |          |          |            |            |            |                 | postgres=CTc/postgres
 template1      | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres          +
                |          |          |            |            |            |                 | postgres=CTc/postgres
(4 rows)
```
- \c \<nama-database> = untuk mengakses/mengganti ke database yang dipilih
- \dt = untuk melihat semua relasi tabel pada database\
contoh :
```
             List of relations
 Schema |      Name      | Type  |  Owner
--------+----------------+-------+----------
 public | actors         | table | postgres
 public | film_actors    | table | postgres
 public | film_category  | table | postgres
 public | film_ratings   | table | postgres
 public | films          | table | postgres
 public | specific_movie | table | postgres
 public | users          | table | postgres
(7 rows)
```
- \\? = untuk melihat semua comand PostgreSQL
- \q = untuk keluar dari PostgreSQL
