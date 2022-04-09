drop materialized view if exists sample cascade;
create materialized view sample as(
with non_ion as
(
select subject_id,hadm_id,stay_id, charttime, cast(value as numeric) as Cal_non_ionized_mg_per_dL
from chartevents 
where itemid=225625),
ionized as
(select subject_id,hadm_id, stay_id, charttime, (cast(value as numeric)*4.01) as cal_ionized_mg_per_dL
from chartevents
where itemid=225667),
all_charts as
(select distinct *
	from (select hadm_id, subject_id,stay_id, charttime from non_ion
		union all
	select hadm_id, subject_id,stay_id, charttime from ionized) as final),
merge as(
select all_charts.*, non_ion.Cal_non_ionized_mg_per_dL, ionized.cal_ionized_mg_per_dL
from all_charts 
left outer join
non_ion
on all_charts.hadm_id=non_ion.hadm_id and
all_charts.subject_id=non_ion.subject_id and
all_charts.stay_id=non_ion.stay_id and
all_charts.charttime=non_ion.charttime
left outer join
ionized
on all_charts.hadm_id=ionized.hadm_id and
all_charts.subject_id=ionized.subject_id and
all_charts.stay_id=ionized.stay_id and
all_charts.charttime=ionized.charttime)

select merge.*, Cal_non_ionized_mg_per_dL + cal_ionized_mg_per_dL as total
from merge);

select * from sample;
