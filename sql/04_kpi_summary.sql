-- =========================================================
-- 04. KPI Summary
-- Headline revenue, units, and margin metrics.
-- =========================================================

SELECT
    ROUND(SUM(GROSS_SALES), 2) AS TOTAL_REVENUE
FROM FMCG_RAW;

SELECT
    ROUND(SUM(NET_SALES), 2) AS NET_REVENUE
FROM FMCG_RAW;

SELECT
    SUM(UNITS_SOLD) AS TOTAL_UNITS
FROM FMCG_RAW;

SELECT
    ROUND(
        100 * SUM(NET_SALES - PURCHASE_COST) / SUM(NET_SALES), 2
    ) AS MARGIN_PERCENT
FROM FMCG_RAW;
