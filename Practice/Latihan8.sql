-- Tampilkan nama cabang dan nama kota 
-- dari cabang yang tidak punya data penjualan 
-- di kota yang ada data penjualan (dari cabang lain)

select nama_cabang, nama_kota 
from ms_cabang mc 
-- untuk ambil nama kota
join ms_kota mk on mc.kode_kota = mk.kode_kota 
--  memfilter cabang yang tidak ada penjualan
where mc.kode_cabang not in (select kode_cabang from tr_penjualan)
--  memfilter kota yang ada penjualan
and  mc.kode_kota in (
					-- memilih kode_kota dari daftar cabang
					select kode_kota from ms_cabang mc2 
					-- untuk cabang yang ada penjualan
					where kode_cabang in (select kode_cabang from tr_penjualan)
					)



