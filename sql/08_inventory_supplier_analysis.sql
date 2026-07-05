-- =========================================================
-- 08. Inventory & Supplier Analysis
-- Stock health classification and supplier-level
-- lead time / revenue view.
-- =========================================================

-- Stock health per SKU row
SELECT
    sku_name,
    stock_on_hand,
    CASE
        WHEN stock_on_hand < 20 THEN 'Critical'
        WHEN stock_on_hand < 50 THEN 'Low'
        ELSE 'Healthy'
    END AS inventory_status
FROM FMCG_RAW;
