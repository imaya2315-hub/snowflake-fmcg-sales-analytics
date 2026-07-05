-- =========================================================
-- 07. Window Functions
-- Rankings across countries, brands within category, top
-- SKUs, supplier ranking, and a Pareto (cumulative %)
-- analysis of product revenue.
-- =========================================================

-- Country rank by revenue
SELECT
    country,
    ROUND(SUM(net_sales), 2) AS revenue,
    RANK() OVER (ORDER BY SUM(net_sales) DESC) AS country_rank
FROM FMCG_RAW
GROUP BY country;

-- Brand rank within each category
SELECT
    category,
    brand,
    ROUND(SUM(net_sales), 2) AS revenue,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY SUM(net_sales) DESC
    ) AS brand_rank
FROM FMCG_RAW
GROUP BY category, brand;

-- Top 20 SKUs by revenue
SELECT
    sku_name,
    brand,
    ROUND(SUM(net_sales), 2) AS revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(net_sales) DESC) AS ranking
FROM FMCG_RAW
GROUP BY sku_name, brand
QUALIFY ranking <= 20;

-- Supplier rank by revenue
SELECT
    supplier_id,
    AVG(lead_time_days) AS avg_days,
    SUM(net_sales)       AS revenue,
    RANK() OVER (ORDER BY SUM(net_sales) DESC) AS supplier_rank
FROM FMCG_RAW
GROUP BY supplier_id;

-- Pareto analysis: cumulative % of revenue by SKU
WITH product_sales AS (
    SELECT
        sku_name,
        SUM(net_sales) AS revenue
    FROM FMCG_RAW
    GROUP BY sku_name
),
ranked AS (
    SELECT
        sku_name,
        revenue,
        SUM(revenue) OVER (ORDER BY revenue DESC) AS running_revenue,
        SUM(revenue) OVER ()                       AS total_revenue
    FROM product_sales
)
SELECT
    sku_name,
    revenue,
    ROUND(running_revenue / total_revenue * 100, 2) AS cumulative_percentage
FROM ranked;
