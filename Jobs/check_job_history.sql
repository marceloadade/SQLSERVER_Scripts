select  sj.name,jh.run_status, jh.run_date, 
jh.run_time
,jh.run_duration 
from sysjobhistory jh
,sysjobs sj
where 
jh.job_id=sj.job_id
and run_date = 20130412
and run_time > 130000
order by 1

--run_status=0 -> falha, 1 -> sucesso


select sj.name, run_status,run_date,run_time,run_duration
from sysjobhistory jh,
sysjobs sj
where
sj.job_id= jh.job_id
and jh.job_id in
(select  job_id
from sysjobhistory
where 
run_date >= 20130416
and run_time > 000001
and run_time < 70000
and run_status = 0)