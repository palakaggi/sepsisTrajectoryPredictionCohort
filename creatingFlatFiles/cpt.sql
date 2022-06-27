select subject_id as pat_id,
hadm_id as csn,
procedures_icd.icd_code as procedure_cpt_cd,
long_title as procedure_cpt_desc,
chartdate as procedure_dttm,
chartdate as procedure_day
from procedures_icd
left outer join
d_icd_procedures
on procedures_icd.icd_code = d_icd_procedures.icd_code
limit 10;
