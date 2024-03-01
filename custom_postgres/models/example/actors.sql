/*
Memetakan tabel actors sebagai referensi untuk dipakai di script lainnya
    source(<database>, <table>)
*/
SELECT * FROM {{ source('destination_db', 'actors') }}
