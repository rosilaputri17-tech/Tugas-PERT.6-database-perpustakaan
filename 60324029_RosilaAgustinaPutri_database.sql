-- =========================================
-- DATABASE PERPUSTAKAAN LENGKAP
-- =========================================

-- 1. CREATE DATABASE
CREATE DATABASE perpustakaan_lengkap;
USE perpustakaan_lengkap;

-- =========================================
-- 2. TABEL KATEGORI BUKU
-- =========================================
CREATE TABLE kategori_buku (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE,
    deskripsi TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

-- =========================================
-- 3. TABEL PENERBIT
-- =========================================
CREATE TABLE penerbit (
    id_penerbit INT AUTO_INCREMENT PRIMARY KEY,
    nama_penerbit VARCHAR(100) NOT NULL,
    alamat TEXT,
    telepon VARCHAR(15),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

-- =========================================
-- 4. TABEL RAK (BONUS)
-- =========================================
CREATE TABLE rak (
    id_rak INT AUTO_INCREMENT PRIMARY KEY,
    nama_rak VARCHAR(50),
    lokasi VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================
-- 5. TABEL BUKU (RELASI)
-- =========================================
CREATE TABLE buku (
    id_buku INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(150) NOT NULL,
    pengarang VARCHAR(100),
    tahun_terbit INT,
    harga DECIMAL(10,2),
    stok INT,
    id_kategori INT,
    id_penerbit INT,
    id_rak INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    FOREIGN KEY (id_kategori) REFERENCES kategori_buku(id_kategori),
    FOREIGN KEY (id_penerbit) REFERENCES penerbit(id_penerbit),
    FOREIGN KEY (id_rak) REFERENCES rak(id_rak)
);

-- =========================================
-- 6. INSERT DATA KATEGORI
-- =========================================
INSERT INTO kategori_buku (nama_kategori, deskripsi) VALUES
('Programming', 'Buku pemrograman'),
('Database', 'Buku database'),
('Jaringan', 'Buku jaringan komputer'),
('AI', 'Artificial Intelligence'),
('Web Development', 'Pengembangan web');

-- =========================================
-- 7. INSERT DATA PENERBIT
-- =========================================
INSERT INTO penerbit (nama_penerbit, alamat, telepon, email) VALUES
('Informatika', 'Bandung', '0811111111', 'info@informatika.com'),
('Erlangga', 'Jakarta', '0822222222', 'info@erlangga.com'),
('Andi Offset', 'Yogyakarta', '0833333333', 'info@andi.com'),
('Gramedia', 'Jakarta', '0844444444', 'info@gramedia.com'),
('Deepublish', 'Yogyakarta', '0855555555', 'info@deepublish.com');

-- =========================================
-- 8. INSERT DATA RAK
-- =========================================
INSERT INTO rak (nama_rak, lokasi) VALUES
('Rak A', 'Lantai 1'),
('Rak B', 'Lantai 1'),
('Rak C', 'Lantai 2');

-- =========================================
-- 9. INSERT DATA BUKU (15 DATA)
-- =========================================
INSERT INTO buku (judul, pengarang, tahun_terbit, harga, stok, id_kategori, id_penerbit, id_rak) VALUES
('Belajar PHP', 'Budi Raharjo', 2024, 90000, 10, 1, 1, 1),
('Mastering MySQL', 'Andi', 2023, 120000, 5, 2, 2, 2),
('Jaringan Komputer', 'Rudi', 2022, 80000, 8, 3, 3, 1),
('AI Dasar', 'Siti', 2024, 150000, 6, 4, 4, 3),
('Web Modern', 'Agus', 2024, 110000, 7, 5, 5, 2),
('Laravel Guide', 'Budi Raharjo', 2023, 130000, 3, 1, 1, 1),
('Python AI', 'Dewi', 2024, 140000, 4, 4, 2, 3),
('Database Lanjut', 'Rina', 2022, 100000, 9, 2, 3, 2),
('HTML CSS', 'Tono', 2021, 70000, 12, 5, 4, 1),
('Cyber Security', 'Joko', 2023, 125000, 2, 3, 5, 3),
('Machine Learning', 'Sari', 2024, 160000, 5, 4, 1, 2),
('Java Programming', 'Budi', 2022, 95000, 11, 1, 2, 1),
('SQL Basic', 'Andi', 2023, 85000, 6, 2, 3, 2),
('React JS', 'Dina', 2024, 115000, 7, 5, 4, 1),
('Networking Advanced', 'Rudi', 2023, 135000, 4, 3, 5, 3);

-- =========================================
-- 10. QUERY JOIN
-- =========================================

-- Tampilkan buku + kategori + penerbit
SELECT b.judul, k.nama_kategori, p.nama_penerbit
FROM buku b
JOIN kategori_buku k ON b.id_kategori = k.id_kategori
JOIN penerbit p ON b.id_penerbit = p.id_penerbit;

-- Jumlah buku per kategori
SELECT k.nama_kategori, COUNT(b.id_buku) AS jumlah_buku
FROM buku b
JOIN kategori_buku k ON b.id_kategori = k.id_kategori
GROUP BY k.nama_kategori;

-- Jumlah buku per penerbit
SELECT p.nama_penerbit, COUNT(b.id_buku) AS jumlah_buku
FROM buku b
JOIN penerbit p ON b.id_penerbit = p.id_penerbit
GROUP BY p.nama_penerbit;

-- Detail lengkap buku
SELECT b.*, k.nama_kategori, p.nama_penerbit
FROM buku b
JOIN kategori_buku k ON b.id_kategori = k.id_kategori
JOIN penerbit p ON b.id_penerbit = p.id_penerbit;

-- =========================================
-- 11. STORED PROCEDURE (BONUS)
-- =========================================

DELIMITER //
CREATE PROCEDURE tambah_buku (
    IN p_judul VARCHAR(150),
    IN p_pengarang VARCHAR(100),
    IN p_kategori INT
)
BEGIN
    INSERT INTO buku (judul, pengarang, id_kategori)
    VALUES (p_judul, p_pengarang, p_kategori);
END //
DELIMITER ;