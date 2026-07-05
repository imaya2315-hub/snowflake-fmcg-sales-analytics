-- =========================================================
-- 03. Data Quality Checks
-- Null checks on key fields and a sanity check for
-- negative net sales values.
-- =========================================================

SELECT
    COUNT_IF(COUNTRY IS NULL)        AS COUNTRY_NULL,
    COUNT_IF(BRAND IS NULL)          AS BRAND_NULL,
    COUNT_IF(CATEGORY IS NULL)       AS CATEGORY_NULL,
    COUNT_IF(NET_SALES IS NULL)      AS SALES_NULL,
    COUNT_IF(STOCK_ON_HAND IS NULL)  AS STOCK_NULL
FROM FMCG_RAW;

SELECT *
FROM FMCG_RAW
WHERE NET_SALES < 0;
