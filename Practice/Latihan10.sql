-- Mengambil nama domain dan ekstensi dari email
select email, regexp_replace(email, '.*@(.*)', '$1') domain
from ms_people mp 
limit 10;


select email, regexp_substr(email, '(@.+)') 
from ms_people mp 
limit 10

select email,SUBSTR(email , INSTR(email, '@') + 1) as new
from ms_people mp 
limit 5

select email,
substr(regexp_substr(email, '@.+'),2)
from ms_people mp
