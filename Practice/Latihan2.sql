-- Tampilkan cabang, jumlah semua produk di hari itu per cabang, 
-- rata2 harga berlaku cabang di hari itu
-- di harga harian tanggal 31 Desember 2008
-- Hanya untuk cabang yang pernah punya harga berlaku cabang 
-- pada tanggal itu lebih dari 106,000
select kode_cabang,
count(distinct kode_produk),
avg(harga_berlaku_cabang)
from ms_harga_harian mhh 
where tgl_berlaku = date "2008-12-31"
group by kode_cabang 
having max(harga_berlaku_cabang) > 106000