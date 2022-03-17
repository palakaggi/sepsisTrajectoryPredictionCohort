with HR as
(select hadm_id, subject_id, charttime, valuenum as pulse
        from chartevents
         where itemid in (220045, 220046, 220047)),
RR as
(select hadm_id, subject_id, charttime, valuenum as respiratory_rate
        from chartevents
        where itemid in (220210, 224688, 224689, 224690)),
first as (
select
        coalesce(HR.hadm_id, RR.hadm_id) as hadm_id,
        coalesce(HR.subject_id, RR.subject_id) as subject_id,
        coalesce(HR.charttime, RR.charttime) as charttime,
        coalesce(HR.pulse, null) as pulse,
        coalesce(RR.respiratory_rate, null) as resp_rate_insp_per_min
from HR
full outer join
RR
on
HR.hadm_id=RR.hadm_id and
HR.subject_id=RR.subject_id and
HR.charttime=RR.charttime)

select * from first;
