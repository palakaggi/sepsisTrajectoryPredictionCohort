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
null as race_code,
case when ethnicity='HISPANIC?LATINO' then 'Unknown'
else ethnicity
end 
as race,
case when ethnicity='HISPANIC?LATINO' then 0
else 1
end as ethnicity_code,
case when ethnicity='HISPANIC?LATINO' then ethnicity
else 'Non-hispanic or Latino'
end
as ethnicity,
deathtime as death_date,
null as last4_ssn
from admissions
inner join
patients
on admissions.subject_id=patients.subject_id; 


