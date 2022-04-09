drop materialized view if exists sample cascade;
create materialized view sample as
--with all_charts as(
with spo2Tab as
(select hadm_id, subject_id, stay_id,  charttime, valuenum as spo2
        from chartevents
         where itemid=220277),
fio2Tab as
(select hadm_id, subject_id, stay_id, charttime, valuenum as fio2
        from chartevents
        where itemid=223835),
oxy_flow_rt as
(
select hadm_id, subject_id, stay_id, charttime, valuenum as oxygen_flow_rate
	from chartevents
	where itemid in (223834,227287)
),
sao2Tab as
(
select hadm_id, subject_id,stay_id,  charttime, valuenum as sao2
	from chartevents
	where itemid=220227
),
all_charts as
(select distinct *
        from (select hadm_id, subject_id,stay_id, charttime from spo2Tab
                union all
        select hadm_id, subject_id, stay_id,  charttime from fio2Tab
		union all
	select hadm_id, subject_id, stay_id,charttime from oxy_flow_rt
		union all
	select hadm_id, subject_id, stay_id, charttime from sao2Tab) as final)

--select * from all_charts limit 10;


select all_charts.*, spo2Tab.spo2, fio2Tab.fio2, oxy_flow_rt.oxygen_flow_rate, sao2Tab.sao2
from all_charts
left outer join
spo2Tab
on all_charts.hadm_id=spo2Tab.hadm_id and 
all_charts.subject_id=spo2Tab.subject_id and
all_charts.stay_id=spo2Tab.stay_id and 
all_charts.charttime=spo2Tab.charttime
left outer join
fio2Tab
on fio2Tab.hadm_id=all_charts.hadm_id and
fio2Tab.subject_id=all_charts.subject_id and
fio2Tab.stay_id=all_charts.stay_id and
fio2Tab.charttime=all_charts.charttime
left outer join
oxy_flow_rt
on all_charts.hadm_id=oxy_flow_rt.hadm_id and
all_charts.subject_id=oxy_flow_rt.subject_id and
all_charts.stay_id=oxy_flow_rt.stay_id and
all_charts.charttime=oxy_flow_rt.charttime
left outer join
sao2Tab
on all_charts.hadm_id=sao2Tab.hadm_id and
all_charts.subject_id=sao2Tab.subject_id and
all_charts.stay_id=sao2Tab.stay_id and
all_charts.charttime=sao2Tab.charttime;

select * from sample;
