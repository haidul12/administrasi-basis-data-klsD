-- Nama		: HAIDUL MAHFUD
-- NIM		: 24241130
-- Kelas	: D
-- Modul	: 4


-- menggunakan database
USE kelas_e_mart;

-- =========================================================================
-- BAGIAN 1: CONTROL PENGURUTAN DATA (ORDER BY)
-- =========================================================================

-- ORDER BY
-- Fungsinya untuk mengurutkan data hasil query secara ASC ataupun DESC
-- data yang diurutkan dapat dari kolom atau hasil pengelolaan (op, mat) kolom

-- Praktek #1: ORDER BY dengan satu kolom
-- Ambil nama produk dan qty dari penjualan urut berdasarkan qty
SELECT nama_produk, qty FROM tr_penjualan ORDER BY qty;

-- Praktek #2: ORDER BY dengan dua kolom
-- Ambil nama_produk dan qty dari penjualan urut qty dan nama produk
SELECT nama_produk, qty FROM tr_penjualan ORDER BY qty, nama_produk;


-- Latihan Mandiri - ORDER BY Dasar (Halaman 16)
-- Soal 1
SELECT * FROM tr_penjualan_dqlab ORDER BY qty, tgl_transaksi;

-- Soal 2
SELECT * FROM ms_pelanggan ORDER BY nama_pelanggan;

-- Soal 3
SELECT * FROM ms_pelanggan ORDER BY alamat;


-- Praktek #3: Menggunakan DESC
-- ORDER BY dari nilai terbesar ke terkecil gunakan desc
SELECT nama_produk, qty FROM tr_penjualan ORDER BY qty DESC;

-- Praktek #4: Menggunakan ASC dan DESC berbarengan
-- Menggunakan ASC dan DESC dalam satu query
SELECT nama_produk, qty FROM tr_penjualan ORDER BY qty DESC, nama_produk ASC;


-- Latihan Mandiri - ORDER BY ASC & DESC (Halaman 28)
-- Soal 1
SELECT * FROM tr_penjualan_dqlab ORDER BY tgl_transaksi DESC, qty ASC;

-- Soal 2
SELECT * FROM ms_pelanggan ORDER BY nama_pelanggan DESC;

-- Soal 3
SELECT * FROM ms_pelanggan ORDER BY alamat DESC;


-- Praktek #5: Menggunakan perhitungan pada ORDER BY
-- ORDER BY digunakan dari hasil operasi matematika ataupun dari fungsi
-- Ambil nama produk, harga, qty, dan total (qty*harga) urut total terbesar
SELECT nama_produk, harga, qty, qty*harga AS total
FROM tr_penjualan ORDER BY total DESC;


-- Latihan Mandiri - ORDER BY Ekspresi & Kombinasi WHERE (Halaman 34 & 41)
-- Latihan Mandiri Halaman 34 (Ekspresi Matematika)
SELECT *, (qty * harga) - diskon AS total_harga 
FROM tr_penjualan_dqlab 
ORDER BY total_harga DESC;

-- Latihan Mandiri Halaman 41 (Kombinasi WHERE dan ORDER BY)
-- Soal 1
SELECT * FROM tr_penjualan_dqlab 
WHERE diskon > 0 
ORDER BY harga DESC;

-- Soal 2
SELECT nama_produk, qty, harga 
FROM tr_penjualan_dqlab 
WHERE harga >= 100000 
ORDER BY harga DESC;

-- Soal 3
SELECT nama_produk, qty, harga, diskon 
FROM tr_penjualan_dqlab 
WHERE harga >= 100000 OR nama_produk LIKE 'T%' 
ORDER BY diskon DESC;


-- =========================================================================
-- BAGIAN 2: FUNGSI AGREGASI & PENGELOMPOKAN (GROUP BY)
-- =========================================================================

-- FUNGSI AGREGASI DASAR
-- Praktek #7: Menggunakan Fungsi Agregasi SUM
SELECT SUM(qty) FROM tr_penjualan;

-- Praktek #8: Menggunakan Fungsi Agregasi COUNT
SELECT COUNT(*) FROM tr_penjualan;

-- Praktek #9: Menggunakan SUM dan COUNT berbarengan
SELECT SUM(qty), COUNT(*) FROM tr_penjualan;

-- Praktek #10: Menggunakan Fungsi AVG, MAX, dan MIN
SELECT AVG(qty), MAX(qty), MIN(qty) FROM tr_penjualan;


-- AGREGASI DENGAN DISTINCT
-- Praktek #11: Menggunakan COUNT(DISTINCT)
-- Berapa banyak nama produk unik yang terjual
SELECT COUNT(DISTINCT nama_produk) FROM tr_penjualan;

-- Praktek #12: Menggunakan COUNT(*) dan COUNT(DISTINCT)
-- Berapa banyak pelanggan unik yang bertransaksi
SELECT COUNT(DISTINCT kode_pelanggan) FROM tr_penjualan;

-- Praktek #13: Penggunaan Field Lain + Fungsi Agregasi (Gabungan Multi-Kolom Agregasi)
SELECT 
    COUNT(*) AS Jumlah_transaksi,
    COUNT(DISTINCT nama_produk) AS Jumlah_Produk_terjual,
    COUNT(DISTINCT kode_pelanggan) AS Jumlah_pelanggan_yang_transaksi
FROM tr_penjualan;


-- KLAUSA GROUP BY
-- Mengelompokkan isi data dari sebuah kolom
-- Bisa dikelompokkan pada 1 kolom, 2 kolom, dan gabungan kolom dan fungsi agregasi

-- Praktek #14: Penggunaan GROUP BY satu kolom
-- Ambil kelompok produk dari nama produk
SELECT nama_produk FROM tr_penjualan GROUP BY nama_produk;

-- Praktek #15: Kelompok dengan 2 kolom
-- Ambil nama produk dan qty yang dikelompokkan berdasarkan nama dan qty
SELECT nama_produk, qty FROM tr_penjualan
GROUP BY nama_produk, qty;

-- Praktek #16: Kelompok dengan 1 kolom dan 1 hasil agregasi kolom (Urut Terkecil)
-- Ambil nama produk terjual beserta total qty-nya
SELECT nama_produk, SUM(qty)
FROM tr_penjualan GROUP BY nama_produk
ORDER BY SUM(qty); 

-- Praktek #17: Diurutkan dengan ORDER BY (Urut Terbesar)
SELECT nama_produk, SUM(qty)
FROM tr_penjualan GROUP BY nama_produk
ORDER BY SUM(qty) DESC;


-- =========================================================================
-- BAGIAN 3: FILTERING AGREGASI (HAVING KLAUSA)
-- =========================================================================

-- HAVING adalah filtering untuk hasil fungsi agregasi dengan GROUP BY
-- Praktek #18: Penggunaan HAVING
-- Mengambil jumlah qty di atas nilai 2 dari grouping nama produk terhadap seluruh row tabel transaksi penjualan
SELECT nama_produk, SUM(qty) 
FROM tr_penjualan_dqlab 
GROUP BY nama_produk 
HAVING SUM(qty) > 2;


-- Latihan Mandiri - GROUP BY dan HAVING (Halaman 98)
-- Soal 1
SELECT nama_produk, SUM(qty) AS total_terjual 
FROM tr_penjualan_dqlab 
GROUP BY nama_produk 
HAVING SUM(qty) > 4;

-- Soal 2
SELECT nama_produk, SUM(qty) AS total_terjual 
FROM tr_penjualan_dqlab 
GROUP BY nama_produk 
HAVING SUM(qty) = 9;

-- Soal 3
SELECT nama_produk, SUM((harga * qty) - diskon) AS total_penjualan 
FROM tr_penjualan_dqlab 
GROUP BY nama_produk 
ORDER BY total_penjualan DESC;


-- =========================================================================
-- BAGIAN 4: INTEGRASI DATA (JOIN / UNION) - HALAMAN 90
-- =========================================================================

-- Latihan Mandiri - Relasi Integrasi Tabel (Halaman 90)
-- Soal 1: Buatlah join untuk ketiga table yang terdapat pada dqlabmartbasic dengan INNER JOIN.
SELECT * FROM tr_penjualan_dqlab AS tr
INNER JOIN ms_pelanggan AS pl ON tr.kode_pelanggan = pl.kode_pelanggan
INNER JOIN ms_produk_dqlab AS pr ON tr.kode_produk = pr.kode_produk;

-- Soal 2: Buatlah join untuk ketiga table dengan urutan ms_pelanggan, tr_penjualan dan ms_produk dengan LEFT JOIN, kemudian filter untuk qty yang tidak bernilai NULL dengan operator IS NOT NULL.
SELECT * FROM ms_pelanggan AS pl
LEFT JOIN tr_penjualan_dqlab AS tr ON pl.kode_pelanggan = tr.kode_pelanggan
LEFT JOIN ms_produk_dqlab AS pr ON tr.kode_produk = pr.kode_produk
WHERE tr.qty IS NOT NULL;

-- Soal 3: Buatlah join untuk ketiga table dengan urutan ms_pelanggan, tr_penjualan dan ms_produk dengan INNER JOIN, kemudian tampilkan grouping untuk kolom kategori produk dan penjumlahan qty.
SELECT pr.kategori_produk, SUM(tr.qty) AS total_kuantitas
FROM ms_pelanggan AS pl
INNER JOIN tr_penjualan_dqlab AS tr ON pl.kode_pelanggan = tr.kode_pelanggan
INNER JOIN ms_produk_dqlab AS pr ON tr.kode_produk = pr.kode_produk
GROUP BY pr.kategori_produk;

-- Soal 4: Latihan khusus: Cobalah lakukan JOIN ms_produk dengan table ms_produk juga dengan kolom relationship kode_produk (Self-Join dengan menggunakan alias).
SELECT p1.kode_produk, p1.nama_produk, p2.kategori_produk
FROM ms_produk_dqlab AS p1
INNER JOIN ms_produk_dqlab AS p2 ON p1.kode_produk = p2.kode_produk;
