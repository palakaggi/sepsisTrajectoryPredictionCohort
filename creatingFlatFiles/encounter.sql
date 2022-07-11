select admissions.subject_id as pat_id, 
admissions.hadm_id as csn,
anchor_age as age, 
null as zip_code,
null as ed_arrival_source,
null as pre_admit_location,
edregtime as ed_presentation_time, 
admittime as hospital_admission_date_time, 
dischtime as hospital_discharge_date_time,
description as admit_reason,
insurance as insurance,
null as cpr_in_bed,
icu.los as total_icu_days,
date_part('day', starttime-endtime) as total_vent_days,
date_part('day',dischtime-admittime) as total_hosp_days,
null as discharge_status,
discharge_location as discharge_to,
admission_type as encounter_type,
admission_location as facility_nm
from admissions
left outer join
drgcodes
on admissions.hadm_id=drgcodes.hadm_id
left outer join
patients
on admissions.subject_id=patients.subject_id
left outer join
icustays as icu
on icu.hadm_id=admissions.hadm_id
left outer join
ventilation
on ventilation.stay_id=icu.stay_id;

