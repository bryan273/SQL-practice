-- Tampilkan nama cabang dan nama kota 
-- yang punya data penjualan

select nama_cabang, nama_kota 
from ms_cabang mc 
-- untuk ambil nama kota
join ms_kota mk on mc.kode_kota = mk.kode_kota 
--  memfilter cabang yang ada penjualan
where mc.kode_cabang in (select kode_cabang from tr_penjualan)