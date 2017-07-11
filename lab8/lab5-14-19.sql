--lab5
--14
select employee_id, manager_id, last_name,level
from employees
where level = 2
start with manager_id = (select employee_id
                         from employees
                         where lower(last_name)='de haan')
connect by manager_id = prior employee_id;

--15 --nu se cere asa ceva
SET LINESIZE 100
COLUMN name FORMAT a25; -- Afiseaza maxim 25 de caractere;
SELECT employee_id, manager_id, LEVEL, last_name, LPAD(last_name, length(last_name)+level*2-2, '_') name
FROM employees
CONNECT BY employee_id=prior manager_id; 

--sau----------------------------
SELECT employee_id, manager_id, LEVEL, last_name
FROM employees
CONNECT BY employee_id=prior manager_id
order by 4;

--18

--subordonatii directi ai lui steven king
with subord as (select employee_id,hire_date
                from employees
                where manager_id= ( select employee_id
                                    from employees
                                    where lower(last_name||first_name)='kingsteven')),
--subordonatii care au cea mai mare vechime
vechime as (select employee_id,hire_date
            from subord
            where hire_date = (select min(hire_date)
                               from subord))
--cerere principala
select employee_id,last_name || first_name,job_id, hire_date,manager_id
from employees
where to_char(hire_date, 'yy')!=70
start with employee_id in (select employee_id
                           from vechime)
connect by prior employee_id=manager_id;

--19
select employee_id,salary,rownum
from ( select employee_id,salary
       from employees
       order by salary desc )
where rownum<11;

/*
2.select
1.from
3.where
--start with
--connect by
4.group by
5.having
6.order by
*/






