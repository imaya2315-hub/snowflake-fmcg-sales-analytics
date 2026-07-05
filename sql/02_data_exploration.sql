-- =========================================================
-- 02. Data Exploration
-- Basic profiling of the FMCG_RAW table: row counts, date
-- range, and cardinality of key dimensions.
-- =========================================================

SELECT COUNT(*) AS total_rows
FROM FMCG_RAW;

SELECT *
FROM FMCG_RAW
LIMIT 10;

SELECT
    MIN(DATE) AS START_DATE,
    MAX(DATE) AS END_DATE
FROM FMCG_RAW;

SELECT
    COUNT(DISTINCT COUNTRY) AS TOTAL_COUNTRIES
FROM FMCG_RAW;

SELECT
    COUNT(DISTINCT STORE_ID) AS TOTAL_STORES
FROM FMCG_RAW;

SELECT
    COUNT(DISTINCT BRAND) AS TOTAL_BRANDS
FROM FMCG_RAW;

SELECT
    CATEGORY,
    COUNT(*) AS PRODUCTS
FROM FMCG_RAW
GROUP BY CATEGORY
ORDER BY PRODUCTS DESC;
