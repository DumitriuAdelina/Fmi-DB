select employee_id, department_name
from employees e, departments d
where e.department_id = d.department_id; --106(+)
-----------------------------
select * from employees; --107
-----------------------------
select * from departments; --27

select employee_id, last_name
from employees
where department_id is null;


--17
select e.job_id, job_title
from jobs j, employees e
where j.job_id=e.job_id and department_id=30;


--18
select last_name, department_name, location_id
from employees e, departments d
where e.department_id = d.department_id(+)
and commission_pct is not null;


--19
select city
from locations;

select last_name, job_title, department_name, d.department_id -- department_id ambiguu definita
from employees e, departments d, jobs j, locations l
where e.department_id=d.department_id and
      e.job_id=j.job_id and
      l.location_id=d.location_id and initcap(city) = 'Oxford';
    
          
--20
SELECT ang.employee_id Ang#, ang.last_name NumeAng, sef.employee_id Mgr#,sef.last_name Manager
FROM employees ang, employees sef
WHERE ang.manager_id = sef.employee_id;

select employee_id, manager_id
from employees;


--21
SELECT ang.employee_id Ang#, ang.last_name NumeAng, sef.employee_id Mgr#,sef.last_name Manager
FROM employees ang, employees sef
WHERE ang.manager_id = sef.employee_id(+);


--22
select e.last_name, e.department_id, coleg.last_name"Nume Coleg"
from employees e, employees coleg
where e.DEPARTMENT_ID = coleg.DEPARTMENT_ID
and e.EMPLOYEE_ID!=coleg.EMPLOYEE_ID;


--23
select e.last_name, j.job_id, j.job_title, d.department_name, e.salary
from employees e, departments d, jobs j
where e.DEPARTMENT_ID=d.DEPARTMENT_ID(+) and
      e.JOB_ID=j.JOB_ID;


--24
select e1.last_name, e1.hire_date
from employees e1, employees e2
where e1.hire_date>e2.hire_date and initcap(e2.last_name)='Gates';


--25
select e.last_name Angajat, e.hire_date "Data ang", sef.last_name Manager, sef.hire_date "Data Sef"
from employees e, employees sef
where e.manager_id=sef.employee_id
and e.hire_date<sef.hire_date;





