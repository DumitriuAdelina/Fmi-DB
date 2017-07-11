--lab 6

--Met1: Division identifica valori ale unor atribute ale unei relatii care sunt legate de vaolri dintr-o alta relatie
/*
exemplu1 : vrem sa afisam o lista cu toate magazinele care vand piese care au o anumita culoare
magazin -> vinde ->piesa
piesa -> are -> culoare
*/

--exemplu2 : vrem sa afisam angajatii care lucreaza la TOATE proiectele care au acelasi manager
-- angajat -> lucreaza -> proiect
-- proiect -> are -> manager
select *
from employees e
where not exists ( select *
                   from works_on w --aici sunt toti angajatii care lucreaza pe proiecte
                                   --cu managerii de mai jos
                   where not exists ( select *
                                      from project p
                                      where e.manager_id = p.project_manager ) 
                 );
                
--Met2(simularea diviziunii cu ajutorul funcşiei COUNT): 
SELECT employee_id
FROM works_on
WHERE project_id IN ( SELECT project_id
                      FROM project
                      WHERE budget=10000)
GROUP BY employee_id
HAVING COUNT(project_id)=(SELECT COUNT(*)
                          FROM project
                          WHERE budget=10000);
                          
--Met3(operatorul MINUS): 
SELECT employee_id
FROM works_on --toti angajatii care lucreaza la proiecte

MINUS

SELECT employee_id from
                         ( SELECT employee_id, project_id
                           FROM (SELECT DISTINCT employee_id FROM works_on) t1,
                          (SELECT project_id FROM project WHERE budget=10000) t2
                           --angajatii care lucreaza la proiecte de 10k
                           MINUS --din toti ang care lucreaza la proiecte de 10k
                                 -- ii scoatem pe cei care lucreaza la proiecte in general
                           SELECT employee_id, project_id FROM works_on
                           ) t3; --angajatii care lucreaza la proiecte diferite de 10k
                           
--Met4(A include B => B\A = ?):  :
SELECT DISTINCT employee_id
FROM works_on a  --toti angajatii care lucreaza la proiecte - 10 angajati
WHERE NOT EXISTS (
                    (SELECT project_id
                     FROM project p
                     WHERE budget=10000) --toate proiectele de 10k (proiectul 2 si 3)
                     
                     MINUS
                     
                     (SELECT p.project_id
                      FROM project p, works_on b
                      WHERE p.project_id=b.project_id
                      AND b.employee_id=a.employee_id) -- afis toate proiectele la care lucreaza angajatul curent
                                                       -- raman proiecte de 10k la care nu lucreaza
                  );

--1
select employee_id
from works_on
where project_id in ( select project_id
                      from project
                      where start_date >= to_date('01-JAN-06') and start_date <= to_date('30-JUN-06')) -- 8 angajati
                      --project_id = 1,2( 2 proiecte demarat in primele 6 luni )
group by employee_id
having count(project_id) = (select count(project_id)
                            from project
                            where start_date >= to_date('01-JAN-06') and start_date <= to_date('30-JUN-06'));
                      






