# Power BI

`SQL.pbix` is the Power BI report for this project.

## Data source: Snowflake (live connector, not a file import)

This report is connected **directly to Snowflake** using Power BI's native Snowflake
connector (**Get Data → Database → Snowflake**), authenticated against the same
`INTERVIEW_DB.PRACTICE` database/schema and `COMPUTE_WH` warehouse used by the scripts in
[`../sql/`](../sql). The CSV was never imported straight into Power BI — it was loaded
into Snowflake first, and every table/view the report queries lives in Snowflake. This
keeps a single source of truth: all transformation logic lives in SQL, and Power BI is
purely the visualization layer on top of it.

**Note:** `.pbix` files are binary and don't diff well in git — that's expected for Power
BI reports. If the team grows, consider:

- Exporting a **Performance Analyzer** report or screenshots into this folder for quick
  visual reference without opening the file.
- Using [Power BI's `.pbip` project format](https://learn.microsoft.com/power-bi/developer/projects/projects-overview)
  (Power BI Desktop → File → Save As → Power BI Project) for git-friendly, text-based
  version control of report definitions going forward.

## Connecting the report to your data

The report expects a Snowflake source with either:
- Direct access to `FMCG_RAW`, or
- The curated views in [`../sql/09_views.sql`](../sql/09_views.sql) (`VW_EXECUTIVE`,
  `VW_COUNTRY_SALES`, `VW_BRAND`, `VW_MONTHLY`, `VW_MONTHLY_GROWTH`, `VW_TOP_PRODUCTS`,
  `VW_SUPPLIER`, `VW_INVENTORY`, `VW_COUNTRY_DASHBOARD`) — recommended, since these
  pre-aggregate the 1M-row fact table into report-ready shapes.

Update the connection under **Home → Transform data → Data source settings** to point at
your own Snowflake account/warehouse/database/schema.
