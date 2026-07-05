# FMCG Sales Analytics (Snowflake + Power BI)

End-to-end analytics project on a 1M-row, 3-year FMCG (Fast-Moving Consumer Goods) sales
dataset.

**Architecture: Snowflake (data warehouse + all SQL transformation/analysis) → live
connection into Power BI (dashboarding).** The raw CSV was staged and loaded into
Snowflake as `FMCG_RAW`; all exploration, KPI, and analytical queries in `sql/` run
directly in Snowflake; and the Power BI report (`powerbi/SQL.pbix`) connects **directly
to Snowflake** as its data source (via the native Snowflake connector), rather than
importing a flat file. This means the dashboard reflects the Snowflake tables/views
live (or on scheduled refresh), not a static export.

## Repo structure

```
fmcg-sales-analytics/
├── README.md
├── data/
│   ├── README.md              # data dictionary
│   └── sample_data.csv        # 1,000-row sample (full file not committed, see below)
├── sql/
│   ├── 01_setup_and_staging.sql
│   ├── 02_data_exploration.sql
│   ├── 03_data_quality_checks.sql
│   ├── 04_kpi_summary.sql
│   ├── 05_dimensional_analysis.sql
│   ├── 06_time_series_analysis.sql
│   ├── 07_window_functions.sql
│   ├── 08_inventory_supplier_analysis.sql
│   └── 09_views.sql
└── powerbi/
    ├── README.md
    └── SQL.pbix                # Power BI report
```

## Dataset

- **Grain:** one row per store × SKU × day
- **Rows:** ~1,000,000
- **Period:** 3 years, starting 2021-01-01
- **Coverage:** multiple countries, stores, channels, categories, brands and SKUs
- **Size:** ~203 MB — too large for a normal git push (GitHub's hard limit is 100 MB/file).
  Only a 1,000-row `data/sample_data.csv` is committed. See [`data/README.md`](data/README.md)
  for the full data dictionary and options for hosting the full file (Git LFS, cloud
  storage, or Snowflake stage).

## Tech stack

- **Snowflake** — the data warehouse for this entire project: staging (`CREATE STAGE`),
  loading, and *all* SQL transformation/analysis (`sql/`) run here
- **SQL (Snowflake dialect)** — exploration, data quality checks, KPI rollups,
  window-function analytics, and reusable views, all executed against Snowflake
- **Power BI** — dashboarding (`powerbi/SQL.pbix`), connected **directly to Snowflake**
  via Power BI's built-in Snowflake connector (Get Data → Snowflake), not a CSV import

## Getting started

1. Create a Snowflake account/warehouse and update the `USE DATABASE` / `USE SCHEMA` /
   `USE WAREHOUSE` statements in `sql/01_setup_and_staging.sql` to match your environment.
2. Load the dataset into a stage and table named `FMCG_RAW` (see `01_setup_and_staging.sql`
   for the `CREATE STAGE` step; use Snowflake's `COPY INTO` with the CSV to load data).
3. Run the scripts in `sql/` in numeric order — each one builds on the raw `FMCG_RAW` table,
   entirely inside Snowflake.
4. Open `powerbi/SQL.pbix` in Power BI Desktop. It's built to connect **directly to
   Snowflake** (Get Data → Snowflake → enter your account/warehouse/database/schema) —
   update the connection details to your own Snowflake instance, pointing at either
   `FMCG_RAW` directly or the curated views in `09_views.sql`.

## What's analyzed

- Revenue, margin, and unit-sales KPIs (executive summary)
- Country / brand / category / channel breakdowns
- Monthly trend and month-over-month growth
- Weekend vs. weekday and promo vs. non-promo performance
- Rolling 7-day revenue average and cumulative revenue
- Top SKUs by revenue (Pareto / running-percentage analysis)
- Inventory health (Critical / Low / Healthy stock buckets)
- Supplier lead time, stockouts, and revenue contribution
- Weather (temperature/rainfall) vs. sales correlation

## License

Add a license of your choice (e.g. MIT) before publishing publicly.
