-- Nama : HAIDUL MAHFUD
-- NIM : 24241130
-- Kelas : D
-- Modul : 3

-- menggunakan database
USE kelas_c_mart;

-- =========================================================================
-- BAGIAN 1: NILAI LITERAL & OPERATOR MATEMATIKA
-- =========================================================================

-- Nilai Literal
-- nilai atau data yang ada pada kolom di dalam tabel
-- Praktek #1
SELECT 77;

-- Praktek #2
SELECT 77 AS angka, true AS logika, 'PTI' AS teks;

-- NULL, literal khusus yang tidak memiliki nilai atau kosong
-- Praktek #3
SELECT NULL AS Kosong;

-- Operator Matematika
-- simbol fungsi, yang digunakan untuk mengoperasikan dua nilai literal angka 
-- +-/*MOD(sisa bagi)
-- setiap operator punya level (), */, +-
-- (10+2)/2 = 6, 10+2/2 = 11
-- Praktek #4
SELECT 5%2 AS sisa_bagi, 5/2 AS hasil_bagi, 5 DIV 2 AS hasil_bagi_2;

-- Latihan Mandiri (Halaman Operator Matematika / Literal)
-- Soal 1: Operasi penambahan
SELECT 10 + 5 AS hasil_penambahan;

-- Soal 2: Operasi perkalian dan pengurangan
SELECT (10 * 3) - 5 AS hasil_operasi;

-- Soal 3: Operasi pembagian dan sisa bagi
SELECT 20 / 4 AS hasil_pembagian, 20 % 3 AS sisa_bagi;

-- Soal 4 (buat soal 1 - 3 dalam 1 query)
SELECT 10 + 5 AS hasil_penambahan, (10 * 3) - 5 AS hasil_operasi, 20 / 4 AS hasil_pembagian, 20 % 3 AS sisa_bagi;

-- Praktek #5, membuat ekspresi matematika dengan kolom dari tabel
-- kalikan kolom qty dengan kolom harga di tabel penjualan
SELECT tgl_transaksi, kode_pelanggan, nama_produk, qty, harga, qty*harga AS total FROM tr_penjualan;


-- =========================================================================
-- BAGIAN 2: OPERATOR PERBANDINGAN & FUNGSI TANGGAL
-- =========================================================================

-- Operator Perbandingan
-- Simbol yang digunakan untuk membandingkan nilai dari dua literal
-- termasuk ekspresi matematika
-- Praktek #6
SELECT 5=5, 5<>5, 5<>4, 5;

-- Praktek #7
SELECT ceiling(3.14);

-- Praktek #8
-- Fungsi Tanggal 
SELECT NOW(), YEAR('2025-05-05'), MONTH(NOW()), DAY(NOW());

-- Praktek #9
-- Cari tahu berapa hari sudah hidup
SELECT datediff(NOW(), '2005-11-27');

-- Latihan Mandiri (Halaman Fungsi & Tanggal)
-- Soal 1: Menampilkan tanggal dan waktu saat ini
SELECT NOW() AS waktu_sekarang;

-- Soal 2: Mengambil komponen tahun dan bulan dari tanggal tertentu
SELECT YEAR('2026-07-07') AS tahun, MONTH('2026-07-07') AS bulan;

-- Soal 3: Menghitung selisih hari antara dua tanggal
SELECT DATEDIFF('2026-12-31', NOW()) AS selisih_hari;

-- Soal 4: Pembulatan ke atas angka desimal
SELECT CEILING(4.75) AS pembulatan_atas;

-- Soal 5: Pembulatan ke bawah angka desimal
SELECT FLOOR(4.75) AS pembulatan_bawah;

-- Praktek #10
-- Cari tahu berapa lama (hari) pelanggan tidak transaksi 
SELECT datediff(NOW(), tgl_transaksi) FROM tr_penjualan;


-- =========================================================================
-- BAGIAN 3: FILTERING DATA (WHERE KLAUSA)
-- =========================================================================

-- WHERE sebagai filtering atau penyaring data dari hasil ekspresi perbandingan
-- Praktek #11
-- Ambil nama produk dan qty yang qty lebih dari 3
SELECT nama_produk, qty FROM tr_penjualan WHERE qty > 3;

-- Praktek #12
-- WHERE dengan multi kriteria
-- Ambil nama_produk dan qty dari penjualan yang qty lebih dari 3 dan bulan transaski = 6
SELECT nama_produk, qty
FROM tr_penjualan
WHERE qty > 3 AND MONTH(tgl_transaksi) = 6;

-- Praktek #13
-- filter menggunakan teks
-- Ambil semua transaksi dari produk dengan nama 'Flashdisk DQLab 32 GB'
SELECT nama_produk, qty
FROM tr_penjualan
WHERE nama_produk = 'Flashdisk DQLab 32 GB';

-- Operator Perbandingan LIKE
-- filter teks dengan pola tertentu
-- Praktek #14
SELECT nama_produk FROM tr_penjualan
WHERE nama_produk LIKE 'Flashdisk%';


-- =========================================================================
-- BAGIAN 4: PENGURUTAN DATA (ORDER BY)
-- =========================================================================

-- Latihan Mandiri - ORDER BY Dasar (Halaman 16)
-- Soal 1: Tampilkan semua kolom tabel tr_penjualan_dqlab urut qty dan tgl_transaksi
SELECT * FROM tr_penjualan_dqlab ORDER BY qty, tgl_transaksi;

-- Soal 2: Tampilkan semua kolom tabel ms_pelanggan urut nama_pelanggan
SELECT * FROM ms_pelanggan ORDER BY nama_pelanggan;

-- Soal 3: Tampilkan semua kolom tabel ms_pelanggan urut alamat
SELECT * FROM ms_pelanggan ORDER BY alamat;

-- Latihan Mandiri - ORDER BY dengan ASC & DESC (Halaman 28)
-- Soal 1: Urut tgl_transaksi secara descending dan qty secara ascending
SELECT * FROM tr_penjualan_dqlab ORDER BY tgl_transaksi DESC, qty ASC;

-- Soal 2: Urut nama_pelanggan secara descending
SELECT * FROM ms_pelanggan ORDER BY nama_pelanggan DESC;

-- Soal 3: Urut alamat secara descending
SELECT * FROM ms_pelanggan ORDER BY alamat DESC;

-- Latihan Mandiri - ORDER BY dengan Ekspresi Matematika (Halaman 34)
-- Soal: Pengurutan total harga (jumlah barang * harga - diskon) terbesar
SELECT *, (qty * harga) - diskon AS total_harga 
FROM tr_penjualan_dqlab 
ORDER BY total_harga DESC;

-- Latihan Mandiri - Kombinasi WHERE dan ORDER BY (Halaman 41)
-- Soal 1: Transaksi yang memiliki diskon diurutkan berdasarkan harga tertinggi
SELECT * FROM tr_penjualan_dqlab 
WHERE diskon > 0 
ORDER BY harga DESC;

-- Soal 2: Nama produk, qty, harga dengan harga minimal Rp100.000 urut harga tertinggi
SELECT nama_produk, qty, harga 
FROM tr_penjualan_dqlab 
WHERE harga >= 100000 
ORDER BY harga DESC;

-- Soal 3: Harga minimal Rp100.000 OR produk berawalan 'T' urut diskon tertinggi
SELECT nama_produk, qty, harga, diskon 
FROM tr_penjualan_dqlab 
WHERE harga >= 100000 OR nama_produk LIKE 'T%' 
ORDER BY diskon DESC;


-- =========================================================================
-- BAGIAN 5: AGREGASI & PENGELOMPOKAN (GROUP BY & HAVING)
-- =========================================================================

-- Latihan Mandiri - GROUP BY dan HAVING (Halaman 98)
-- Soal 1: Produk yang total jumlah terjual per kelompok di atas nilai 4
SELECT nama_produk, SUM(qty) AS total_terjual 
FROM tr_penjualan_dqlab 
GROUP BY nama_produk 
HAVING SUM(qty) > 4;

-- Soal 2: Produk yang total jumlah produk terjual per kelompok sama dengan 9
SELECT nama_produk, SUM(qty) AS total_terjual 
FROM tr_penjualan_dqlab 
GROUP BY nama_produk 
HAVING SUM(qty) = 9;

-- Soal 3: Kelompok produk dan total nilai penjualan urut terbesar
SELECT nama_produk, SUM((harga * qty) - diskon) AS total_penjualan 
FROM tr_penjualan_dqlab 
GROUP BY nama_produk 
ORDER BY total_penjualan DESC;
