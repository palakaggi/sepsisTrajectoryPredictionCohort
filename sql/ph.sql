with arterial as
(select subject_id, stay_id, hadm_id, charttime, valuenum as ph_arterial
from chartevents where itemid=223830),
venous as 
(select subject_id, stay_id, hadm_id, charttime, valuenum as ph_venous 
from chartevents where itemid=220274),
merged as 
(select arterial.*, venous.ph_venous
from arterial
inner join
venous
on arterial.stay_id=venous.stay_id and
arterial.subject_id=venous.subject_id and
arterial.hadm_id=venous.hadm_id and 
arterial.charttime=venous.charttime)

select * from merged; 
