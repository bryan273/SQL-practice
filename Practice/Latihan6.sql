-- Berapa total kentungan yang didapat pada tanggal 
-- 8 Agustus 2008 pada cabang Makassar 01
select sum(tp.jumlah_pembelian* (mhh.harga_berlaku_cabang-
mhh.modal_cabang-mhh.biaya_cabang))
from ms_harga_harian mhh
join tr_penjualan tp 
on mhh.tgl_berlaku = tp.tgl_transaksi and
mhh.kode_produk = tp.kode_produk and 
mhh.kode_cabang = tp.kode_cabang 
where
tp.kode_cabang = "CABANG-039" and 
tp.tgl_transaksi = date("2008-08-08")
