-- Ambil angka dari # di address
select address, 
	regexp_substr(address, '(?<=#)[0-9]+') as angka
from ms_people mp 
limit 10
