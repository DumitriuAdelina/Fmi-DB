--1
select concat(first_name,' ')||last_name||' castiga '||salary||' lunar, dar doreste '||salary*3 "Salariu ideal"
from employees;

--2
select initcap(first_name) nume ,upper(last_name) prenume , length(first_name) lungime
from employees
where upper(last_name) like 'J%' or upper(last_name) like 'M%' or upper(last_name) like '__A%'
order by 3 desc; --a3a instructiune
--order by lungime desc;
--order by length(first_name) desc ;

select initcap(first_name) nume ,upper(last_name) prenume , length(first_name) lungime
from employees
where upper(last_name) like 'J%' or upper(last_name) like 'M%' or substr(upper(last_name),3,1)='A'
order by 3 desc;

--3
SELECT employee_id,last_name,department_id
FROM employees
WHERE LTRIM(RTRIM(UPPER(first_name)))='STEVEN';

SELECT employee_id,last_name,department_id
FROM employees
WHERE TRIM(BOTH FROM UPPER(first_name))='STEVEN';

--4
select employee_id Cod, last_name Nume, length(last_name) "Lungime Nume", instr(upper(last_name),'A',1,1) Litera
from employees
where substr(lower(last_name),-1)='e'; --ia ultima pozitie

--5
select first_name, last_name, to_char(hire_date, 'day')
from employees
where mod(round(sysdate-hire_date),7)=0;

--6
select employee_id, last_name, salary, round(salary*1.15,2) "Salariu Nou", round(salary*1.15/100,2) "Nr sute"
from employees
where mod(salary,1000)!=0;

--7
select last_name as "nume angajat",rpad(to_char(hire_date),20,'X')
from employees
where commission_pct is not null;

--8
SELECT  TO_CHAR(SYSDATE+30,'MONTH DD HH24:MM:SS') "Data"
FROM DUAL;

--9
select round(to_date('31-12-2017','dd-mm-yyyy')-sysdate)
from dual;

--10
SELECT TO_CHAR(SYSDATE+12/24, 'DD/MM HH24:MM:SS') "Data"
FROM DUAL;

select sysdate+1/2
from dual;

select sysdate+1/288
from dual;

--11
select concat(first_name||' ',last_name),hire_date,next_day(add_months(hire_date,6),'monday') "negociere"
from employees;

--12
select first_name,round(months_between(sysdate,hire_date)) "Luni lucrate"
from employees
order by 2;

--13
select last_name,nvl(to_char(commission_pct),'fara comision') Comision
from employees;

--14
SELECT 
last_name, salary, commission_pct
FROM employees 
WHERE salary+salary*nvl(commission_pct,0)>10000;

--15
select last_name,job_id,salary,
case job_id when 'IT_PROG' then salary*1.1
            when 'ST_CLERK' then salary*1.15
            when 'SA_REP' then salary*1.2
else salary
end "Salariu Renegociat"
from employees

--sau
select last_name,job_id,salary,
decode(job_id,'IT_PROG',salary*1.1,
              'ST_CLERK',salary*1.15,
              'SA_REP',salary*1.2,
              salary) "Salariu nou"
from employees;

