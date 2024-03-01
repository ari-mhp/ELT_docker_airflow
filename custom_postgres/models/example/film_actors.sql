/*
Memetakan tabel film_actors sebagai referensi untuk dipakai di script lainnya
    source(<database>, <table>)
*/
SELECT * FROM {{ source('destination_db', 'film_actors') }}