CREATE DATABASE umkm_jabar;

-- 1. Cek tabel rasio_rumah_jabar
SELECT * FROM umkm_jabar;

-- 2. Tunjukkan data umkm di Kota Bogor
SELECT * FROM umkm_jabar WHERE nama_kabupaten_kota = "KOTA BOGOR";

-- 3. Tunjukkan data umkm dari tahun 2019 dan disusun berdasarkan jenis_usaha
SELECT * FROM umkm_jabar WHERE tahun >= 2018 ORDER BY jenis_usaha, tahun;

-- 4. Soal nomor 3 namun dibatasi barisnya hanya sampai 15 baris
SELECT * FROM umkm_jabar WHERE tahun >= 2018 ORDER BY jenis_usaha, tahun LIMIT 15;

-- 5. Jenis_usaha apa saja yang tersedia di dalam dataset?
SELECT DISTINCT jenis_usaha FROM umkm_jabar;

-- 6. Tunjukkan seluruh data hanya jenis usaha AKSESORIS dan BATIK
SELECT * FROM umkm_jabar WHERE jenis_usaha IN ("AKSESORIS", "BATIK");
SELECT * FROM umkm_jabar WHERE jenis_usaha = "AKSESORIS" OR jenis_usaha = "BATIK";

-- 7. Tunjukkan seluruh data dengan jenis usaha DEKORASI di kabupaten BANDUNG
SELECT * FROM umkm_jabar WHERE jenis_usaha = "DEKORASI" AND nama_kabupaten_kota = "KABUPATEN BANDUNG";

-- 8. Tunjukkan seluruh data selain kategori usaha AGRIBISNIS, BATIK, dan MEBEL
SELECT * FROM umkm_jabar WHERE jenis_usaha NOT IN ("AGRIBISNIS", "BATIK", "MEBEL");

-- 9. Dari tahun 2018 sampai dengan 2020, bagaimana tren jumlah umkm di kabupaten CIANJUR untuk kategori usaha MAKANAN ?
SELECT nama_kabupaten_kota, jenis_usaha, jumlah_umkm, satuan, tahun FROM umkm_jabar 
WHERE tahun <= 2020 AND tahun >= 2018 AND nama_kabupaten_kota = "KABUPATEN BANDUNG BARAT" AND jenis_usaha = "MAKANAN";

-- 10. Di antara Kota Bandung, Kabupaten Bandung dan Kabupaten Bandung Barat, dimanakah umkm batik terpusat
SELECT * FROM umkm_jabar WHERE nama_kabupaten_kota LIKE "%BANDUNG%" AND jenis_usaha = "KULINER"
AND tahun = 2022;

-- 11. Kabupaten/Kota mana saja yang memiliki angka 7 pada digit kode kota tersebut
SELECT * FROM umkm_jabar WHERE kode_kabupaten_kota LIKE "__1%";

SELECT DISTINCT kode_kabupaten_kota, nama_kabupaten_kota FROM umkm_jabar WHERE kode_kabupaten_kota LIKE "__7%";

-- 12. Berapa jumlah baris dari tabel umkm_jabar
SELECT COUNT(*) AS jumlah_baris FROM umkm_jabar;

-- 13. Berapa jumlah umkm di kabupaten bekasi pada tahun 2019
SELECT SUM(jumlah_umkm) AS jumlah_umkm_kab_bekasi_2019 FROM umkm_jabar 
WHERE nama_kabupaten_kota = "KABUPATEN BEKASI" AND tahun = 2019;

-- 14. Bagaimana tren jumlah umkm di kabupaten Bandung Barat dari tahun 2017 sampai dengan 2022
SELECT tahun, SUM(jumlah_umkm) AS jumlah_umkm_kab_bandung_barat FROM umkm_jabar WHERE nama_kabupaten_kota = "KABUPATEN BANDUNG BARAT" 
AND tahun >= 2017 AND tahun <=2022 GROUP BY tahun;

-- 15. Berapa jumlah rata-rata umkm setiap kategori usaha per kabupaten di jawa barat pada tahun 2020
SELECT tahun, jenis_usaha, AVG(jumlah_umkm) AS rerata_jumlah_umkm 
FROM umkm_jabar WHERE tahun = 2020 GROUP BY tahun, jenis_usaha ORDER BY jenis_usaha;

-- 16. Nilai minimum dan maksimum dari kolom jumlah_umkm
SELECT MIN(jumlah_umkm) AS min_jumlah_umkm, MAX(jumlah_umkm) AS max_jumlah_umkm FROM umkm_jabar;

-- 17. Kabupaten atau kota apa yang memiliki jumlah UMKM kurang dari 100.000 pada tahun 2022
SELECT nama_kabupaten_kota, SUM(jumlah_umkm) AS jumlah_umkm_tahun_2022 FROM umkm_jabar 
WHERE tahun = 2022 GROUP BY nama_kabupaten_kota HAVING jumlah_umkm_tahun_2022 < 120;

-- 18. 