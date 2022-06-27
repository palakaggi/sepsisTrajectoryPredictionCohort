select subject_id as pat_id,
--hadm_id as csn,
charttime as recorded_time,
gcs as gcs_total_score,
gcs_verbal as gcs_verbal_score,
gcs_eyes as gcs_eye_score,
gcs_motor as gcs_motor_score
from gcs limit 10;
