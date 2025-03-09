-- Create the staging schema (if it doesn't already exist)
CREATE SCHEMA IF NOT EXISTS staging;


-- Copy tables from public to staging
CREATE TABLE staging.fact_averagecosts_staging AS SELECT * FROM public.fact_averagecosts_staging;
CREATE TABLE staging.hier_clnd_staging AS SELECT * FROM public.hier_clnd_staging;
CREATE TABLE staging.hier_hldy_staging AS SELECT * FROM public.hier_hldy_staging;
CREATE TABLE staging.hier_invloc_staging AS SELECT * FROM public.hier_invloc_staging;
CREATE TABLE staging.hier_invstatus_staging AS SELECT * FROM public.hier_invstatus_staging;
CREATE TABLE staging.hier_possite_staging AS SELECT * FROM public.hier_possite_staging;
CREATE TABLE staging.hier_pricestate_staging AS SELECT * FROM public.hier_pricestate_staging;
CREATE TABLE staging.hier_prod_staging AS SELECT * FROM public.hier_prod_staging;
CREATE TABLE staging.hier_rtlloc_staging AS SELECT * FROM public.hier_rtlloc_staging;

-- Verify the tables in the staging schema
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'staging'
ORDER BY table_name;




-- Example: Normalizing hier_clnd (further normalization could be done)
CREATE TABLE staging.calendar_day (
    fscldt_id VARCHAR(255) PRIMARY KEY,
    fscldt_label VARCHAR(255),
    date DATE,
    fscldow INT,
    fscldom INT,
    fscldoq INT,
    fscldoy INT
);

CREATE TABLE staging.calendar_week (
    fsclwk_id VARCHAR(255) PRIMARY KEY,
    fsclwk_label VARCHAR(255),
    fsclwoy INT
);

CREATE TABLE staging.calendar_month (
    fsclmth_id VARCHAR(255) PRIMARY KEY,
    fsclmth_label VARCHAR(255),
    fsclmoy INT
);

CREATE TABLE staging.calendar_quarter (
    fsclqrtr_id VARCHAR(255) PRIMARY KEY,
    fsclqrtr_label VARCHAR(255),
    fsclqoy INT
);

CREATE TABLE staging.calendar_year (
    fsclyr_id VARCHAR(255) PRIMARY KEY,
    fsclyr_label VARCHAR(255)
);

CREATE TABLE staging.calendar_season(
    ssn_id VARCHAR(255) PRIMARY KEY,
    ssn_label VARCHAR(255)
);

INSERT INTO staging.calendar_day SELECT fscldt_id, fscldt_label, CAST(date AS DATE), CAST(fscldow AS INT), CAST(fscldom AS INT), CAST(fscldoq AS INT), CAST(fscldoy AS INT) FROM staging.hier_clnd_staging;
INSERT INTO staging.calendar_week SELECT fsclwk_id, fsclwk_label, CAST(fsclwoy AS INT) FROM staging.hier_clnd_staging GROUP BY fsclwk_id, fsclwk_label, fsclwoy;
INSERT INTO staging.calendar_month SELECT fsclmth_id, fsclmth_label, CAST(fsclmoy AS INT) FROM staging.hier_clnd_staging GROUP BY fsclmth_id, fsclmth_label, fsclmoy;
INSERT INTO staging.calendar_quarter SELECT fsclqrtr_id, fsclqrtr_label, CAST(fsclqoy AS INT) FROM staging.hier_clnd_staging GROUP BY fsclqrtr_id, fsclqrtr_label, fsclqoy;
INSERT INTO staging.calendar_year SELECT fsclyr_id, fsclyr_label FROM staging.hier_clnd_staging GROUP BY fsclyr_id, fsclyr_label;
INSERT INTO staging.calendar_season SELECT ssn_id, ssn_label FROM staging.hier_clnd_staging GROUP BY ssn_id, ssn_label;

-- Update fact_transactions_staging to use the normalized calendar tables.
ALTER TABLE staging.fact_transactions_staging ADD COLUMN calendar_day_id VARCHAR(255);
UPDATE staging.fact_transactions_staging SET calendar_day_id = fscldt_id;
ALTER TABLE staging.fact_transactions_staging DROP COLUMN fscldt_id;
ALTER TABLE staging.fact_transactions_staging ADD CONSTRAINT fk_calendar_day FOREIGN KEY (calendar_day_id) REFERENCES staging.calendar_day(fscldt_id);

--Update fact_averagecosts_staging to use the normalized calendar tables.
ALTER TABLE staging.fact_averagecosts_staging ADD COLUMN calendar_day_id VARCHAR(255);
UPDATE staging.fact_averagecosts_staging SET calendar_day_id = fscldt_id;
ALTER TABLE staging.fact_averagecosts_staging DROP COLUMN fscldt_id;
ALTER TABLE staging.fact_averagecosts_staging ADD CONSTRAINT fk_calendar_day_average_cost FOREIGN KEY (calendar_day_id) REFERENCES staging.calendar_day(fscldt_id);


--- final TABLE

CREATE TABLE mview_weekly_sales AS
   SELECT
       ft.pos_site_id,
       ft.sku_id,
       hc.fsclwk_id,
       ft.price_substate_id,
       ft.type,
       SUM(ft.sales_units) AS total_sales_units,
       SUM(ft.sales_dollars) AS total_sales_dollars,
       SUM(ft.discount_dollars) AS total_discount_dollars
   FROM fact_transactions ft
   JOIN hier_clnd hc ON ft.fscldt_id = hc.fscldt_id
   GROUP BY ft.pos_site_id, ft.sku_id, hc.fsclwk_id, ft.price_substate_id, ft.type;


--Validation
select * from mview_weekly_sales order by 3