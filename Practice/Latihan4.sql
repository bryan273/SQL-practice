-- Tampilkan nama bulan dan jumlah transaksi 
-- setiap bulannya selama tahun 2008
select monthname(tgl_transaksi) as bulan,
count(kode_transaksi)
from tr_penjualan tp 
where year(tgl_transaksi)=2008
group by month(tgl_transaksi)
order by month(tgl_transaksi)
desc
