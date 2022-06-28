select
admissions.subject_id as pat_id,
null as first_name,
null as last_name,
null as mi,
null as dob,
case when gender='M' then 1
when gender='F' then 0
end as gender_code,
gender,
case when ethnicity='HISPANIC?LATINO' then 1
else 0
end as ethnicity_code,
ethnicity,
deathtime
from admissions
inner join
patients
on admissions.subject_id=patients.subject_id; 


