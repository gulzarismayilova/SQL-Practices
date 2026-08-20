1. Text & Masking Functions (SUBSTR, LENGTH, UPPER, INSTR)
-- Mask mobile numbers and ensure standardized name formatting
SELECT 
    musteri_id,
    UPPER(ad) || ' ' || UPPER(soyad) AS tam_ad,
    mobil_nomre,
    CASE 
        WHEN LENGTH(mobil_nomre) >= 10 THEN SUBSTR(mobil_nomre, 1, 3) || '***' || SUBSTR(mobil_nomre, -2)
        ELSE 'Format Yanlisdir'
    END AS maskalanmis_nomre
FROM musteriler
WHERE mobil_nomre IS NOT NULL;

-- 2. Numeric & Rounding Functions (ROUND, TRUNC)
-- Calculate interest amounts and balance approximations
SELECT 
    hesab_id,
    balans,
    ROUND(balans * 0.05, 2) AS illik_faiz_qazanci,
    TRUNC(balans) AS tam_balans_hissesi
FROM hesablar
WHERE status = 'A';

-- 3. Date & Amount Formatting (TO_CHAR)
SELECT 
    emeliyyat_id,
    hesab_id,
    TO_CHAR(emeliyyat_tarixi, 'DD.MM.YYYY HH24:MI') AS formatli_tarix,
    TO_CHAR(mebleg, '999,999,990.00') || ' AZN' AS formatli_mebleg
FROM emeliyyatlar;

-- 4. Handling NULL Values (NVL, COALESCE)
SELECT 
    musteri_id,
    NVL(bonus_xallari, 0) AS yekun_bonus,
    COALESCE(mobil_nomre, ev_telefonu, 'Elaqe yoxdur') AS aktiv_elaqe
FROM musteriler;

-- 5. Customer Segmentation & Status (CASE, DECODE)
SELECT 
    hesab_id,
    musteri_id,
    balans,
    CASE 
        WHEN balans >= 50000 THEN 'VIP'
        WHEN balans BETWEEN 10000 AND 49999 THEN 'Gold'
        ELSE 'Standard'
    END AS seqment,
    DECODE(status, 'A', 'Aktiv', 'B', 'Bloklanib', 'P', 'Gozlemede', 'Bilinmir') AS status_metn
FROM hesablar;
