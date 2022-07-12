-- **SOAL**
-- Perusahaan ingin mengetahui bagaimana growth dari keuntungan bulanan 
-- untuk setiap cabang supaya nantinya bisa di-analisis lebih detail 
-- terkait pertumbuhan yang terjadi, kenapa ada perbedaan growth setiap cabang setiap bulan.
--  
-- Tampilkan 
-- * nama cabang
-- * nama bulan dan tahun transaksi, 
-- * keuntungan per bulan
-- * persen growth 
-- Urutkan datanya berdasarkan nama cabang kemudian bulan
-- 
-- persen growth = persen perubahan bulan ini dibandingkan dengan bulan sebelumnya, 
-- nilainya positif jika naik dan negatif jika turun

-- Set only full group by
SET sql_mode=(SELECT CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY'));

-- Check status sql mode
SELECT @@sql_mode

-- Temporary table for "keuntungan" grouped and sorted by cabang and month
with keuntungan_per_cabang as (
	select mc.nama_cabang,
		DATE_FORMAT(tp.tgl_transaksi ,'%M %Y') as nama_bulan_tahun, -- date formatted to month year
		sum(tp.jumlah_pembelian * (mhh.harga_berlaku_cabang-
			mhh.modal_cabang-mhh.biaya_cabang)) as keuntungan -- calculate keuntungan 
	from tr_penjualan tp 
	join ms_harga_harian mhh -- join on 3 keys
		on tp.kode_produk = mhh.kode_produk and 
		tp.kode_cabang = mhh.kode_cabang and 
		tp.tgl_transaksi = mhh.tgl_berlaku 
	join ms_cabang mc 
		on tp.kode_cabang = mc.kode_cabang 
	group by 1,2, month(tp.tgl_transaksi) -- group by cabang and month
	order by 1, month(tp.tgl_transaksi) -- order by cabang and month
)
select *,
-- persen_growth = (present keuntungan - past keuntungan)/(past keuntungan)*100%
	(keuntungan/lag(keuntungan) 
	over(partition by nama_cabang)-1)*100 as persen_growth
from keuntungan_per_cabang
