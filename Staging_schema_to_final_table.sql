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
select * from mview_weekly_sales 
