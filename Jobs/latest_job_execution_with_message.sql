select  
jb.name,jb.enabled,jbh.step_id,jbh.message,
max(msdb.dbo.agent_datetime(run_date, run_time)) as 'RunDateTime'
from sysjobs jb inner join sysjobhistory jbh on jbh.job_id=jb.job_id
group by jb.name,jb.enabled,jbh.step_id,jbh.message;
