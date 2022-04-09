with temp as 
(select hadm_id, subject_id, charttime, stay_id, valuenum as temperature
	from chartevents 
	 where itemid in (223762,223761)),
sbp as 
(select hadm_id, subject_id, charttime,stay_id, valuenum as sbp_line
	from chartevents 
	where itemid in (225309,220050)),
sbp2 as 
(select hadm_id, subject_id, charttime,stay_id, valuenum as sbp_cuff
	from chartevents
	where itemid in (224167,227243,220179)),
dbp_line as
(select hadm_id, subject_id, charttime,stay_id, valuenum as dbp_line
        from chartevents
        where itemid in (225310, 220051)),
dbp_cuff as
(select hadm_id, subject_id, charttime, stay_id, valuenum as dbp_cuff
        from chartevents
        where itemid in (224643,220180,227242)),
first as (
select 
        coalesce(temp.hadm_id, sbp.hadm_id) as hadm_id,
        coalesce(temp.subject_id, sbp.subject_id) as subject_id,
	coalesce(temp.stay_id, sbp.stay_id) as stay_id,
        coalesce(temp.charttime, sbp.charttime) as charttime,
        coalesce(temp.temperature, null) as temperature,
	coalesce(sbp.sbp_line, null) as sbp_line
from temp
full outer join
sbp
on 
temp.hadm_id=sbp.hadm_id and
temp.subject_id=sbp.subject_id and
temp.stay_id = sbp.stay_id and
temp.charttime=sbp.charttime),
second as(
select 
	coalesce(first.hadm_id, sbp2.hadm_id) as hadm_id,
	coalesce(first.subject_id, sbp2.subject_id) as subject_id,
	coalesce(first.charttime, sbp2.charttime) as charttime,
	coalesce(first.stay_id, sbp2.stay_id) as stay_id,
	coalesce(first.temperature,null) as temperature,
	coalesce(first.sbp_line,null) as sbp_line,
	coalesce(sbp2.sbp_cuff, null) as sbp_cuff
from first
full outer join
sbp2
on 
first.hadm_id=sbp2.hadm_id and 
first.subject_id=sbp2.subject_id and
first.stay_id=sbp2.stay_id and 
first.charttime=sbp2.charttime),
third as (
select 
	coalesce(second.hadm_id, dbp_line.hadm_id) as hadm_id,
	coalesce(second.subject_id, dbp_line.subject_id) as subject_id,
	coalesce(second.charttime, dbp_line.charttime) as charttime,
	coalesce(second.stay_id, dbp_line.stay_id) as stay_id,
	coalesce(second.temperature, null) as temperature,
	coalesce(second.sbp_line, null) as sbp_line,
	coalesce(second.sbp_cuff, null) as sbp_cuff,
	coalesce(dbp_line.dbp_line, null) as dbp_line
from second
full outer join
dbp_line
on second.hadm_id=dbp_line.hadm_id and
second.subject_id=dbp_line.subject_id and
second.stay_id=dbp_line.stay_id and
second.charttime=dbp_line.charttime),
fourth as (
select
        coalesce(third.hadm_id, dbp_cuff.hadm_id) as hadm_id,
        coalesce(third.subject_id, dbp_cuff.subject_id) as subject_id,
        coalesce(third.charttime, dbp_cuff.charttime) as charttime,
	coalesce(third.stay_id, dbp_cuff.stay_id) as stay_id,
        coalesce(third.temperature, null) as temperature,
        coalesce(third.sbp_line, null) as sbp_line,
        coalesce(third.sbp_cuff, null) as sbp_cuff,
        coalesce(third.dbp_line, null) as dbp_line,
	coalesce(dbp_cuff.dbp_cuff, null) as dbp_cuff
from third
full outer join
dbp_cuff
on third.hadm_id=dbp_cuff.hadm_id and
third.subject_id=dbp_cuff.subject_id and
third.stay_id=dbp_cuff.stay_id and
third.charttime=dbp_cuff.charttime)

select * from fourth;
	
