-- 1. ROW_NUMBER, RANK, DENSE_RANK
-- Goal: Rank accounts based on balance from highest to lowest.
---------------------------------------------------------------
WITH balans_reytinq AS (
    SELECT 
        musteri_id,
        hesab_id,
        balans,
        ROW_NUMBER() OVER (ORDER BY balans DESC) AS row_num,
        RANK()       OVER (ORDER BY balans DESC) AS balans_rank,
        DENSE_RANK() OVER (ORDER BY balans DESC) AS balans_dense_rank
    FROM hesablar
)
SELECT 
    musteri_id, 
    hesab_id, 
    balans, 
    balans_dense_rank
FROM balans_reytinq 
WHERE balans_dense_rank <= 2;

---------------------------------------------------------------
-- 2. LAG & LEAD
-- Goal: Compare transactions with previous and next records
--       by date for each account.
---------------------------------------------------------------
SELECT 
    hesab_id, 
    emeliyyat_id, 
    mebleg, 
    emeliyyat_tarixi,
    -- Previous transaction amount
    LAG(mebleg) OVER (
        PARTITION BY hesab_id 
        ORDER BY emeliyyat_tarixi ASC
    ) AS evvelki_mebleg,
    -- Next transaction amount
    LEAD(mebleg) OVER (
        PARTITION BY hesab_id 
        ORDER BY emeliyyat_tarixi ASC
    ) AS sonraki_mebleg,
    -- Transaction amount difference
    mebleg - LAG(mebleg) OVER (
        PARTITION BY hesab_id 
        ORDER BY emeliyyat_tarixi ASC
    ) AS mebleg_ferqi
FROM emeliyyatlar;

---------------------------------------------------------------
-- 3. FIRST_VALUE & LAST_VALUE
-- Goal: Retrieve the initial and most recent transaction amount 
--       for each account.
---------------------------------------------------------------
SELECT 
    hesab_id, 
    emeliyyat_id, 
    mebleg, 
    emeliyyat_tarixi,
    -- First transaction amount
    FIRST_VALUE(mebleg) OVER (
        PARTITION BY hesab_id 
        ORDER BY emeliyyat_tarixi ASC
    ) AS ilk_emeliyyat_meblegi,
    -- Most recent transaction amount
    LAST_VALUE(mebleg) OVER (
        PARTITION BY hesab_id 
        ORDER BY emeliyyat_tarixi ASC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS son_emeliyyat_meblegi
FROM emeliyyatlar;
