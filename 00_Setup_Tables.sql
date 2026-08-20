-- 1. Musteriler Cedveli
CREATE TABLE musteriler (
    musteri_id NUMBER PRIMARY KEY,
    ad VARCHAR2(50),
    soyad VARCHAR2(50),
    mobil_nomre VARCHAR2(20),
    ev_telefonu VARCHAR2(20),
    bonus_xallari NUMBER
);

-- 2. Hesablar Cedveli
CREATE TABLE hesablar (
    hesab_id NUMBER PRIMARY KEY,
    musteri_id NUMBER,
    balans NUMBER(12, 2),
    status VARCHAR2(1) -- 'A': Aktiv, 'B': Bloklanib, 'P': Gozlemede
);

-- 3. Emeliyyatlar Cedveli
CREATE TABLE emeliyyatlar (
    emeliyyat_id NUMBER PRIMARY KEY,
    hesab_id NUMBER,
    mebleg NUMBER(12, 2),
    emeliyyat_tarixi DATE
);

-- Data elave edilmesi
INSERT INTO musteriler VALUES (101, 'Leyla', 'Aliyeva', '0501234567', NULL, 150);
INSERT INTO musteriler VALUES (102, 'Rashad', 'Mammadov', NULL, '0124400000', NULL);
INSERT INTO musteriler VALUES (103, 'Anar', 'Hasanov', NULL, NULL, 50);

INSERT INTO hesablar VALUES (5001, 101, 55000.00, 'A');
INSERT INTO hesablar VALUES (5002, 102, 12000.50, 'B');
INSERT INTO hesablar VALUES (5003, 103, 3500.00, 'P');

INSERT INTO emeliyyatlar VALUES (9001, 5001, 1500.00, TO_DATE('2026-08-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO emeliyyatlar VALUES (9002, 5002, 250.75, TO_DATE('2026-08-18 09:15:00', 'YYYY-MM-DD HH24:MI:SS'));

COMMIT;
