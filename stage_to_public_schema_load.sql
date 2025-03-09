-- Final Table: fact_transactions
CREATE TABLE fact_transactions (
    order_id VARCHAR(255) DISTKEY SORTKEY,
    line_id VARCHAR(255),
    type VARCHAR(255),
    dt TIMESTAMP,
    pos_site_id VARCHAR(255),
    sku_id VARCHAR(255),
    fscldt_id VARCHAR(255),
    price_substate_id VARCHAR(255),
    sales_units INT,
    sales_dollars DECIMAL,
    discount_dollars DECIMAL,
    original_order_id VARCHAR(255),
    original_line_id VARCHAR(255)
);

-- Final Table: fact_averagecosts
CREATE TABLE fact_averagecosts (
    fscldt_id VARCHAR(255) DISTKEY SORTKEY,
    sku_id VARCHAR(255),
    average_unit_standardcost DECIMAL,
    average_unit_landedcost DECIMAL
);

-- Final Table: hier_clnd
CREATE TABLE hier_clnd (
    fscldt_id VARCHAR(255) PRIMARY KEY DISTKEY SORTKEY,
    fscldt_label VARCHAR(255),
    fsclwk_id VARCHAR(255),
    fsclwk_label VARCHAR(255),
    fsclmth_id VARCHAR(255),
    fsclmth_label VARCHAR(255),
    fsclqrtr_id VARCHAR(255),
    fsclqrtr_label VARCHAR(255),
    fsclyr_id VARCHAR(255),
    fsclyr_label VARCHAR(255),
    ssn_id VARCHAR(255),
    ssn_label VARCHAR(255),
    ly_fscldt_id VARCHAR(255),
    lly_fscldt_id VARCHAR(255),
    fscldow INT,
    fscldom INT,
    fscldoq INT,
    fscldoy INT,
    fsclwoy INT,
    fsclmoy INT,
    fsclqoy INT,
    date DATE
);

-- Final Table: hier_hldy
CREATE TABLE hier_hldy (
    hldy_id VARCHAR(255) PRIMARY KEY DISTKEY SORTKEY,
    hldy_label VARCHAR(255)
);

-- Final Table: hier_invloc
CREATE TABLE hier_invloc (
    loc VARCHAR(255) PRIMARY KEY DISTKEY SORTKEY,
    loc_label VARCHAR(255),
    loctype VARCHAR(255),
    loctype_label VARCHAR(255)
);

-- Final Table: hier_invstatus
CREATE TABLE hier_invstatus (
    code_id VARCHAR(255) PRIMARY KEY DISTKEY SORTKEY,
    code_label VARCHAR(255),
    bckt_id VARCHAR(255),
    bckt_label VARCHAR(255),
    ownrshp_id VARCHAR(255),
    ownrshp_label VARCHAR(255)
);

-- Final Table: hier_possite
CREATE TABLE hier_possite (
    site_id VARCHAR(255) PRIMARY KEY DISTKEY SORTKEY,
    site_label VARCHAR(255),
    subchnl_id VARCHAR(255),
    subchnl_label VARCHAR(255),
    chnl_id VARCHAR(255),
    chnl_label VARCHAR(255)
);

-- Final Table: hier_pricestate
CREATE TABLE hier_pricestate (
    substate_id VARCHAR(255) PRIMARY KEY DISTKEY SORTKEY,
    substate_label VARCHAR(255),
    state_id VARCHAR(255),
    state_label VARCHAR(255)
);

-- Final Table: hier_prod
CREATE TABLE hier_prod (
    sku_id VARCHAR(255) PRIMARY KEY DISTKEY SORTKEY,
    sku_label VARCHAR(255),
    stylclr_id VARCHAR(255),
    stylclr_label VARCHAR(255),
    styl_id VARCHAR(255),
    styl_label VARCHAR(255),
    subcat_id VARCHAR(255),
    subcat_label VARCHAR(255),
    cat_id VARCHAR(255),
    cat_label VARCHAR(255),
    dept_id VARCHAR(255),
    dept_label VARCHAR(255),
    issvc VARCHAR(255),
    isasmbly VARCHAR(255),
    isnfs VARCHAR(255)
);

-- Final Table: hier_rtlloc
CREATE TABLE hier_rtlloc (
    str VARCHAR(255) PRIMARY KEY DISTKEY SORTKEY,
    str_label VARCHAR(255),
    dstr VARCHAR(255),
    dstr_label VARCHAR(255),
    rgn VARCHAR(255),
    rgn_label VARCHAR(255)
);


-----------------------*********************----------------------

-- Load fact_transactions
INSERT INTO fact_transactions
SELECT
    order_id,
    line_id,
    type,
    CAST(dt AS TIMESTAMP),
    pos_site_id,
    sku_id,
    fscldt_id,
    price_substate_id,
    CAST(sales_units AS INT), 
    CAST(sales_dollars AS DECIMAL),
    CAST(discount_dollars AS DECIMAL), 
    original_order_id,
    original_line_id
FROM fact_transactions_staging;

-- Load fact_averagecosts
INSERT INTO fact_averagecosts
SELECT
    fscldt_id,
    sku_id,
    CAST(average_unit_standardcost AS DECIMAL),
    CAST(average_unit_landedcost AS DECIMAL)
FROM fact_averagecosts_staging;

-- Load hier_clnd
INSERT INTO hier_clnd
SELECT
    fscldt_id,
    fscldt_label,
    fsclwk_id,
    fsclwk_label,
    fsclmth_id,
    fsclmth_label,
    fsclqrtr_id,
    fsclqrtr_label,
    fsclyr_id,
    fsclyr_label,
    ssn_id,
    ssn_label,
    ly_fscldt_id,
    lly_fscldt_id,
    CAST(fscldow AS INT),
    CAST(fscldom AS INT),
    CAST(fscldoq AS INT),
    CAST(fscldoy AS INT),
    CAST(fsclwoy AS INT),
    CAST(fsclmoy AS INT),
    CAST(fsclqoy AS INT),
    CAST(date AS DATE)
FROM hier_clnd_staging;

-- Load hier_hldy, hier_invloc, hier_invstatus, hier_possite, hier_pricestate, hier_prod, hier_rtlloc (No transformation needed as per ER Diagram)
INSERT INTO hier_hldy SELECT * FROM hier_hldy_staging;
INSERT INTO hier_invloc SELECT * FROM hier_invloc_staging;
INSERT INTO hier_invstatus SELECT * FROM hier_invstatus_staging;
INSERT INTO hier_possite SELECT * FROM hier_possite_staging;
INSERT INTO hier_pricestate SELECT * FROM hier_pricestate_staging;
INSERT INTO hier_prod SELECT * FROM hier_prod_staging;
INSERT INTO hier_rtlloc SELECT * FROM hier_rtlloc__staging;
