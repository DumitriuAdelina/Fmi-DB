--lab 4 V
--1. in where se pune conditia pt o sg linie, in having pt mai multe linii ( pt grupari )
--2.
SELECT MAX(salary) Maxim, min(salary) Minim, sum(salary) Suma, round(avg(salary)) Media
FROM employees;

--3
SELECT job_id,MAX(salary) Maxim, min(salary) Minim, sum(salary) Suma, round(avg(salary)) Media
FROM employees
group by job_id;

--4
SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;

--5
select count(distinct manager_id) "Nr Manageri"
from employees;

--6
select max(salary)-min(salary) Diferenta
from employees;

--7
select department_name, location_id, count(employee_id),round(avg(salary))
from employees e left join departments d on (e.department_id=d.department_id)
group by department_name,location_id;

--9
select manager_id,min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary)>=1000
order by 2 desc;

--10
select department_id,department_name,max(salary)
from departments join employees using (department_id)
group by department_id,department_name
having max(salary)>=3000;

--11
SELECT MIN(AVG(salary))
FROM employees
GROUP BY job_id; 

--12
select max(avg(salary))
from employees
group by department_id;

--13
select job_id,job_title,avg(salary)
from employees join jobs using(job_id)
group by job_id,job_title
having avg(salary)=(select min(avg(salary))
                    from employees
                    group by job_id);

--14
select avg(salary)
from employees
having avg(salary)>2500;

--15
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id; 

--16 a
select department_id, department_name, count(employee_id)
from departments left join employees using(department_id)
group by department_id, department_name
having count(employee_id)<4;

--16 b
select department_id, department_name, count(employee_id)
from departments left join employees using(department_id)
group by department_id, department_name
having count(employee_id)=(select max(count(employee_id))
                           from  employees
                           group by department_id);
                          
--18
select count(count(department_id))
from employees
group by department_id
having count(employee_id)>15;
                          
--19
select department_id,sum(salary)
from employees
where department_id!=30
group by department_id
having count(employee_id)>10
order by 2;

--20
select employee_id
from job_history
group by employee_id
having count (employee_id)>=2;

--21
SELECT AVG(commission_pct)
FROM employees; 

SELECT AVG(NVL(commission_pct, 0))
FROM employees;

SELECT SUM(commission_pct)/COUNT(*)
FROM employees; 

select count(*)
from employees;

-----------------------------------------

create table testAde( nr number);
insert into testAde values (null);

select count(*)
from testAde;

drop table testAde;

-----------------------------------------

--decode(value,if1,then1,if2,then2,...,ifN, thenN,else)

--23. 
--Scrieþi o cerere pentru a afiºa job-ul, salariul total pentru job-ul respectiv pe
--departamente si salariul total pentru job-ul respectiv pe departamentele 30, 50, 80.
--Se vor eticheta coloanele corespunzãtor. Rezultatul va apãrea sub forma de mai jos: 

SELECT job_id, SUM(DECODE(department_id, 30, salary)) Dep30,
               SUM(DECODE(department_id, 50, salary)) Dep50,
               SUM(DECODE(department_id, 80, salary)) Dep80,
               SUM(salary) Total
FROM employees
GROUP BY job_id; 

--sau

SELECT job_id, (SELECT SUM(salary)
                FROM employees
                WHERE department_id = 30
                AND job_id = e.job_id) Dep30,
                
                (SELECT SUM(salary)
                 FROM employees
                 WHERE department_id = 50
                 AND job_id = e.job_id) Dep50,
                 
                (SELECT SUM(salary)
                 FROM employees
                 WHERE department_id = 80
                 AND job_id = e.job_id) Dep80,
                 
                 SUM(salary) Total
FROM employees e
GROUP BY job_id;

--24
select (select count(*) from employees) Total, 
       (select count(*) from employees
                        where to_char(hire_date,'yyyy')=1997) An1997,
       (select count(*) from employees
                        where to_char(hire_date,'yyyy')=1998) An1998,
       (select count(*) from employees
                        where to_char(hire_date,'yyyy')=1999) An1999,
       (select count(*) from employees
                        where to_char(hire_date,'yyyy')=2000) An2000
from dual;

--25
SELECT d.department_id, department_name,a.suma
FROM departments d, (SELECT department_id ,SUM(salary) suma
                     FROM employees
                     GROUP BY department_id) a
WHERE d.department_id =a.department_id;

/*SELECT d.department_id, department_name,sum(salary)
from departments d join employees e on (department_id)
group by d.department_id, department_name;*/

--26
select last_name,salary,department_id, SalMediu
from employees join (select avg(salary) SalMediu,department_id
                     from employees
                     group by department_id)
using (department_id);                     


--17
--nr maxim de angajati dintr-o zi a lunii
--selectam ziua lunii pt care nr de ang este egal cu nr max

select last_name,hire_date
from employees
where to_char(hire_date,'dd')=
      (select to_char(hire_date,'dd')
      from employees
      group by to_char(hire_date,'dd')
      having count(employee_id)=
             ( select max(count(employee_id))
              from employees
              group by to_char(hire_date,'dd')));




