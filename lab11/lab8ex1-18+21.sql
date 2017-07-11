--lab 8
--ex. 1)

--ANGAJATI_adu(cod_ang number(4), nume varchar2(20), prenume varchar2(20), email
--char(15), data_ang date, job varchar2(10), cod_sef number(4), salariu number(8, 2), cod_dep number(2))

create table angajati_adu
      (cod_ang number(4) constraint pkey_adu primary key,
       nume varchar2(20) constraint cnume_adu not null,
       prenume varchar2(20),
       email char(15) unique,
       data_ang date,
       job varchar2(10),
       cod_sef number(4),
       salariu number(8,2) constraint csalariu_adu not null,
       cod_dep number(2)
       )

desc angajati_adu;

--b)

drop table angajati_adu;

create table angajati_adu
      (cod_ang number(4),
       nume varchar2(20) constraint cnume_adu not null,
       prenume varchar2(20),
       email char(15) unique,
       data_ang date default sysdate,
       job varchar2(10),
       cod_sef number(4),
       salariu number(8,2) constraint csalariu_adu not null,
       cod_dep number(2),
       constraint pkey_adu primary key(cod_ang)
       )
       
select * from angajati_adu;


--ex 2)

insert into angajati_adu (cod_ang, nume, prenume, data_ang, job, salariu, cod_dep)
            values (100, 'nume1', 'prenume1',null , 'director', 20000, 10);
            
insert into angajati_adu
            values (101, 'nume2', 'prenume2', 'email2', to_date('02-02-2004','dd-mm-yyyy'), 'inginer', 100, 10000, 10);
insert into angajati_adu
            values (102, 'nume3', 'prenume3', 'email3', to_date('05-06-2000','dd-mm-yyyy'), 'analist', 101, 10000, 10);
            
insert into angajati_adu (cod_ang, nume, prenume, data_ang, job, cod_sef, salariu, cod_dep)
            values (103, 'nume4', 'prenume4', null,  'inginer', 100, 9000, 10);

insert into angajati_adu
            values (104, 'nume5', 'prenume5', 'email5', null, 'analist', 101, 3000, 30);
            
select * from angajati_adu

commit;

--3
CREATE TABLE angajati10_adu AS SELECT * FROM angajati_adu Where cod_dep=10;
select * from angajati10_adu;
--nu pastreaza cheile!
desc angajati10_adu;

--4
alter table angajati_adu add (comision number(4,2)); --4 inainte de virgula, 2 zecimale dupa virgula

--5
alter table angajati_adu
modify (salariu number(6,2)); -- coloana trebuie sa fie goala inainte de modificare

--6
alter table angajati_adu 
modify (salariu number(8,2) default 100); --la inserare daca nu vom adauga nimic, singur va introduce val 100

--7
desc angajati_adu;

alter table angajati_adu
modify (comision number(2,2), salariu number(10,2));

--8
update angajati_adu
set comision = 0.1
where upper(job) like 'A%';

select * from angajati_adu;

--9. Modificaþi tipul de date al coloanei email în VARCHAR2
--          o coloanã CHAR poate fi convertitã la tipul de date VARCHAR2 sau invers, numai dacã
--          valorile coloanei sunt null sau dacã nu se modificã dimensiunea coloanei.
alter table angajati_adu
modify (email varchar2(15));

desc angajati_adu;

--10
alter table angajati_adu
add (nr_telefon varchar2(10) default '0123456789');

--11
alter table angajati_adu
drop column nr_telefon;

rollback; -- nu are niciun efect, dropul/alter are commit automat

--12
rename angajati_adu to ang_adu;

--13
select * from tab;

--14
select * from angajati10_adu;
truncate table angajati10_adu;
rollback; --daca dam rollback nu o sa se intample nimic pentru ca truncate e o comanda fdd care isi da commit automat

--15
create table dep_adu
             (cod_dep number(2),
              nume varchar2(15) not null,
              cod_director number(4));

--16
insert into dep_adu values (10,'Administrativ',100);
insert into dep_adu values (20,'Proiectare',101);
insert into dep_adu values (30,'Programare',null);

select * from dep_adu;

--17
alter table dep_adu add constraint pkey_dept_adu primary key(cod_dep);

--18
--a)
alter table angajati_adu
add foreign key(cod_dep) references dep_adu(cod_dep);
--b)
drop table angajati_adu;

create table angajati_adu
      (cod_ang number(4) constraint pkey_adu primary key,
       nume varchar2(20) constraint cnume_adu not null,
       prenume varchar2(20),
       email char(15) unique,
       data_ang date,
       job varchar2(10),
       comision number(2,2),
       cod_sef number(4) constraint sef_adu references angajati_adu(cod_ang),
       salariu number(8,2) constraint csalariu_adu not null,
       cod_dep number(2) constraint fkdep_adu references dep_adu(cod_dep),
       check(cod_dep>0),
       constraint verifica_sal_adu check(salariu > 100*comision),
       constraint numeprenumeadu unique(nume,prenume));
desc angajati_adu;

--21
SELECT * FROM tab;
SELECT table_name FROM user_tables;




