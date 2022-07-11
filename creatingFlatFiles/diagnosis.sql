select subject_id as pat_id,
	hadm_id as csn,
	seq_num as dx_line,
	'Billing Diagnosis' as dx_icd_scope,
	case 
	when diagnoses_icd.icd_version=9 then diagnoses_icd.icd_code
	else null
	end as dx_code_icd9,
	case when diagnoses_icd.icd_version=10 then diagnoses_icd.icd_code
	else null
	end as dx_code_icd10,
	null as dx_source,
	null as dx_time_date,
	diagnoses_icd.icd_code as dx_code,	
	long_title as dx_name 
from diagnoses_icd
inner join
d_icd_diagnoses
on diagnoses_icd.icd_code=d_icd_diagnoses.icd_code and
diagnoses_icd.icd_version = d_icd_diagnoses.icd_version;


