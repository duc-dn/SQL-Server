SELECT DT.Madt, DT.Tendt
FROM TBLDeTai AS dt
WHERE DT.Kinhphi =
(
	SELECT MAX(DT.Kinhphi)
	FROM TBLDeTai AS DT
)

Select gv.Magv, gv.Hotengv, k.Tenkhoa
from TBLGiangVien as gv join TBLKhoa as k
on gv.Makhoa = k.Makhoa
where gv.Magv in (
	select hd.Magv
	from TBLHuongDan as hd
	group by hd.Magv 
	having count(hd.Masv) > 1
)


select k.Tenkhoa, count(sv.Masv) as so_sv
from TBLKhoa as k join TBLSinhVien as sv
on k.Makhoa = sv.Makhoa
group by k.tenkhoa

select count(gv.Magv) AS SO_GV
from TBLGiangVien as gv join TBLKhoa as k
on gv.Makhoa = k.Makhoa
where k.Tenkhoa = 'CONG NGHE SINH HOC'

SELECT COUNT(GV.Magv) AS SỐ_GV
FROM TBLGiangVien GV join TBLKhoa K
ON GV.Makhoa = K.Makhoa
WHERE K.Tenkhoa='CONG NGHE SINH HOC'

