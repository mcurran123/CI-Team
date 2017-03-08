use mcurran;
set hive.exec.dynamic.partition.mode=nonstrict;

create table if not exists mcurran.resp_qc (
completion_utc_dateint_bh STRING,
country_bh STRING,
num_surveyed_bh BIGINT
);

INSERT OVERWRITE TABLE  mcurran.resp_qc
SELECT 
a.completion_utc_dateint as completion_utc_dateint_bh, 
c.cooked as country_bh,
COUNT(DISTINCT a.respondent_uuid) as num_surveyed_bh
FROM dse.srv_decipher_bh_f a 
INNER JOIN 
dse.srv_decipher_bh_demo_d b 
ON a.completion_utc_dateint = b.completion_utc_dateint
AND a.respondent_uuid = b.respondent_uuid
LEFT OUTER JOIN
mcurran.bh_countrymap c 
ON b.country_text = c.raw
GROUP BY 1,2



