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
-- Goal: Compare customer transaction balance with previous and 
--       next transactions, calculating balance differences.
---------------------------------------------------------------
SELECT 
    musteri_id, 
    hesab_id, 
    balans, 
    yenilenme_tarixi,
    -- Previous balance
    LAG(balans) OVER (
        PARTITION BY musteri_id 
        ORDER BY yenilenme_tarixi ASC
    ) AS evvelki_balans,
    -- Next balance
    LEAD(balans) OVER (
        PARTITION BY musteri_id 
        ORDER BY yenilenme_tarixi ASC
    ) AS sonraki_balans,
    -- Balance change from previous transaction
    balans - LAG(balans) OVER (
        PARTITION BY musteri_id 
        ORDER BY yenilenme_tarixi ASC
    ) AS balans_ferqi
FROM hesablar;

---------------------------------------------------------------
-- 3. FIRST_VALUE & LAST_VALUE
-- Goal: Retrieve the customer's initial payment and most recent payment.
---------------------------------------------------------------
SELECT 
    musteri_id, 
    odenis_id, 
    mebleg, 
    odenis_tarixi,
    -- First payment amount
    FIRST_VALUE(mebleg) OVER (
        PARTITION BY musteri_id 
        ORDER BY odenis_tarixi ASC
    ) AS ilk_odenis_meblegi,
    -- Most recent payment amount
    LAST_VALUE(mebleg) OVER (
        PARTITION BY musteri_id 
        ORDER BY odenis_tarixi ASC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS son_odenis_meblegi
FROM odenisler;
