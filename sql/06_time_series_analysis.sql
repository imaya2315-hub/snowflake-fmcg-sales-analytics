-- =========================================================
-- 06. Time Series Analysis
-- Monthly trend, month-over-month growth, cumulative
-- revenue, and 7-day rolling average.
-- =========================================================

-- Monthly revenue trend
SELECT
    year,
    month,
    ROUND(SUM(net_sales), 2) AS revenue
FROM FMCG_RAW
GROUP BY year, month
ORDER BY year, month;

-- Month-over-month growth %
WITH monthly_sales AS (
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
        ((revenue - LAG(revenue) OVER (ORDER BY year, month))
        / LAG(revenue) OVER (ORDER BY year, month)) * 100,
        2
    ) AS growth_percent
FROM monthly_sales;

-- Cumulative revenue over time
WITH daily_sales AS (
    SELECT
        date,
        SUM(net_sales) AS revenue
    FROM FMCG_RAW
    GROUP BY date
)
SELECT
    date,
    revenue,
    SUM(revenue) OVER (ORDER BY date) AS cumulative_revenue
FROM daily_sales;

-- 7-day rolling average revenue
WITH daily_sales AS (
    SELECT
        date,
        SUM(net_sales) AS revenue
    FROM FMCG_RAW
    GROUP BY date
)
SELECT
    date,
    revenue,
    ROUND(
        AVG(revenue) OVER (
            ORDER BY date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS rolling_avg
FROM daily_sales;
