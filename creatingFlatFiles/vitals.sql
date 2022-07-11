select 
vitalsign.subject_id as pat_id,
hadm_id as csn,
vitalsign.charttime as recorded_time,
temperature as temperature,
temperature_site as temproute,
weight as daily_weight_kg,
height as height_cm,
sbp as sbp_line,
dbp as dbp_line,
mbp as map_line,
sbp_ni as sbp_cuff,
dbp_ni as dbp_cuff,
mbp_ni as map_cuff,
heart_rate as pulse,
resp_rate as unassisted_resp_rate,
spo2 as spo2,
null as o2_device,
null as cvp,
null as end_tidal_co2,
null as o2_flow_rate
 from vitalsign
inner join
height
on height.stay_id=vitalsign.stay_id
inner join
first_day_weight
on first_day_weight.stay_id=vitalsign.stay_id
left outer join 
icustays
on vitalsign.stay_id=icustays.stay_id;
