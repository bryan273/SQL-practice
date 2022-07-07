-- Tampilkan Unique Nama Depan dan Nama belakang dari karyawan 
-- yang nama depan huruf paling depan “A” 
-- nama belakang huruf paling belakang “a”
select distinct *
from ms_karyawan mk 
where nama_depan like "a%"
and 
nama_belakang like "%a"