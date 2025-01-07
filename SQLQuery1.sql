-- TABLOLARIN OLU�TURULMASI


CREATE TABLE Sehir (
    sehir_id INT PRIMARY KEY,
    sehir_adi NVARCHAR(50) NOT NULL,
    sehir_bolgesi NVARCHAR(50)
);

CREATE TABLE Otogar (
    otogar_id INT PRIMARY KEY,
    otogar_adi NVARCHAR(50) NOT NULL,
    sehir_id INT NOT NULL,
    adres NVARCHAR(255),
    FOREIGN KEY (sehir_id) REFERENCES Sehir(sehir_id)
);

CREATE TABLE Firma (
    firma_id INT PRIMARY KEY,
    firma_adi NVARCHAR(50) NOT NULL,
    iletisim_bilgileri NVARCHAR(255)
);

CREATE TABLE Otobus (
    otobus_id INT PRIMARY KEY,
    plakasi NVARCHAR(15) NOT NULL UNIQUE,
    kapasite INT CHECK (kapasite > 0),
    model NVARCHAR(50),
    firma_id INT NOT NULL,
    FOREIGN KEY (firma_id) REFERENCES Firma(firma_id)
);


CREATE TABLE Sefer (
    sefer_id INT PRIMARY KEY,
    kalkis_otogar_id INT NOT NULL,
    varis_otogar_id INT NOT NULL,
    tarih DATE NOT NULL,
    saat TIME NOT NULL,
    otobus_id INT NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (kalkis_otogar_id) REFERENCES Otogar(otogar_id),
    FOREIGN KEY (varis_otogar_id) REFERENCES Otogar(otogar_id),
    FOREIGN KEY (otobus_id) REFERENCES Otobus(otobus_id)
);

CREATE TABLE Yolcu (
    yolcu_id INT PRIMARY KEY,
    ad_soyad NVARCHAR(100) NOT NULL,
    telefon NVARCHAR(15),
    email NVARCHAR(100)
);

CREATE TABLE Rezervasyon (
    rezervasyon_id INT PRIMARY KEY,
    yolcu_id INT NOT NULL,
    sefer_id INT NOT NULL,
    koltuk_no INT NOT NULL CHECK (koltuk_no > 0),
    satin_alma_tarihi DATETIME NOT NULL,
    FOREIGN KEY (yolcu_id) REFERENCES Yolcu(yolcu_id),
    FOREIGN KEY (sefer_id) REFERENCES Sefer(sefer_id),
    UNIQUE (sefer_id, koltuk_no)
);

 
 -- TABLOLARA �RNEK VER�LER�N EKLENMES�

 INSERT INTO Sehir (sehir_id, sehir_adi, sehir_bolgesi) VALUES
(1, '�stanbul', 'Marmara'),
(2, 'Ankara', '�� Anadolu'),
(3, '�zmir', 'Ege');


INSERT INTO Otogar (otogar_id, otogar_adi, sehir_id, adres) VALUES
(1, '�stanbul Esenler Otogar�', 1, 'Esenler, �stanbul'),
(2, 'Ankara A�T�', 2, 'Yenimahalle, Ankara'),
(3, '�zmir Otogar�', 3, 'Bornova, �zmir');


INSERT INTO Firma (firma_id, firma_adi, iletisim_bilgileri) VALUES
(1, 'Kamil Ko�', '444 05 62'),
(2, 'Metro Turizm', '444 34 55'),
(3, 'Pamukkale', '444 35 35');


INSERT INTO Otobus (otobus_id, plakasi, kapasite, model, firma_id) VALUES
(1, '34ABC123', 45, 'Mercedes Travego', 1),
(2, '06DEF456', 50, 'Setra', 2),
(3, '35GHI789', 40, 'Man Lion�s Coach', 3);

INSERT INTO Sefer (sefer_id, kalkis_otogar_id, varis_otogar_id, tarih, saat, otobus_id, fiyat) VALUES
(1, 1, 2, '2025-01-10', '08:30:00', 1, 150.00),
(2, 2, 3, '2025-01-11', '12:00:00', 2, 200.00),
(3, 3, 1, '2025-01-12', '18:00:00', 3, 250.00);


INSERT INTO Yolcu (yolcu_id, ad_soyad, telefon, email) VALUES
(1, 'Ahmet Y�lmaz', '05554443322', 'ahmet@gmail.com'),
(2, 'Fatma Demir', '05332221144', 'fatma@hotmail.com'),
(3, 'Mehmet Kaya', '05443332211', 'mehmet@yahoo.com');


INSERT INTO Rezervasyon (rezervasyon_id, yolcu_id, sefer_id, koltuk_no, satin_alma_tarihi) VALUES
(1, 1, 1, 10, '2025-01-05 09:15:00'),
(2, 2, 2, 20, '2025-01-05 10:00:00'),
(3, 3, 3, 30, '2025-01-05 11:45:00');


-- �li�kilerin Kontrol�
 
-- �ehir ve Otogar �li�kisi
SELECT * 
FROM Sehir s
JOIN Otogar o ON s.sehir_id = o.sehir_id;



-- Firma ve Otob�s �li�kisi
SELECT * 
FROM Firma f
JOIN Otobus o ON f.firma_id = o.firma_id;


-- Sefer ve Rezervasyon �li�kisi
SELECT * 
FROM Sefer s
JOIN Rezervasyon r ON s.sefer_id = r.sefer_id;


-- Sorgular ve Komutlar

-- Sefer Arama (Yolcu Kullan�c� Rol�)

SELECT 
    s.sefer_id,
    o1.otogar_adi AS Kalkis_Otogari,
    o2.otogar_adi AS Varis_Otogari,
    s.tarih,
    s.saat,
    ot.plakasi AS Otobus,
    f.firma_adi AS Firma,
    s.fiyat
FROM 
    Sefer s
JOIN Otogar o1 ON s.kalkis_otogar_id = o1.otogar_id
JOIN Otogar o2 ON s.varis_otogar_id = o2.otogar_id
JOIN Otobus ot ON s.otobus_id = ot.otobus_id
JOIN Firma f ON ot.firma_id = f.firma_id
WHERE 
    o1.otogar_adi = '�stanbul Esenler Otogar�'
    AND o2.otogar_adi = 'Ankara A�T�'
    AND s.tarih = '2025-01-10';



-- Rezervasyon Olu�turma (Yolcu Kullan�c� Rol�)

INSERT INTO Rezervasyon (rezervasyon_id, yolcu_id, sefer_id, koltuk_no, satin_alma_tarihi)
VALUES (4, 1, 1, 15, GETDATE());

-- Otob�s G�ncelleme (Firma Y�netici Rol�)

UPDATE Otobus
SET kapasite = 46, model = 'Mercedes Benz Tourismo'
WHERE otobus_id = 1;


--Sefer Bilgisi G�ncelleme (Firma Y�netici Rol�)
UPDATE Sefer
SET saat = '09:00:00', fiyat = 160.00
WHERE sefer_id = 1;

--  Sefer Listesi (Yolcu Kullan�c� Rol�)
SELECT 
    s.sefer_id,
    o1.otogar_adi AS Kalkis_Otogari,
    o2.otogar_adi AS Varis_Otogari,
    s.tarih,
    s.saat,
    f.firma_adi AS Firma,
    s.fiyat
FROM 
    Sefer s
JOIN Otogar o1 ON s.kalkis_otogar_id = o1.otogar_id
JOIN Otogar o2 ON s.varis_otogar_id = o2.otogar_id
JOIN Otobus ot ON s.otobus_id = ot.otobus_id
JOIN Firma f ON ot.firma_id = f.firma_id
WHERE o1.sehir_id = 1; -- �stanbul'un sehir_id'si


-- Veri Kontrol�

-- G�ncellenen Otob�s Bilgilerini Kontrol Etme
SELECT * FROM Otobus WHERE otobus_id = 1;

-- G�ncellenen Sefer Bilgilerini Kontrol Etme
SELECT * FROM Sefer WHERE sefer_id = 1;

-- Yeni Rezervasyonlar� Kontrol Etme
SELECT * FROM Rezervasyon WHERE rezervasyon_id = 4;

-- Stored Procedures (Sakl� Yordamlar)

--Sefer Ekleme Sakl� Yordam�

CREATE PROCEDURE SeferEkle
    @kalkis_otogar_id INT,
    @varis_otogar_id INT,
    @tarih DATE,
    @saat TIME,
    @otobus_id INT,
    @fiyat DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Sefer (kalkis_otogar_id, varis_otogar_id, tarih, saat, otobus_id, fiyat)
    VALUES (@kalkis_otogar_id, @varis_otogar_id, @tarih, @saat, @otobus_id, @fiyat);
END;

--Kullan�m

EXEC SeferEkle 1, 2, '2025-02-15', '10:00:00', 1, 180.00;


--Rezervasyon Yapma Sakl� Yordam�

CREATE PROCEDURE RezervasyonYap
    @yolcu_id INT,
    @sefer_id INT,
    @koltuk_no INT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Rezervasyon
        WHERE sefer_id = @sefer_id AND koltuk_no = @koltuk_no
    )
    BEGIN
        RAISERROR ('Bu koltuk zaten rezerve edilmi�!', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Rezervasyon (yolcu_id, sefer_id, koltuk_no, satin_alma_tarihi)
        VALUES (@yolcu_id, @sefer_id, @koltuk_no, GETDATE());
    END;
END;

--Kullan�m

EXEC RezervasyonYap 1, 1, 20;

--Sefer Listesi Sakl� Yordam�

CREATE PROCEDURE SeferListele
    @sehir_id INT
AS
BEGIN
    SELECT 
        s.sefer_id,
        o1.otogar_adi AS Kalkis_Otogari,
        o2.otogar_adi AS Varis_Otogari,
        s.tarih,
        s.saat,
        ot.plakasi AS Otobus,
        f.firma_adi AS Firma,
        s.fiyat
    FROM 
        Sefer s
    JOIN Otogar o1 ON s.kalkis_otogar_id = o1.otogar_id
    JOIN Otogar o2 ON s.varis_otogar_id = o2.otogar_id
    JOIN Otobus ot ON s.otobus_id = ot.otobus_id
    JOIN Firma f ON ot.firma_id = f.firma_id
    WHERE o1.sehir_id = @sehir_id;
END;

--Kullan�m
EXEC SeferListele 1;


-- Triggers (Tetikleyiciler)

--Rezervasyon Tetikleyicisi(Bir rezervasyon yap�ld���nda, toplam rezervasyon say�s�n� g�nceller)

CREATE TRIGGER RezervasyonYapildiginda
ON Rezervasyon
AFTER INSERT
AS
BEGIN
    DECLARE @sefer_id INT;
    SELECT @sefer_id = sefer_id FROM inserted;

    UPDATE Sefer
    SET fiyat = fiyat + 5 -- �rnek olarak fiyat art��� yap�labilir.
    WHERE sefer_id = @sefer_id;
END;

--Otob�s Silindi�inde Sefer Silme(Bir otob�s silindi�inde, o otob�sle ili�kili t�m seferler silinir)

CREATE TRIGGER OtobusSilindiginde
ON Otobus
AFTER DELETE
AS
BEGIN
    DELETE FROM Sefer
    WHERE otobus_id IN (SELECT otobus_id FROM deleted);
END;

--Sefer �ptal Tetikleyicisi(Bir sefer silindi�inde, bu sefere ba�l� t�m rezervasyonlar da otomatik olarak silinir)

CREATE TRIGGER SeferSilindiginde
ON Sefer
AFTER DELETE
AS
BEGIN
    DELETE FROM Rezervasyon
    WHERE sefer_id IN (SELECT sefer_id FROM deleted);
END;


--Test ve Kontrol

--Trigger Testi

--Yeni bir rezervasyon ekleyip fiyat g�ncelleme tetikleyicisinin �al��t���n� kontrol edin
INSERT INTO Rezervasyon (rezervasyon_id, yolcu_id, sefer_id, koltuk_no, satin_alma_tarihi)
VALUES (5, 2, 1, 25, GETDATE());

--Otob�s silme tetikleyicisini kontrol edin
DELETE FROM Otobus WHERE otobus_id = 1;