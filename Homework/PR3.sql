-- Tampilkan nama kota, group cabang yang berjualan dan 
-- group cabang yang tidak berjualan untuk 
-- kota yang ada data penjualan

SET global sql_mode=(SELECT CONCAT(@@GLOBAL.sql_mode, ',ONLY_FULL_GROUP_BY'));
-- cabang jualan
with jualan as (
select mk.nama_kota, 
	mc.nama_cabang as cabang_jualan 
from ms_cabang_2 mc
join ms_kota_2 mk
	on mc.kode_kota = mk.kode_kota 
where mc.kode_cabang in 
	(select distinct kode_cabang
	from tr_penjualan_2 tp)
),
-- cabang tidak jualan
tidak_jualan as (
select mk.nama_kota, 
	group_concat(mc.nama_cabang) as cabang_tidak_jualan
from ms_cabang_2 mc
join ms_kota_2 mk
	on mc.kode_kota = mk.kode_kota 
where mc.kode_cabang not in 
	(select distinct kode_cabang 
	from tr_penjualan_2 tp2) 
	and
	mc.kode_kota in 
	(select distinct kode_kota 
	from ms_cabang_2 mc2
	where kode_cabang in 
		(select distinct kode_cabang from tr_penjualan_2 tp2)
	)
group by 1
)
-- gabungan cabang jualan dan tidak jualan
select *
from jualan
join tidak_jualan
using(nama_kota)