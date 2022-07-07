-- Tampilkan Total Transaksi per kasir, 
-- dan bandingkan dengan total per cabang
with temp as (
select kode_cabang, kode_kasir, 
count(*) as total_transaksi
from tr_penjualan tp 
group by 1,2
)
select *,
sum(total_transaksi) over(partition by kode_cabang) as total_per_cabang
from temp