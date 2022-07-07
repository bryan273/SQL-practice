select
mk.nama_depan as nama_depan,
mp.nama_propinsi as provinsi_kasir,
mp.nama_propinsi as provinsi_transaksi,
count(tp.kode_transaksi) as total_transaksi,
avg(tp.jumlah_pembelian) as rata_rata_pembelian,
sum(tp.jumlah_pembelian * mhh.harga_berlaku_cabang) as total_pembelian,
sum(tp.jumlah_pembelian * 
(mhh.harga_berlaku_cabang-mhh.modal_cabang-mhh.biaya_cabang)) as total_untung
from tr_penjualan tp
join ms_karyawan mk on mk.kode_karyawan = tp.kode_kasir 
join ms_cabang mc  on mk.kode_cabang = mc.kode_cabang 
join ms_kota mk2 on mc.kode_kota = mk2.kode_kota 
join ms_propinsi mp  on mk2.kode_propinsi  = mp.kode_propinsi 
join ms_harga_harian mhh on mhh.kode_produk = tp.kode_produk 
and mhh.kode_cabang = tp.kode_cabang 
and mhh.tgl_berlaku = tp.tgl_transaksi 
group by mk.kode_karyawan,1,2
order by 1;