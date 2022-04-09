drop materialized view if exists sample cascade;
create materialized view sample as(
with abea as
(
select subject_id,hadm_id,stay_id, charttime, value as ABEA_mEq_per_L
from chartevents 
where itemid=224828),
anion_gap as
(select subject_id,hadm_id, stay_id, charttime, value as anion_gap_mEq_per_L
from chartevents
where itemid=227073),
bicarb as
(
select subject_id,hadm_id, stay_id, charttime, value as bicarb_mEq_per_L
from chartevents 
where itemid=227443),
bun as
(
select subject_id, hadm_id,stay_id,  charttime, value as bun_mg_per_dL
from chartevents 
where itemid in (225624, 227000)),
all_charts as
(select distinct *
        from (select hadm_id, subject_id, stay_id, charttime from abea
                union all
        select hadm_id, subject_id, stay_id,  charttime from anion_gap
                union all
        select hadm_id, subject_id, stay_id, charttime from bicarb
                union all
        select hadm_id, subject_id, stay_id, charttime from bun) as final)

select all_charts.*, anion_gap.anion_gap_mEq_per_L, abea.ABEA_mEq_per_L, bicarb.bicarb_mEq_per_L, bun.bun_mg_per_dL
from all_charts
left outer join
anion_gap
on all_charts.subject_id=anion_gap.subject_id and
all_charts.hadm_id=anion_gap.hadm_id and
all_charts.stay_id=anion_gap.stay_id and
all_charts.charttime=anion_gap.charttime
left outer join 
abea
on all_charts.subject_id=abea.subject_id and
all_charts.hadm_id=abea.hadm_id and
all_charts.stay_id=abea.stay_id and
all_charts.charttime=abea.charttime
left outer join
bicarb
on all_charts.subject_id=bicarb.subject_id and
all_charts.hadm_id=bicarb.hadm_id and
all_charts.stay_id=bicarb.stay_id and
all_charts.charttime=bicarb.charttime
left outer join
bun
on all_charts.subject_id=bun.subject_id and
all_charts.hadm_id=bun.hadm_id and
all_charts.stay_id=bun.stay_id and
all_charts.charttime=bun.charttime);

select * from sample;
