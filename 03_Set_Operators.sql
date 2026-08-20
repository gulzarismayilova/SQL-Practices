1. Combine Customer Contacts from Multiple Channels (UNION / UNION ALL)
-- Fetch all distinct phone contact channels
SELECT musteri_id, mobil_nomre AS elaqe_nomresi, 'Mobil' AS kanal 
FROM musteriler 
WHERE mobil_nomre IS NOT NULL
UNION
SELECT musteri_id, ev_telefonu AS elaqe_nomresi, 'Ev' AS kanal 
FROM musteriler 
WHERE ev_telefonu IS NOT NULL;

-- 2. Customers with Accounts but No Transactions (MINUS)
-- Identify accounts without any transactional activity
SELECT musteri_id FROM hesablar
MINUS
SELECT h.musteri_id 
FROM hesablar h 
JOIN emeliyyatlar e ON h.hesab_id = e.hesab_id;
