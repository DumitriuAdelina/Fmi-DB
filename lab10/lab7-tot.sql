--lab7
-- I
--1
CREATE TABLE emp_adu AS SELECT * FROM employees;
CREATE TABLE dept_adu AS SELECT * FROM departments;

--2
desc employees;
desc emp_adu;

--3
select * from emp_adu;

--4
ALTER TABLE emp_adu
ADD CONSTRAINT pk_emp_pnu PRIMARY KEY(employee_id);

ALTER TABLE dept_adu
ADD CONSTRAINT pk_dept_pnu PRIMARY KEY(department_id);

ALTER TABLE emp_adu
ADD CONSTRAINT fk_emp_dept_pnuu
 FOREIGN KEY(department_id) REFERENCES dept_adu(department_id);

-------(ce nu e rez in lab)
ALTER TABLE dept_adu
ADD CONSTRAINT fk_dept_seff
 FOREIGN KEY(manager_id) REFERENCES emp_adu(employee_id);

alter table emp_adu add constraint fk_emp_seff
foreign key(manager_id) references emp_adu(employee_id);

--5
--a)
INSERT INTO dept_adu --nu are valorile scrise de langa tabel
VALUES (300, 'Programare');
--b)
INSERT INTO dept_adu (department_id, department_name)
VALUES (300, 'Programare'); -- varianta corecta
--c)
INSERT INTO dept_adu (department_name, department_id)
VALUES (300, 'Programare'); -- ordinea in care sunt coloanele, nu corespund ca tip
--d)
INSERT INTO dept_adu (department_id, department_name, location_id)
VALUES (300, 'Programare', null); --nu avem voie sa adaugam 2 randuri unde cheia primara sa aiba aceeasi val
INSERT INTO dept_adu (department_id, department_name, location_id)
VALUES (301, 'Programare', null) --acum e corect

INSERT INTO dept_adu (department_id, department_name, location_id)
VALUES (302, 'Programare', null) --acum e corect
--e)
INSERT INTO dept_adu (department_name, location_id)
VALUES ('Programare', null);

select * from emp_adu;
select * from dept_adu;
rollback;

commit; --am dat commit dupa 300 si 301 apoi am adaugat 302 si am apelat rollback;

--6
desc emp_adu;

insert into emp_adu 
values (1000,null,'numefam','numefam@yahoo.com',null,sysdate,'it_prog',null,null,null,301);

commit;--am inserat randul permanent
rollback;--acum nu mai are niciun efect dupa ce am dat commit

--7
INSERT INTO emp_adu (hire_date, job_id, employee_id, last_name, email, department_id)
VALUES (sysdate, 'sa_man', 278, 'nume_278', 'email_278', 301);
COMMIT ;

--8
INSERT INTO emp_adu (employee_id, last_name, email, hire_date, job_id, salary,
 commission_pct)
VALUES (252, 'Nume252', 'nume252@emp.com',SYSDATE, 'SA_REP', 5000, NULL);

SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct
FROM emp_adu
WHERE employee_id=252;

ROLLBACK;

INSERT INTO
       (SELECT employee_id, last_name, email, hire_date, job_id, salary,
       commission_pct
       FROM emp_adu)
VALUES (252, 'Nume252', 'nume252@emp.com',SYSDATE, 'SA_REP', 5000, NULL);

SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct
FROM emp_adu
WHERE employee_id=252;

ROLLBACK;

insert into (select employee_id,last_name,hire_date,job_id,email
             from emp_adu)
values((select max(employee_id)+1 from emp_adu),'numenou',sysdate,'sa_man','numenou@yahoo.com');

--9
create table emp1_adu as select * from employees;

select * from emp1_adu;

delete from emp1_adu; --nu are commit automat

insert into emp1_adu ----nu are commit automat
         select *
         from employees
         where commission_pct > 0.25;

rollback; --se intoarce la create

--10
INSERT INTO emp_adu
         SELECT 0,USER,USER, 'TOTAL', 'TOTAL',SYSDATE,
         'TOTAL', SUM(salary), ROUND(AVG(commission_pct)), null, null
         FROM employees;
SELECT * FROM emp_adu;
ROLLBACK;

--11
INSERT INTO emp_adu (employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES(&cod,'&&prenume','&&nume',
       substr('&prenume',1,1)||substr('&nume',1,7),sysdate,'it_prog',&sal); --&& ne cere o sg data pren si numele apoi sa aplice fct substr pe cele introduse
                                                                            -- & trebuia sa scriem numele si pren si pentru inserare si pentru functie
UNDEFINE prenume;
UNDEFINE nume;

--12

--emp1 este deja creat la alt ex
delete from emp1_adu;
select * from emp1_adu;

create table emp2_adu as select * from employees;
delete from emp2_adu;
select * from emp2_adu;

create table emp3_adu as select * from employees;
delete from emp3_adu;
select * from emp3_adu;

insert all
    when salary<5000 then 
        into emp1_adu
    when salary>=5000 and salary<=10000 then
        into emp2_adu
    else
        into emp3_adu
select * from employees;

--apoi dam delete la fiecare tabel pentru ex urm
--13
CREATE TABLE emp0_adu AS SELECT * FROM employees;
DELETE FROM emp0_adu;
INSERT FIRST
  WHEN department_id = 80 THEN
      INTO emp0_adu
  WHEN salary < 5000 THEN
      INTO emp1_adu
  WHEN salary > = 5000 AND salary <= 10000 THEN
      INTO emp2_adu
  ELSE
    INTO emp3_adu
SELECT * FROM employees;

SELECT * FROM emp0_adu;
SELECT * FROM emp1_adu;
SELECT * FROM emp2_adu;
SELECT * FROM emp3_adu;

-- II
--14
UPDATE emp_adu
SET salary = salary * 1.05;

SELECT * FROM emp_adu;
ROLLBACK;

--15
update emp_adu
set job_id='SA_REP'
where department_id=80 and commission_pct is not null;

SELECT * FROM emp_adu;
ROLLBACK;

--16
update dept_adu
set manager_id=( select employee_id
                 from emp_adu
                 where lower(last_name || first_name)='grantdouglas') --199
where department_id=20;

update emp_adu
set salary=salary + 1000
where lower(last_name || first_name)='grantdouglas';

select *
from emp_adu
where employee_id=199;

rollback;

--17
select min(salary) from emp_adu; 

UPDATE emp_adu e
SET (salary,commission_pct) = ( SELECT salary,commission_pct
                                FROM emp_adu
                                WHERE employee_id = e.manager_id)
WHERE salary = (SELECT min(salary)
                FROM emp_adu);

select salary
from emp_adu
where employee_id=310;

rollback;

--18
update emp_adu d
set email = substr(last_name,1,1)||nvl(first_name,'.')
where salary=(select max(salary)
              from emp_adu
              where department_id=d.department_id);
select * from emp_adu;

--19
UPDATE emp_adu d
SET salary = (SELECT avg(salary)
              FROM emp_adu)
WHERE hire_date = (SELECT min(hire_date)
                   FROM emp_adu
                   WHERE department_id = d.department_id);
                   
ROLLBACK;

--20
update emp_adu
set (job_id,department_id)=(select job_id,department_id
                            from emp_adu
                            where employee_id=205)
where employee_id=114;

rollback;

select * from emp_adu
where employee_id=114;

-- III
--21
delete from dept_adu; -- nu putem sa stergem pentru ca dept_id e pk si fk
--trebuie sa stergem in 'cascada'
-- 1 stergem fk din emp
-- apoi stergem tot din dept

delete from dept_adu
where department_id not in (select nvl(department_id,-100)
                            from emp_adu);
--am sters doar cele care nu sunt in emp_adu
rollback;

--22
--suprimati=stergeti
delete from dept_adu
where department_id in( select department_id
                    from dept_adu
                    MINUS --raman departamentele care nu au angajati
                    select department_id
                    from emp_adu);

select*from dept_adu
rollback;

--[LMD, LCD]
--23.S? se mai introduc? o linie in tabelul DEPT_PNU
insert into dept_adu
values (320,'dept_nou',null,null);

select * from dept_adu;

--24. S? se marcheze un punct intermediar in procesarea tranzac?iei.
savepoint p;

--25.S? se ?tearg? din tabelul DEPT_PNU departamentele care au codul de departament cuprins intre 160 si 200 . Lista?i con?inutul tabelului.
delete from dept_adu
where department_id between 160 and 200;

--26. S? se renun?e la cea mai recent? opera?ie de ?tergere, f?r? a renun?a la opera?ia precedent? de introducere.
ROLLBACK TO p

--27. Lista?i con?inutul tabelului. Determina?i ca modific?rile s? devin? permanente.
commit;

-- IV
--28.S? se introduc? sau s? se actualizeze datele din tabelul EMP_PNU pe baza tabelului employees.

MERGE INTO emp_adu x
     USING employees e
     ON (x.employee_id = e.employee_id)
     WHEN MATCHED THEN
UPDATE SET
     x.first_name=e. first_name,
     x.last_name=e.last_name,
     x.email=e.email,
     x.phone_number=e.phone_number,
     x.hire_date= e.hire_date,
     x.job_id= e.job_id,
     x.salary = e.salary,
     x.commission_pct= e.commission_pct,
     x.manager_id= e.manager_id,
     x.department_id= e.department_id
WHEN NOT MATCHED THEN
 INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email,
     e.phone_number, e.hire_date, e.job_id, e.salary, e.commission_pct, e.manager_id,
     e.department_id);



















