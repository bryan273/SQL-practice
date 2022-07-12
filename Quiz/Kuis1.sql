-- ** SOAL **
-- Perusahaan ingin mengetahui detail dari transaksi yang merupakan pembelian (jumlah_pembelian) terbanyak pada masing-masing produk dalam 1 transaksi (1 transaksi per produk).
-- Jika ada lebih dari 1 transaksi dengan jumlah pembelian yang sama untuk produk yang sama, ambil pembelian dengan tanggal paling pertama, jika masih ada yang sama, ambil kode_transaksi yang paling kecil.
-- 
-- Tampilkan 
-- - nama cabang, 
-- - nama depan kasir, 
-- - tanggal transaksi, 
-- - nama produk
-- - jumlah pembelian
-- Urutkan data berdasarkan kode produk

-- Set only full group by
SET sql_mode=(SELECT CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY'));

-- Check status sql mode
SELECT @@sql_mode

-- Sort "kode_transaksi" and "tgl_transaksi" 
with sorted_tr as (
    select kode_transaksi, tgl_transaksi 
    from tr_penjualan tp1
    order by kode_transaksi asc, tgl_transaksi asc
),
-- Compare sorted to real "kode_transaksi" and "tgl_transaksi" 
-- Check if "kode_transaksi" and "tgl_transaksi" have already sorted 
check_sort as (
	-- Select the sum of the differences of sorted and real
	select sum(st.kode_transaksi - tp2.kode_transaksi) diff_a,  
		   sum(st.tgl_transaksi - tp2.tgl_transaksi) diff_b 
	from sorted_tr st
	join tr_penjualan tp2 using(kode_transaksi)
)
-- The sum of differences is 0, 
-- so "kode_transaksi" and "tgl_transaksi" have already sorted
select * from check_sort

-- Check the max "jumlah_pembelian" for each "kode_produk"
with jmlh_per_produk as ( 
	select kode_produk, max(jumlah_pembelian) as max_pemb
	from tr_penjualan tp 
	group by 1
)
-- The max pembelian value for all product is 20
-- For this case, we can filter "tr_penjualan" 
-- with jumlah_pembelian=20 to shorten query time
select distinct max_pemb from jmlh_per_produk

-- Table represents max "jumlah_pembelian" for each "kode_produk" sorted
with jpp_sort as(
	select * from (
			select kode_transaksi, kode_produk,
				   row_number() over (partition by kode_produk 				   
				   order by kode_transaksi asc) rn -- "tgl_transaksi" already sorted by "kode_transaksi"
			from tr_penjualan tp
			where jumlah_pembelian = 20 -- based on before analysis
	) jpp_sort_tmp
	where rn=1
)
-- display the columns based on task
select mc.nama_cabang, mk.nama_depan,
		tp.tgl_transaksi, mp.nama_produk,
		tp.jumlah_pembelian 
from tr_penjualan tp
join jpp_sort js on tp.kode_transaksi = js.kode_transaksi -- to exract tgl transaksi and connect other table
join ms_cabang mc on tp.kode_cabang = mc.kode_cabang -- to extract nama cabang
join ms_karyawan mk on tp.kode_kasir = mk.kode_karyawan -- to extract nama depan
					and tp.kode_cabang = mk.kode_cabang
join ms_produk mp on tp.kode_produk = mp.kode_produk -- to extract nama produk
order by js.kode_produk