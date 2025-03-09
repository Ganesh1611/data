
**GSynergy Data Engineer Interview Challenge - Implementation Details**

**1. Introduction**

This document details the step-by-step implementation of the GSynergy Data Engineer Interview Challenge. The challenge required us to build an ELT pipeline using AWS Redshift, perform data quality checks, normalize data, and create a refined table for analysis.

**2. Challenge Requirements**

The core requirements were:

* Inferring data models from provided data.
* Designing and developing an ELT pipeline in AWS Redshift.
* Performing data quality checks (non-null, uniqueness, foreign keys).
* Creating a staging schema and normalizing hierarchy tables.
* Establishing foreign key relationships.
* Creating the `mview_weekly_sales` table.

**3. Initial Setup**

* We began by accessing the AWS Redshift console.
* We created a Redshift cluster.
* We used the Redshift Query Editor v2 for executing SQL commands.
* We created an IAM role with the `AmazonS3ReadOnlyAccess` policy, and attached that role to the Redshift cluster.
* We uploaded the provided data files to an S3 bucket.

**4. Data Loading (S3 to Redshift)**

* We used the `COPY` command to load the raw data files from the S3 bucket into Redshift staging tables.
* Example `COPY` command:

    ```sql
    COPY fact_transactions_staging
    FROM 's3://your-bucket/fact.transactions.txt'
    IAM_ROLE 'arn:aws:iam::your-account-id:role/your-redshift-role'
    DELIMITER '|'
    IGNOREHEADER 1
    REMOVEQUOTES;
    ```

* We repeated the `COPY` command for each of the provided data files, changing the target table and the S3 file path accordingly.

**5. Data Quality Checks**

* We performed the following data quality checks:
    * **Non-Null Checks:** Used `SELECT COUNT(*) FROM table WHERE column IS NULL;` to identify null values in critical columns.
    * **Uniqueness of Primary Keys:** Used `SELECT primary_key, COUNT(*) FROM table GROUP BY primary_key HAVING COUNT(*) > 1;` to identify duplicate primary keys.
    * **Foreign Key Constraints:** Used `SELECT COUNT(*) FROM fact_table LEFT JOIN dimension_table ON fact_table.foreign_key = dimension_table.primary_key WHERE dimension_table.primary_key IS NULL;` to check for invalid foreign key values.
* We identified duplicate primary keys, and used the following method to remove them.
    * Using the `ROW_NUMBER()` window function and a CTE to remove duplicate rows.

        ```sql
        WITH RankedDuplicates AS (
            SELECT
                *,
                ROW_NUMBER() OVER (PARTITION BY order_id, line_id ORDER BY order_id, line_id) AS rn
            FROM fact_transactions_staging
        )
        DELETE FROM fact_transactions_staging
        WHERE (order_id, line_id) IN (SELECT order_id, line_id FROM RankedDuplicates WHERE rn > 1);
        ```

* We repeated this process for the other table that had duplicate primary keys.
* We re-ran the quality check queries to confirm that the duplicates had been removed.

**6. Staging Schema and Normalization**

* We created a `staging` schema using `CREATE SCHEMA staging;`.
* We used `CREATE TABLE staging.table_name AS SELECT * FROM public.table_name;` to move the staging tables into the staging schema.
* We normalized the `hier_clnd` table into `calendar_day`, `calendar_week`, `calendar_month`, `calendar_quarter`, `calendar_year`, and `calendar_season` tables.
* We created foreign key relationships between the `fact_transactions_staging` and normalized calendar tables.

**7. Refined Table (`mview_weekly_sales`)**

* We created the `mview_weekly_sales` table using the following query:

    ```sql
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
    ```


**8. GitHub Repository**

* We created a GitHub repository to host the code, scripts, and documentation.
* We included a `README.md` file with detailed instructions and explanations.
* We organized the repository logically.

**9. Video Demonstration**

* We created a screen recording demonstrating the implementation of the solution.
* The video covered all the steps outlined in this document.
* We explained our approach and the rationale behind our choices.
* We uploaded the video in a way that it can be played directly within the browser.

**11. Conclusion**

This challenge allowed us to demonstrate our skills in data modeling, ETL pipeline development, and data quality assurance using AWS Redshift. The implemented solution meets the core requirements of the challenge and provides a solid foundation for further analysis.
