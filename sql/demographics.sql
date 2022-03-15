
--MERGING ICUSTAY TABLE WITH PATIENT TO FIND ALL PATIENTS IN ICU
create temp table demographics as (
with icu_patient as 
(select icu.subject_id as icu_sub_id, icu.hadm_id, icu.stay_id, icu.first_careunit, icu.last_careunit, icu.intime, icu.outtime, icu.los, patient.* 
from
icustays as icu
right outer join 
patients as patient
using(subject_id)),
icu_yes as
(select distinct icu_patient.subject_id,icu_patient.gender,icu_patient.anchor_age, icu_patient.hadm_id, icu_patient.stay_id, icu_patient.first_careunit, icu_patient.last_careunit, icu_patient.intime, icu_patient.outtime, icu_patient.los, CASE WHEN icu_patient.intime is NOT NULL then 'YES' else 'NO'
END AS wasInICU
from icu_patient),
dems as
(select distinct admissions.ethnicity,
  icu_yes.*
  ,height.height,
   first_day_weight.weight
 from admissions
right join 
icu_yes
using(subject_id)
left join
height
using(subject_id)
left join 
first_day_weight
using(subject_id))
select * from dems);
--select * from dems limit 10;
select * from demographics;

--select height, weight, subject_id from demographics limit 10;
/*temp as 
(select vital.subject_id, vital.charttime, vital.valuenum as temperature
from chartevents as vital 
where itemid in (223762,2237611))
select i.subject_id, t.temperature
from temp as t
right join 
icu_yes as i
on i.subject_id=t.subject_id limit 500;
*/

