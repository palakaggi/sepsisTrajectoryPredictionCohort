drop materialized view if exists sample cascade;
create materialized view sample as
--with all_charts as(
with gcs_eye as
(select hadm_id, subject_id, charttime, valuenum as gcs_eye
        from chartevents
         where itemid=220739),
gcs_motor as
(select hadm_id, subject_id, charttime, valuenum as gcs_motor
        from chartevents
        where itemid=223901),
gcs_verbal as
(
select hadm_id, subject_id, charttime, valuenum as gcs_verbal
        from chartevents
        where itemid=223900
),
all_charts as
(select distinct *
	from (select hadm_id, subject_id, charttime from gcs_eye
	union all
	select hadm_id, subject_id, charttime from gcs_motor
	union all
	select hadm_id, subject_id, charttime from gcs_verbal) as final)

select all_charts.*, gcs_eye.gcs_eye, gcs_motor.gcs_motor, gcs_verbal.gcs_verbal 
from all_charts
left outer join
gcs_eye
on all_charts.hadm_id=gcs_eye.hadm_id and
all_charts.subject_id=gcs_eye.subject_id and 
all_charts.charttime=gcs_eye.charttime
left outer join
gcs_motor
on all_charts.hadm_id=gcs_motor.hadm_id and
all_charts.subject_id=gcs_motor.subject_id and
all_charts.charttime=gcs_motor.charttime
left outer join
gcs_verbal
on all_charts.hadm_id=gcs_verbal.hadm_id and
all_charts.subject_id=gcs_verbal.subject_id and
all_charts.charttime=gcs_verbal.charttime;

select *, (gcs_eye+gcs_motor+gcs_verbal) as gcs_total from sample;
