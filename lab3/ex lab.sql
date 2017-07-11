select to_date('21-MAR-2017','DD-MON-YYYY')
from dual;

select to_number('-25.789','99.999')
from dual;

select '100'
from dual; -- conversie de la varchar2 la number

select ltrim('acacbbac info','ac')
from dual;

select ltrim('    info')
from dual;

select trim (LEADING 'X' FROM 'XXXInfoXXX')
from dual;

select add_months('06-mar-2017',3)
from dual;

select last_day('02-feb-2016')
from dual;

select last_day('02-feb-2017')
from dual;

select round(MONTHS_BETWEEN(sysdate,'21-SEP-1996'))
from dual;

select greatest (sysdate, sysdate + 3,sysdate -5)
from dual;

select least (sysdate, sysdate + 3,sysdate -5)
from dual;

select sysdate-to_date('10-08-1997','dd-mm-yyyy')
from dual;

select user 
from dual;

select last_name,salary,department_id
from employees
where salary=12000 or salary=10000
order by salary desc,department_id asc;
