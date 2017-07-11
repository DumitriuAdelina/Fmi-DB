--lab 6
--2 

select *
from project -- avem toate proiectele
where project_id in ( select project_id
                      from works_on -- selectam toate proiectele la care au lucrat angajatii, unde angajatul e printre cei cu alte 2 posturi in firma
                      where employee_id in 
                                          (select employee_id
                                          from job_history
                                          group by employee_id
                                          having count(job_id)=2) -- angajatii care au detinut alte 2 posturi in firma
                      group by project_id
                      having count(*)= -- grupand putem numara cati angajati sunt pt acelasi proiect
                                          (select count(count(*))
                                          from job_history
                                          group by employee_id
                                          having count(job_id)=2)); --nr de angajati care au detinut alte 2 posturi in firma

--3
select count(employee_id)
from ( select employee_id,count(job_id) nr
       from job_history
       group by employee_id)
where nr>=2;

--4
select count(employee_id)
from employees join departments using (department_id)
               join locations using (location_id)
               right join countries using (country_id)
group by country_id;

--5
select w.employee_id,project_id
from works_on w right join employees e on w.employee_id = e.employee_id;

--6
select *
from employees 
where department_id in ( select distinct department_id --selectam departamentele in care exista cel putin un manager de proiect
                        from employees e join project p on e.employee_id=p.project_manager ); 

--7
select *
from employees 
where department_id not in ( select distinct department_id --selectam departamentele in care exista cel putin un manager de proiect
                        from employees e join project p on e.employee_id=p.project_manager ); 

--9
select employee_id
from works_on w
where (select count(project_id)
       from works_on
       where employee_id=w.employee_id)=(select count(project_id)
                                         from works_on join project using (project_id)
                                         where project_manager=102
                                         and employee_id=w.employee_id);

--11
200 a1 a2 a3  ( doar a1 e ok !)

p2  x  x  -

p3  x  -  x
;

select employee_id, last_name, first_name
from employees join works_on using (employee_id)
where project_id in ( 
                      select project_id -- selectam proiectele la care a lucrat ang 200
                      from works_on
                      where employee_id=200
                    )
group by employee_id, last_name, first_name
having count(project_id)=(
                            select count(project_id)
                            from works_on
                            where employee_id=200 ); --trebuie ca fiecare ang sa lucreze la toate proiectele la care a lucrat ang 200

--10 a
--cel putin = inseamna ca a lucrat la aceleasi proiecte pe care a lucrat 200,dar poate sa aiba si alte proiecte in afara de proiectele lui 200 !!!!
--se poate rezolva fix ca ex 11 (nu ne intereseaza daca are alte proiecte in plus fata de cele ale lui 200

--10 b
--cel mult = inseamna ca a lucrat la oricare din proiectele lui 200 sau MAXIM la toate, dar NU SI LA ALTELE!!!

1(nu lucreaza 200)      2(lucreaza 200)       3(lucreaza 200)
  136,125,140           101 125 145 148       101,140,145,148
                        200                   150,162,176,200

select employee_id, last_name, first_name
from employees join works_on using (employee_id)
where project_id in ( 
                      select project_id -- selectam proiectele la care a lucrat ang 200
                      from works_on
                      where employee_id=200
                    )
group by employee_id, last_name, first_name
having count(project_id)<=(
                            select count(project_id)
                            from works_on
                            where employee_id=200 ) --cel mult ( ori la pr2 ori la p3 ori la ambele )
MINUS -- minus proiectele la care nu lucreaza 200                           
select employee_id, last_name, first_name
from employees join works_on using (employee_id)
where project_id in (
                      select distinct project_id
                      from works_on -- din toate proiectele  
                      
                      MINUS --scadem proiectele la care lucreaza 200
                      
                      select distinct project_id
                      from works_on
                      where employee_id = 200 
                    ) --obtinem proiectele la care nu lucreaza 200
group by employee_id, last_name, first_name;

--8
select department_id,round(avg(salary))
from employees
group by department_id
having avg(salary)>&p;

----------------
undefine x;
undefine y;
define x=&&y;

select &&x from dual;

--15 ? 
ACCEPT p_cod PROMPT "cod= ";
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = &p_cod;










