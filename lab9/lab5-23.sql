--23
select job_id ,
CASE WHEN lower(job_id) like 's%' THEN
          (select sum(salary) from employees where job_id = j.job_id)
          
     WHEN job_id=(select job_id from employees where salary=( select max(salary) from employees)) THEN
          (select avg(salary)from employees)
    
     ELSE (select min(salary) from employees where job_id=j.job_id)
END Joburi
from jobs j;