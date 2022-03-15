with line as
(select hadm_id, subject_id, charttime, valuenum as map_line
        from chartevents 
         where itemid in (225312, 220052, 224322)),
cuff as
(select hadm_id, subject_id, charttime, valuenum as map_cuff
        from chartevents 
        where itemid=220181),
first as (
select
        coalesce(line.hadm_id, cuff.hadm_id) as hadm_id,
        coalesce(line.subject_id, cuff.subject_id) as subject_id,
        coalesce(line.charttime, cuff.charttime) as charttime,
        coalesce(line.map_line, null) as map_line_in_mmHg,
        coalesce(cuff.map_cuff, null) as map_cuff_in_mmHg
from line
full outer join
cuff
on
line.hadm_id=cuff.hadm_id and
line.subject_id=cuff.subject_id and
line.charttime=cuff.charttime)

select * from first;

