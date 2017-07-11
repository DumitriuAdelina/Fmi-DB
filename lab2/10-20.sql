--10
SELECT first_name,last_name,job_id,hire_date
FROM employees
WHERE hire_date BETWEEN ‘20-feb-1987’ and ‘1-may-1989’
ORDER BY hire_date;

--11
select first_name,last_name,department_id
from employees
where department_id in(10,30)
order by first_name;

--12
select first_name||' '||last_name "angajat",salary "salariu lunar"
from employees
where salary>1500 and department_id in(10,30);

--13
SELECT SYSDATE
FROM dual;

--select 3+5 from dual;
-- altcv
select to_char(sysdate,'DAY')
from dual;

select to_char(sysdate,'mi ss')
from dual;

--14
select first_name,last_name,hire_date
from employees
where to_char(hire_date,'yyyy')=1987;

select first_name,last_name,hire_date
from employees
where hire_date like ('%87%');

--15
select * from employees --ne uitam sa nu aiba manager
select first_name, last_name, job_id
from employees
where manager_id is null;

--16 & 17
select first_name,last_name,salary,commission_pct
from employees
--where commission_pct is not null
order by salary desc,commission_pct desc;

--18
select distinct last_name
from employees
where upper(last_name) like '__A%'; --utilizam upper/lower cand comparam stringuri

--19
select first_name
from employees
where (upper(first_name) like '%L%L%') and
      (department_id=30 or manager_id=102);

--20
select first_name, last_name, job_id, salary
from employees
where (upper(job_id) like '%CLERK%' or upper(job_id) like '%REP%' ) and (salary not in (1000,2000,3000));