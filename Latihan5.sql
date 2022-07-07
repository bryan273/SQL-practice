-- Buat summary per cabang,
-- Tampilkan nama cabang, jumlah karyawan laki2, 
-- karyawan perempuan,
-- dan total transaksi di bulan Desember 2008
with summary as (
	select kode_cabang,
	count(case when mk.jenis_kelamin='p' then 1 end) n_pria,
 	count(case when mk.jenis_kelamin='w' then 1 end) n_wanita
	from ms_karyawan mk
	group by kode_cabang)
select tp.kode_cabang , sm.n_pria, sm.n_wanita,
count(tp.kode_transaksi) total_transaksi
from summary sm
join tr_penjualan tp 
on sm.kode_cabang = tp.kode_cabang 
where year(tp.tgl_transaksi) = 2008
and month(tp.tgl_transaksi) = 12
group by 1,2,3
