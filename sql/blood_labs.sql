drop materialized view if exists sample cascade;
create materialized view sample as
with hemoglobin as 
(
select hadm_id, subject_id, stay_id, charttime, valuenum as hemoglobin
from chartevents 
where itemid=220228
),
plats as
(select hadm_id, subject_id, stay_id, charttime, valuenum as platelets
from chartevents
where itemid=227457
),
wbc as 
(select hadm_id, subject_id, stay_id, charttime, valuenum as wbc_count
from chartevents
where itemid=220546
),
carboxy_hg as
(select hadm_id, subject_id, charttime, valuenum as carboxy_hemoglobin
from labevents
where itemid=50805
),
all_charts as
(select distinct *
	from (select hadm_id, subject_id, charttime from hemoglobin
		union all
	select hadm_id, subject_id, charttime from plats
		union all
	select hadm_id, subject_id, charttime from wbc
		union all
	select hadm_id, subject_id, charttime from carboxy_hg) as final)
select all_charts.*, hemoglobin.hemoglobin, plats.platelets, wbc.wbc_count, carboxy_hg.carboxy_hemoglobin
from all_charts
left outer join
hemoglobin
on all_charts.hadm_id=hemoglobin.hadm_id and
all_charts.subject_id=hemoglobin.subject_id and
--all_charts.stay_id=hemoglobin.stay_id and
all_charts.charttime=hemoglobin.charttime
left outer join
plats
on --all_charts.stay_id=plats.stay_id and
all_charts.hadm_id=plats.hadm_id and 
all_charts.subject_id=plats.subject_id and 
all_charts.charttime=plats.charttime
left outer join
wbc
on all_charts.hadm_id=wbc.hadm_id and 
all_charts.subject_id=wbc.subject_id and
--all_charts.stay_id=wbc.stay_id and 
all_charts.charttime=wbc.charttime
left outer join
carboxy_hg
on --all_charts.stay_id=carboxy_hg.stay_id and 
all_charts.hadm_id=carboxy_hg.hadm_id and
all_charts.subject_id=carboxy_hg.subject_id and
all_charts.charttime=carboxy_hg.charttime;

select * from sample;
