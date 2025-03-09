-- Load fact_transactions_staging
COPY fact_transactions_staging
FROM 's3://gsynergy-data-challenge-gani/fact.transactions.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;

-- Load fact_averagecosts_staging
COPY fact_averagecosts_staging
FROM 's3://gsynergy-data-challenge-gani/fact.averagecosts.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;

-- Load hier_clnd_staging
COPY hier_clnd_staging
FROM 's3://gsynergy-data-challenge-gani/hier.clnd.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;

-- Load hier_hldy_staging
COPY hier_hldy_staging
FROM 's3://gsynergy-data-challenge-gani/hier.hldy.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;

-- Load hier_invloc_staging
COPY hier_invloc_staging
FROM 's3://gsynergy-data-challenge-gani/hier.invloc.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;

-- Load hier_invstatus_staging
COPY hier_invstatus_staging
FROM 's3://gsynergy-data-challenge-gani/hier.invstatus.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;

-- Load hier_possite_staging
COPY hier_possite_staging
FROM 's3://gsynergy-data-challenge-gani/hier.possite.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;

-- Load hier_pricestate_staging
COPY hier_pricestate_staging
FROM 's3://gsynergy-data-challenge-gani/hier.pricestate.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;

-- Load hier_prod_staging
COPY hier_prod_staging
FROM 's3://gsynergy-data-challenge-gani/hier.prod.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;

-- Load hier_rtlloc_staging
COPY hier_rtlloc_staging
FROM 's3://gsynergy-data-challenge-gani/hier.rtlloc.dlm'
IAM_ROLE 'arn:aws:iam::543485142494:role/RedshiftS3AccessRole'
DELIMITER '|'
IGNOREHEADER 1
REMOVEQUOTES;