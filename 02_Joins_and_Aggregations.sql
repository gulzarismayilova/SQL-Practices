1. Customer & Account Details (INNER JOIN / LEFT JOIN)
-- Show customer full name, account ID, balance, and account status
SELECT 
    m.musteri_id,
    m.ad || ' ' || m.soyad AS tam_ad,
    h.hesab_id,
    NVL(h.balans, 0) AS balans,
    DECODE(h.status, 'A', 'Aktiv', 'B', 'Bloklanib', 'P', 'Gozlemede', 'Yoxdur') AS status
FROM musteriler m
LEFT JOIN hesablar h ON m.musteri_id = h.musteri_id;

-- 2. Total Balance per Customer (GROUP BY & HAVING)
-- Calculate total balance for active accounts having total balance > 5000
SELECT 
    m.musteri_id,
    m.ad || ' ' || m.soyad AS tam_ad,
    SUM(h.balans) AS umumi_balans,
    COUNT(h.hesab_id) AS hesab_sayi
FROM musteriler m
JOIN hesablar h ON m.musteri_id = h.musteri_id
WHERE h.status = 'A'
GROUP BY m.musteri_id, m.ad, m.soyad
HAVING SUM(h.balans) > 5000;
