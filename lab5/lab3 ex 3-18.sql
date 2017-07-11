--lab 3 - V
--3
select e.last_name, e.salary, job_title, city, country_name
from employees e join employees k on (e.manager_id = k.employee_id)
                 join jobs j on (e.job_id = j.job_id)
                 left join departments d on (e.department_id = d.department_id)
                 left join locations l on (d.location_id = l.location_id)
                 left join countries c on (l.country_id = c.country_id)
where lower(k.last_name) like 'king';

--4
select d.department_id, department_name, last_name, job_id, to_char(salary,'$99,999.00')
from employees e join departments d on (e.department_id=d.department_id)
where lower(department_name) like '%ti%'
order by department_name, last_name;

--5
--afisati toate departamentele chiar daca nu au angajati
select department_name,last_name
from employees e right join departments d on (e.department_id=d.department_id);

--toti angajatii chiar daca nu au departamente
select department_name,last_name
from employees e left join departments d on (e.department_id=d.department_id);

--prima varianta
select department_name,last_name
from employees e right join departments d on (e.department_id=d.department_id)
UNION
select department_name,last_name
from employees e left join departments d on (e.department_id=d.department_id);

--a2a varianta
select distinct department_name,last_name
from employees e full outer join departments d on (e.department_id=d.department_id);

--VI
--6 & 7
select department_id
from departments
where lower(department_name) like '%re%'

UNION --UNION ALL afis si duplicatele

select department_id
from employees
where upper(job_id)='SA_REP';

--8
select d.department_id
from employees e right join departments d on (e.department_id = d.department_id)
where email is null
order by 1;

select department_name, e.department_id,salary,email,last_name
from employees e right join departments d on (e.department_id=d.department_id)
where department_name='NOC';

--sau 
select department_id
from departments
MINUS
select department_id
from employees;

--sau
SELECT department_id
FROM departments
WHERE department_id NOT IN (SELECT DISTINCT NVL(department_id,0)
 FROM employees); 
 
-- VII
--10
SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
                   FROM employees
                   WHERE INITCAP(last_name)='Gates');

--11
select last_name,salary
from employees
where department_id = (select department_id
                       from employees
                       where lower(last_name)='gates')
and lower(last_name)!='gates';


select last_name,salary
from employees
where department_id IN (select department_id
                       from employees
                       where lower(last_name)='king')
and lower(last_name)!='king';

select last_name,salary
from employees
where department_id =ANY (select department_id
                       from employees
                       where lower(last_name)='king')
and lower(last_name)!='king';

--12
select last_name, salary
from employees
where manager_id=(select employee_id
                  from employees
                  where manager_id is null);

--13 
select last_name, department_id, salary
from employees
where (department_id,salary) in (select department_id,salary
                              from employees
                              where commission_pct is not null);
                              
--14
select employee_id,last_name,salary
from employees
where salary> (select avg(salary)
               from employees);
               
--15
select *
from employees
where salary*(nvl(commission_pct,0)+1)>all
             (select salary*(nvl(commission_pct,0)+1)
              from employees
              where lower(job_id) like '%clerk%')
order by salary desc;
--all - toti ; any-macar unul

--16
select last_name,department_name,salary
from employees e join departments d using(department_id)
where commission_pct is null and
e.manager_id in (select manager_id  --in sau =ANY
                 from employees
                 where commission_pct is not null);
                 
--17
select last_name,department_id,salary,job_id,employee_id
from employees
where (nvl(commission_pct,-1),salary) IN (select nvl(commission_pct,-1),salary
                                          from employees e join departments d on(e.department_id = d.department_id)
                                          join locations l on (l.location_id = d.location_id)
where lower(l.city)='oxford');

--18
select last_name,department_id,job_id
from employees
where department_id = 
                      (select department_id
                      from departments d join locations l on (d.location_id=l.location_id)
                      where lower(city)='toronto');