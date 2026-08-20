-- ============================================================
-- Topic 01: Single Row Functions (Applied on Bank Tables)
-- Author: Gulzar Ismayilova
-- ============================================================

-- Scenario 1: Date & Amount Formatting
SELECT 
    emeliyyat_id,
    hesab_id,
    TO_CHAR(emeliyyat_tarixi, 'DD.MM.YYYY HH24:MI') AS formatli_tarix,
    TO_CHAR(mebleg, '999,999,990.00') || ' AZN' AS formatli_mebleg
FROM emeliyyatlar;

-- Scenario 2: Handling NULL Values
SELECT 
    musteri_id,
    ad || ' ' || soyad AS tam_ad,
    NVL(bonus_xallari, 0) AS yekun_bonus,
    COALESCE(mobil_nomre, ev_telefonu, 'Elaqe yoxdur') AS aktiv_elaqe
FROM musteriler;

-- Scenario 3: Customer Segmentation & Account Status
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
