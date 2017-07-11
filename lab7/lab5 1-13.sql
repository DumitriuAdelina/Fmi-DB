--lab4 - rollup - ex
SELECT department_id, TO_CHAR(hire_date, 'yyyy'), SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP(department_id, TO_CHAR(hire_date, 'yyyy')); 

--sau--------------------------------------
select department_id,to_char(hire_date,'yyyy'),sum(salary)
from employees
where department_id<50
group by department_id,to_char(hire_date,'yyyy')

union all

select department_id,null,sum(salary)
from employees
where department_id<50
group by department_id

union all
select null,null,sum(salary)
from employees;


--lab4 - cube ex
SELECT department_id, TO_CHAR(hire_date, 'yyyy'), SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY CUBE(department_id, TO_CHAR(hire_date, 'yyyy')); 


--lab5
--1 a
select department_name,job_title,avg(salary)
from departments join employees using (department_id)
                 join jobs using (job_id)
group by rollup (department_name, job_title);

--1 b
select department_name,job_title,avg(salary),grouping (department_name), grouping(job_title)
from departments join employees using (department_id)
                 join jobs using (job_id)
group by rollup (department_name, job_title);

--2
select department_name,job_title,avg(salary),grouping (department_name), grouping(job_title)
from departments join employees using (department_id)
                 join jobs using (job_id)
group by cube (department_name, job_title);

--3
select department_name,job_title,e.manager_id,max(salary),sum(salary)
from departments join employees e using (department_id)
                 join jobs using (job_id)
group by grouping sets((department_name,job_title),(job_title,e.manager_id),());-- paranteze goale = intreg tabelul

--5
select last_name,salary
from employees
where salary > all
              (select avg(salary)
              from employees
              group by department_id);

--sau-------------------------------
select last_name,salary
from employees
where salary >
              (select max(avg(salary))
              from employees
              group by department_id);

--6
--Soluþia 1 (cu sincronizare): 
SELECT last_name, salary, department_id
FROM employees e
WHERE salary = (SELECT MIN(salary)
                FROM employees
                WHERE department_id = e.department_id); 

--Soluþia 2 (fãrã sincronizare):

FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MIN(salary)
                                  FROM employees
                                  GROUP BY department_id);

--Soluþia 3: Subcerere în clauza FROM
select last_name, salary
from employees e join (select min(salary)min_sal,department_id dep
                       from employees
                       group by department_id)
on (e.department_id = dep )
where salary = min_sal;

--7
SELECT last_name, salary
FROM employees e
WHERE EXISTS (SELECT 1
              FROM employees
              WHERE e.department_id = department_id
              AND salary = (SELECT MAX(salary)
                            FROM employees
                            WHERE department_id =30)); 

--select 'x' from employees where salary = 11000;

--8
select last_name,salary,rownum
from employees e
where 3>(select count(salary)     -- 3 repr numarul de linii
         from employees
         where e.salary<salary)
and rownum<4;

select employee_id,last_name,salary,rownum
from employees;
--update employees set salary = 17000 where employee_id=103;

--sau------------------------------
select employee_id,last_name,salary,rownum
from employees
where rownum<4
order by salary desc;
--nu e oke. rownum 1 3 2

select employee_id,last_name,salary,rownum
from (select employee_id,last_name,salary from employees order by salary desc)
where rownum<4;

--9
select employee_id,last_name
from employees sef
where 1 < (select count(employee_id)
           from employees
           where sef.employee_id = manager_id);
       
--10
select location_id
from locations loc
where exists (select department_id
              from departments
              where location_id = loc.location_id);
--sau--------------------------------
select location_id
from locations loc
where location_id in (select location_id      -- in loc de 'in' -> location... =any (.....); 
                      from departments
                      where location_id = loc.location_id);

--11
select department_id
from departments
MINUS
select department_id
from employees;
--sau--------------------------------
SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS (SELECT 'x' 
                  FROM employees
                  WHERE department_id = d.department_id); 
--sau--------------------------------
SELECT department_id, department_name
FROM departments d
where department_id not in (select department_id
                            from employees
                            where department_id is not null);
                            
--12
SELECT employee_id, last_name, hire_date, salary, manager_id
FROM employees
START WITH manager_id = ( SELECT employee_id
                          FROM employees
                          WHERE LOWER(last_name)='de haan')
CONNECT BY manager_id = PRIOR employee_id; 

--13
select employee_id
from employees
start with employee_id=114
connect by manager_id = prior employee_id;

--------------------------------------------------------------------------------
select &&x
from dual;

undefine x;

select country_name,&x
from countries;

undefine x;
undefine y;
select &&x + level -1 
              --level e un fel de contor
from dual
connect by &&x+level<=&&y;

--x=1 y=21 => nr din 7 in 7 
undefine x;
undefine y;
select &&x + level -1 
from dual
where mod(level,7)=0
connect by &&x+level<=&&y;