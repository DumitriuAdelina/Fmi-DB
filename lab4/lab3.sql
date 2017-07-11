SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees, job_grades
WHERE salary BETWEEN lowest_sal AND highest_sal;

select lowest_sal, highest_sal
from job_grades;

-- V [exercitii join]
--1
select e.last_name, to_char(e.hire_date,'month-yyyy'),gates.employee_id
from employees e join employees gates
on (e.department_id=gates.department_id)
where lower(e.last_name) like '%a%' and
lower(e.last_name)!='gates' and
lower(gates.last_name)='gates';

--2
select e.employee_id Cod, e.last_name Nume, d.department_id Cod_dep, d.department_name Nume_Dep

from employees e join employees t on e.department_id = t.department_id
                join departments d on e.department_id = d.department_id
where lower(t.last_name) like '%t%'
order by 2;