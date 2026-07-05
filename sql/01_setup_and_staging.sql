-- =========================================================
-- 01. Setup & Staging
-- Configure the Snowflake context and create the stage used
-- to load the raw FMCG CSV into the FMCG_RAW table.
-- =========================================================

USE DATABASE INTERVIEW_DB;
USE SCHEMA PRACTICE;
USE WAREHOUSE COMPUTE_WH;

-- Stage for loading the raw CSV file
CREATE STAGE FMCG_STAGE;
SHOW STAGES;

-- After uploading fmcg_sales_3years_1M_rows.csv to FMCG_STAGE
-- (e.g. via SnowSQL `PUT` or the Snowsight UI), load it with:
--
-- COPY INTO FMCG_RAW
-- FROM @FMCG_STAGE/fmcg_sales_3years_1M_rows.csv
-- FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER = 1);

-- Sanity check on the loaded table
DESC TABLE FMCG_RAW;

SELECT CURRENT_ACCOUNT(), CURRENT_REGION(), CURRENT_ORGANIZATION_NAME();
