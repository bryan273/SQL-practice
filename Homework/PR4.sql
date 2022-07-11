-- Mengambil nama domain dan ekstensi dari email
select email, regexp_substr (email, '[^@]+') as username,
regexp_substr(email, '(?<=@)[^\.]+') as domain_name,
regexp_substr(email, '\.[A-Za-z]+$') as domain_extension
from ms_people mp 

