
copy etl_bankatm_data.dim_location
from 's3://etlprojectfolder/dim_location/part-00000-6e8d6aea-166a-4857-99dd-7afc8ac52965-c000.csv'
iam_role 'arn:aws:iam::954971563245:role/redshift_s3_fullaccess' 
delimiter ','
region 'us-east-1'
CSV;


copy etl_bankatm_data.dim_atm
from 's3://etlprojectfolder/dim_atm/part-00000-ba6dfb18-8c71-4ab8-89df-33a3769c9a54-c000.csv'
iam_role 'arn:aws:iam::954971563245:role/redshift_s3_fullaccess' 
delimiter ','
region 'us-east-1'
CSV;


copy etl_bankatm_data.dim_date 
from 's3://etlprojectfolder/dim_date/part-00000-fec0aa66-b69c-46d0-aa8d-1656a84a3a6a-c000.csv'
iam_role 'arn:aws:iam::954971563245:role/redshift_s3_fullaccess' 
delimiter ','
region 'us-east-1'
timeformat 'YYYY-MM-DDTHH:MI:SS'
CSV;


copy etl_bankatm_data.dim_card_type 
from 's3://etlprojectfolder/dim_card_type/part-00000-9ec5d809-a5a0-407a-8e08-c98823cc7683-c000.csv'
iam_role 'arn:aws:iam::954971563245:role/redshift_s3_fullaccess'
delimiter ','
region 'us-east-1'
CSV;


copy etl_bankatm_data.fact_atm_trans 
from 's3://etlprojectfolder/fact_atm_trans/part-00000-a8ad8a1c-cf90-4b66-92e7-1e51dbc5755a-c000.csv'
iam_role 'arn:aws:iam::954971563245:role/redshift_s3_fullaccess'
delimiter ',' region 'us-east-1'
CSV;