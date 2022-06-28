select 
subject_id as pat_id,
hadm_id as csn,
case when procedures_icd.icd_version=9 then procedures_icd.icd_code
else null 
end as icd9_procedure_code,
case when procedures_icd.icd_version=10 then procedures_icd.icd_code
else null
end as icd10_procedure_code,
long_title as procedure_desc,
chartdate as procedure_date,
null as performing_physician
from procedures_icd
left outer join
(select distinct * from d_icd_procedures) t2
on t2.icd_code=procedures_icd.icd_code
and t2.icd_version = procedures_icd.icd_version;

