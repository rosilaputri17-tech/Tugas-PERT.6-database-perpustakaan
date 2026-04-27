-- =====================================
-- TUGAS 1: EKSPLORASI DATABASE PERPUSTAKAAN
-- =====================================

-- =========================
-- 1. STATISTIK BUKU (5 QUERY)
-- =========================

-- Total buku seluruhnya
SELECT COUNT(*) AS total_buku FROM buku;

-- Total nilai inventaris (harga × stok)
SELECT SUM(harga * stok) AS total_inventaris FROM buku;

-- Rata-rata harga buku
SELECT AVG(harga) AS rata_rata_harga FROM buku;

-- Buku termahal (judul dan harga)
SELECT judul, harga 
FROM buku 
ORDER BY harga DESC 
LIMIT 1;

-- Buku dengan stok terbanyak
SELECT judul, stok 
FROM buku 
ORDER BY stok DESC 
LIMIT 1;


-- =========================
-- 2. FILTER DAN PENCARIAN (5 QUERY)
-- =========================

-- Buku kategori Programming dengan harga < 100000
SELECT * 
FROM buku 
WHERE kategori = 'Programming' AND harga < 100000;

-- Buku yang judulnya mengandung "PHP" atau "MySQL"
SELECT * 
FROM buku 
WHERE judul LIKE '%PHP%' OR judul LIKE '%MySQL%';

-- Buku yang terbit tahun 2024
SELECT * 
FROM buku 
WHERE tahun_terbit = 2024;

-- Buku dengan stok antara 5 - 10
SELECT * 
FROM buku 
WHERE stok BETWEEN 5 AND 10;

-- Buku dengan pengarang "Budi Raharjo"
SELECT * 
FROM buku 
WHERE pengarang = 'Budi Raharjo';


-- =========================
-- 3. GROUPING DAN AGREGASI (3 QUERY)
-- =========================

-- Jumlah buku per kategori + total stok
SELECT kategori, COUNT(*) AS jumlah_buku, SUM(stok) AS total_stok
FROM buku
GROUP BY kategori;

-- Rata-rata harga per kategori
SELECT kategori, AVG(harga) AS rata_rata_harga
FROM buku
GROUP BY kategori;

-- Kategori dengan total nilai inventaris terbesar
SELECT kategori, SUM(harga * stok) AS total_inventaris
FROM buku
GROUP BY kategori
ORDER BY total_inventaris DESC
LIMIT 1;


-- =========================
-- 4. UPDATE DATA (2 QUERY)
-- =========================

-- Naikkan harga buku kategori Programming 5%
UPDATE buku
SET harga = harga * 1.05
WHERE kategori = 'Programming';

-- Tambah stok 10 untuk buku dengan stok < 5
UPDATE buku
SET stok = stok + 10
WHERE stok < 5;


-- =========================
-- 5. LAPORAN KHUSUS (2 QUERY)
-- =========================

-- Buku yang perlu restocking (stok < 5)
SELECT * 
FROM buku 
WHERE stok < 5;

-- Top 5 buku termahal
SELECT judul, harga 
FROM buku 
ORDER BY harga DESC 
LIMIT 5;