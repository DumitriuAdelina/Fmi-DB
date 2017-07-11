--lab 8 
--19
CREATE TABLE angajati_aduu
 ( cod_ang NUMBER(4),
   nume varchar2(20) constraint nume_adu not null,
   prenume varchar2(20),
   email char(15),
   data_ang date default sysdate,
   job varchar2(10),
   cod_sef NUMBER(4),
   salariu number(8, 2) constraint salariu_adu not null,
   cod_dep number(2),
   comision NUMBER(2,2),
   CONSTRAINT nume_prenume_unique_aduu UNIQUE(nume,prenume),
   CONSTRAINT verifica_sal_aduu CHECK(salariu > 100*comision),
   constraint pk_angajati_aduu primary key(cod_ang),
   UNIQUE(email),
   CONSTRAINT sef_aduu FOREIGN KEY(cod_sef) REFERENCES angajati_aduu(cod_ang),
   constraint fk_dep_aduu foreign key(cod_dep) references dep_adu (cod_dep),
   CHECK(cod_dep > 0)
 );
 
 --20
 INSERT INTO angajati_aduu
 VALUES(100, 'nume1', 'prenume1', 'email1', sysdate, 'Director ',null, 20000,10, 0.1);

INSERT INTO angajati_aduu
 VALUES(101,'nume2','prenume2','email2',to_date('02-02-2004','dd-mm-yyyy'),'Inginer',
100, 10000 ,10, 0.2);

INSERT INTO angajati_aduu
 VALUES (102,'nume3' , 'prenume3', 'email3',to_date('05-06-2000','dd-mm-yyyy'),'Analist',
101, 5000 ,20, 0.1);

INSERT INTO angajati_aduu
 VALUES (103,'nume4','prenume4', 'email4', sysdate, 'Inginer ',100,9000,20, 0.1);

INSERT INTO angajati_aduu
 VALUES (104,'nume5', 'prenume5', 'email5', sysdate, 'Analist', 101, 3000 ,30, 0.1);

select * from angajati_aduu;


--22 a
SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE lower(table_name) IN ('angajati_aduu', 'dep_adu');

--22 b
SELECT table_name, constraint_name, column_name
FROM user_cons_columns
WHERE LOWER(table_name) IN ('angajati_aduu', 'dep_aduu');

--23
ALTER TABLE angajati_aduu
MODIFY(email NOT NULL);

DESC angajati_aduu;

SELECT * FROM angajati_aduu;

UPDATE angajati_aduu
SET email=nume
WHERE email IS NULL;

--24
SELECT * FROM dep_adu;

--25
INSERT INTO dep_adu
VALUES (60,'Analiza',null);
SELECT * FROM dep_adu;
COMMIT;

--28
ALTER TABLE angajati_aduu
DROP CONSTRAINT fk_dep_aduu;

ALTER TABLE angajati_aduu
ADD CONSTRAINT fk_dep_aduu FOREIGN KEY(cod_dep)
REFERENCES dep_adu (cod_dep) ON DELETE CASCADE;

--29
SELECT * FROM angajati_aduu;
DELETE FROM dep_aduu
WHERE cod_dep = 20;
ROLLBACK;

--30
ALTER TABLE dep_adu
ADD CONSTRAINT cod_director_fk_adu FOREIGN KEY(cod_director)
REFERENCES angajati_aduu (cod_ang) ON DELETE SET NULL;

--31
ALTER TABLE dep_adu
ADD CONSTRAINT cod_director_fk_aduu FOREIGN KEY(cod_director)
REFERENCES angajati_aduu (cod_ang) ON DELETE SET NULL;

UPDATE dep_adu
SET cod_director = 102
WHERE cod_dep = 30;

SELECT * FROM dep_adu;
SELECT * FROM angajati_aduu;

DELETE from angajati_aduu where cod_ang = 102;

--32 in lab
--33 in lab



