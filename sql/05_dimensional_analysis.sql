-- =========================================================
-- 05. Dimensional Analysis
-- Revenue and units broken down by country, brand,
-- category, channel, weekend flag, promo flag, stockout
-- flag, supplier, and temperature.
-- =========================================================

-- Top 10 countries by revenue
SELECT
    country,
    ROUND(SUM(net_sales), 2) AS revenue,
    SUM(units_sold)          AS units
FROM FMCG_RAW
GROUP BY country
ORDER BY revenue DESC
LIMIT 10;

-- Brand performance
SELECT
    brand,
    ROUND(SUM(net_sales), 2) AS revenue,
    SUM(units_sold)          AS units
FROM FMCG_RAW
GROUP BY brand
ORDER BY revenue DESC;

-- Category performance with average margin
SELECT
    category,
    ROUND(SUM(net_sales), 2) AS revenue,
    ROUND(AVG(margin_pct), 2) AS avg_margin,
    SUM(units_sold)          AS units
FROM FMCG_RAW
GROUP BY category
ORDER BY revenue DESC;

-- Channel performance with average discount
SELECT
    channel,
    ROUND(SUM(net_sales), 2) AS revenue,
    ROUND(AVG(discount_pct), 2) AS avg_discount,
    SUM(units_sold)          AS units
FROM FMCG_RAW
GROUP BY channel
ORDER BY revenue DESC;

-- Weekend vs weekday
SELECT
    is_weekend,
    ROUND(SUM(net_sales), 2) AS revenue,
    SUM(units_sold)          AS units
FROM FMCG_RAW
GROUP BY is_weekend;

-- Promo vs non-promo
SELECT
    promo_flag,
    ROUND(SUM(net_sales), 2) AS revenue,
    ROUND(AVG(discount_pct), 2) AS avg_discount,
    SUM(units_sold)          AS units
FROM FMCG_RAW
GROUP BY promo_flag;

-- Stockout impact
SELECT
    stock_out_flag,
    COUNT(*)                 AS records,
    ROUND(SUM(net_sales), 2) AS revenue
FROM FMCG_RAW
GROUP BY stock_out_flag;

-- Supplier performance
SELECT
    supplier_id,
    ROUND(AVG(lead_time_days), 2) AS avg_lead_time,
    ROUND(SUM(net_sales), 2)      AS revenue
FROM FMCG_RAW
GROUP BY supplier_id
ORDER BY revenue DESC;

-- Sales vs temperature
SELECT
    ROUND(temperature) AS temp,
    ROUND(AVG(net_sales), 2) AS avg_sales
FROM FMCG_RAW
GROUP BY ROUND(temperature)
ORDER BY temp;

-- Units and sales vs temperature
SELECT
    ROUND(temperature) AS temp,
    ROUND(AVG(units_sold), 2) AS avg_units,
    ROUND(AVG(net_sales), 2)  AS avg_sales
FROM FMCG_RAW
GROUP BY ROUND(temperature)
ORDER BY temp;

-- Sales/margin vs discount level
SELECT
    discount_pct,
    ROUND(AVG(net_sales), 2)  AS avg_sales,
    ROUND(AVG(margin_pct), 2) AS avg_margin
FROM FMCG_RAW
GROUP BY discount_pct
ORDER BY discount_pct;
