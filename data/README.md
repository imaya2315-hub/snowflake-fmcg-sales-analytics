# Data

## Full dataset

The full file `fmcg_sales_3years_1M_rows.csv` is **~203 MB** and **not committed** to this
repo (GitHub blocks pushes of files over 100 MB, and repo bloat from large CSVs is bad
practice). Options to make the full file available alongside this repo:

- **Git LFS** — `git lfs track "*.csv"` and commit through LFS (GitHub free tier includes
  1 GB LFS storage).
- **Cloud storage** — upload to S3 / GCS / Azure Blob / Google Drive and link it here.
- **Snowflake stage** — keep it in the `FMCG_STAGE` internal stage created in
  `sql/01_setup_and_staging.sql` and load with `COPY INTO FMCG_RAW`.

`sample_data.csv` in this folder is a 1,000-row random sample with the same schema, useful
for quick local testing without needing the full file or a warehouse.

## Schema / data dictionary

| Column | Type | Description |
|---|---|---|
| `date` | date | Transaction date (2021-01-01 onward) |
| `year` / `month` / `day` | int | Date parts |
| `weekofyear` | int | ISO week number |
| `weekday` | int | Day of week (numeric) |
| `is_weekend` | 0/1 | Weekend flag |
| `is_holiday` | 0/1 | Holiday flag |
| `temperature` | float | Local temperature |
| `rain_mm` | float | Local rainfall (mm) |
| `store_id` | string | Store identifier |
| `country` | string | Store country |
| `city` | string | Store city |
| `channel` | string | Retail channel (e.g. Hypermarket) |
| `latitude` / `longitude` | float | Store coordinates |
| `sku_id` | string | Product SKU identifier |
| `sku_name` | string | Product name |
| `category` | string | Product category (e.g. Personal Care) |
| `subcategory` | string | Product subcategory (e.g. Shampoo) |
| `brand` | string | Brand name |
| `units_sold` | int | Units sold that day |
| `list_price` | float | List price per unit |
| `discount_pct` | float | Discount applied (0–1) |
| `promo_flag` | 0/1 | Whether item was on promotion |
| `gross_sales` | float | Revenue before discount |
| `net_sales` | float | Revenue after discount |
| `stock_on_hand` | int | Inventory on hand |
| `stock_out_flag` | 0/1 | Stockout indicator |
| `lead_time_days` | int | Supplier lead time |
| `supplier_id` | string | Supplier identifier |
| `purchase_cost` | float | Cost per unit to purchase |
| `margin_pct` | float | Margin percentage |
