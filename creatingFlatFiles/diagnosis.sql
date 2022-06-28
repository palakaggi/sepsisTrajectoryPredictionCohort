select subject_id as pat_id,
--	hadm_id as csn,
	seq_num as dx_line,
	null as dx_icd_scope,
	case 
	when diagnosis.icd_version=9 then diagnosis.icd_code
	else null
	end as dx_code_icd9,
	case when diagnosis.icd_version=10 then diagnosis.icd_code
	else null
	end as dx_code_icd10,
	long_title as dx_name 
from diagnosis
inner join
d_icd_diagnoses
on diagnosis.icd_code=d_icd_diagnoses.icd_code and
diagnosis.icd_version = d_icd_diagnoses.icd_version;


