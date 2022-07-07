-- tampilkan nama depan dan nama belakang kasir 
-- yang paling sering menangani pelanggan,
-- dan tampilkan pula berapa kali transaksi nya, 
-- serta rata rata jumlah pembelian setiap transaksi
select mk.nama_depan , mk.nama_belakang ,
count(tp.kode_transaksi) jumlah_transaksi, 
avg(tp.jumlah_pembelian) ratarata_transaksi
from ms_karyawan mk 
join tr_penjualan tp 
on mk.kode_karyawan = tp.kode_kasir 
group by mk.kode_karyawan ,1,2
order by jumlah_transaksi desc 
limit 2