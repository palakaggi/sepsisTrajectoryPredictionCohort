with care as
(select * from transfers where eventtype not like 'discharge')

select admissions.subject_id as pat_id,
admissions.hadm_id as csn,
admittime as bed_location_start,
dischtime as bed_location_end,
null as bed_unit,
null as bed_room,
null as bed_id,
null as bed_label,
curr_service as hospital_service,
careunit as accomodation_description
from admissions
left outer join
services
on admissions.hadm_id=services.hadm_id
left outer join
care
on admissions.hadm_id=care.hadm_id;


