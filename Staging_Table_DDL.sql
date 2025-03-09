-- Staging Table: fact_transactions_staging
CREATE TABLE fact_transactions_staging (
    order_id VARCHAR(255),
    line_id VARCHAR(255),
    type VARCHAR(255),
    dt VARCHAR(255),
    pos_site_id VARCHAR(255),
    sku_id VARCHAR(255),
    fscldt_id VARCHAR(255),
    price_substate_id VARCHAR(255),
    sales_units VARCHAR(255),
    sales_dollars VARCHAR(255),
    discount_dollars VARCHAR(255),
    original_order_id VARCHAR(255),
    original_line_id VARCHAR(255)
);

-- Staging Table: fact_averagecosts_staging
CREATE TABLE fact_averagecosts_staging (
    fscldt_id VARCHAR(255),
    sku_id VARCHAR(255),
    average_unit_standardcost VARCHAR(255),
    average_unit_landedcost VARCHAR(255)
);

-- Staging Tables: hier_*.txt
CREATE TABLE hier_clnd_staging (
    fscldt_id VARCHAR(255),
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
    fscldow VARCHAR(255),
    fscldom VARCHAR(255),
    fscldoq VARCHAR(255),
    fscldoy VARCHAR(255),
    fsclwoy VARCHAR(255),
    fsclmoy VARCHAR(255),
    fsclqoy VARCHAR(255),
    date VARCHAR(255)
);

CREATE TABLE hier_hldy_staging(
    hldy_id VARCHAR(255),
    hldy_label VARCHAR(255)
);

CREATE TABLE hier_invloc_staging(
    loc VARCHAR(255),
    loc_label VARCHAR(255),
    loctype VARCHAR(255),
    loctype_label VARCHAR(255)
);

CREATE TABLE hier_invstatus_staging(
    code_id VARCHAR(255),
    code_label VARCHAR(255),
    bckt_id VARCHAR(255),
    bckt_label VARCHAR(255),
    ownrshp_id VARCHAR(255),
    ownrshp_label VARCHAR(255)
);

CREATE TABLE hier_possite_staging(
    site_id VARCHAR(255),
    site_label VARCHAR(255),
    subchnl_id VARCHAR(255),
    subchnl_label VARCHAR(255),
    chnl_id VARCHAR(255),
    chnl_label VARCHAR(255)
);

CREATE TABLE hier_pricestate_staging(
    substate_id VARCHAR(255),
    substate_label VARCHAR(255),
    state_id VARCHAR(255),
    state_label VARCHAR(255)
);

CREATE TABLE hier_prod_staging(
    sku_id VARCHAR(255),
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

CREATE TABLE hier_rtlloc_staging(
    str VARCHAR(255),
    str_label VARCHAR(255),
    dstr VARCHAR(255),
    dstr_label VARCHAR(255),
    rgn VARCHAR(255),
    rgn_label VARCHAR(255)
);