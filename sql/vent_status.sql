select ventilation.*, ventilator_setting.subject_id, ventilator_setting.charttime, ventilator_setting.ventilator_mode, ventilator_setting.ventilator_type, ventilator_setting.respiratory_rate_set, ventilator_setting.tidal_volume_set, ventilator_setting.tidal_volume_observed, ventilator_setting.peep, ventilator_setting.fio2 from ventilation
inner join
ventilator_setting
on ventilation.stay_id=ventilator_setting.stay_id; 
