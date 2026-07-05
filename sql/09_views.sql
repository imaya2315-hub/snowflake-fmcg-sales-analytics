-- =========================================================
-- 09. Views
-- Reusable views for BI consumption (e.g. Power BI).
-- =========================================================

CREATE OR REPLACE VIEW VW_EXECUTIVE AS
SELECT
    SUM(gross_sales)            AS total_revenue,
    SUM(net_sales)               AS net_revenue,
    SUM(units_sold)               AS total_units,
    AVG(margin_pct)               AS avg_margin,
    COUNT(DISTINCT store_id)      AS stores,
    COUNT(DISTINCT country)       AS countries
FROM FMCG_RAW;

CREATE OR REPLACE VIEW VW_COUNTRY_SALES AS
SELECT
    country,
    SUM(net_sales)   AS revenue,
    SUM(units_sold)  AS units
FROM FMCG_RAW
GROUP BY country;

CREATE OR REPLACE VIEW VW_BRAND AS
SELECT
    brand,
    category,
    SUM(net_sales) AS revenue
FROM FMCG_RAW
GROUP BY brand, category;

CREATE OR REPLACE VIEW VW_MONTHLY AS
SELECT
    year,
    month,
    SUM(net_sales) AS revenue
FROM FMCG_RAW
GROUP BY year, month;

CREATE OR REPLACE VIEW VW_MONTHLY_GROWTH AS
WITH monthly AS (
    SELECT
        year,
        month,
        SUM(net_sales) AS revenue
    FROM FMCG_RAW
    GROUP BY year, month
)
SELECT
    year,
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY year, month) AS previous_month,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY year, month))
        / LAG(revenue) OVER (ORDER BY year, month) * 100,
        2
    ) AS growth_percent
FROM monthly;

CREATE OR REPLACE VIEW VW_TOP_PRODUCTS AS
SELECT
    sku_name,
    brand,
    category,
    SUM(units_sold) AS units,
    SUM(net_sales)   AS revenue,
    RANK() OVER (ORDER BY SUM(net_sales) DESC) AS revenue_rank
FROM FMCG_RAW
GROUP BY sku_name, brand, category;

CREATE OR REPLACE VIEW VW_SUPPLIER AS
SELECT
    supplier_id,
    AVG(lead_time_days)              AS avg_lead_time,
    SUM(net_sales)                   AS revenue,
    AVG(stock_on_hand)                AS avg_stock,
    COUNT_IF(stock_out_flag = 1)      AS stockouts
FROM FMCG_RAW
GROUP BY supplier_id;

CREATE OR REPLACE VIEW VW_INVENTORY AS
SELECT
    sku_name,
    brand,
    category,
    AVG(stock_on_hand) AS stock,
    SUM(units_sold)     AS units,
    CASE
        WHEN AVG(stock_on_hand) < 20 THEN 'Critical'
        WHEN AVG(stock_on_hand) < 50 THEN 'Low'
        ELSE 'Healthy'
    END AS inventory_status
FROM FMCG_RAW
GROUP BY sku_name, brand, category;

CREATE OR REPLACE VIEW VW_COUNTRY_DASHBOARD AS
SELECT
    country,
    COUNT(DISTINCT store_id) AS stores,
    SUM(net_sales)            AS revenue,
    SUM(units_sold)            AS units,
    AVG(margin_pct)             AS margin,
    AVG(discount_pct)           AS discount,
    AVG(temperature)            AS temperature,
    SUM(rain_mm)                AS rainfall
FROM FMCG_RAW
GROUP BY country;
