select gv.Hotengv, gv.Magv, k.Tenkhoa
from TBLGiangVien as gv join TBLKhoa as k
on gv.Makhoa = k.Makhoa


select gv.Magv, gv.Hotengv, k.Tenkhoa
from TBLKhoa as k join TBLGiangVien as gv
on k.Makhoa = gv.Makhoa
where k.Tenkhoa = 'DIA LY va QLTN'

SELECT COUNT(SV.MASV) AS SỐ_SV
FROM TBLSinhVien SV
WHERE Makhoa = 'Bio'

SELECT SV.Masv, SV.Hotensv, (YEAR(GETDATE()) - SV.Namsinh) AS TUOI
FROM TBLSinhVien AS SV INNER JOIN TBLKhoa AS K
ON SV.Makhoa = K.Makhoa
where k.Tenkhoa = 'TOAN'

SELECT K.Makhoa, K.Tenkhoa, COUNT(GV.Magv) AS SO_GV
FROM TBLKhoa AS K INNER JOIN TBLGiangVien AS GV
ON K.Makhoa = GV.Makhoa
GROUP BY K.Makhoa, K.Tenkhoa

SELECT K.Dienthoai
FROM TBLKhoa AS K JOIN TBLSinhVien AS SV
ON K.Makhoa = SV.Makhoa
WHERE SV.Hotensv = 'Le van son'

SELECT GV.Magv, GV.Hotengv, K.Tenkhoa
FROM TBLKhoa AS K JOIN TBLGiangVien AS GV
ON K.Makhoa = GV.Makhoa
WHERE GV.Magv IN (
	SELECT GV.Magv
	FROM TBLGiangVien AS GV JOIN TBLSinhVien AS SV
	ON GV.Makhoa = SV.Makhoa
	GROUP BY gv.Magv
	HAVING COUNT(SV.Masv) >= 3
)

SELECT GV.Magv,GV.Hotengv,K.Tenkhoa
FROM TBLGiangVien GV JOIN TBLKhoa K
ON GV.Makhoa = K.Makhoa
WHERE GV.Magv IN (
SELECT HD.Magv
FROM TBLHuongDan HD
GROUP BY HD.Magv
HAVING COUNT(HD.MaSV)>3)

SELECT DT.Madt, DT.Tendt
FROM TBLDeTai AS DT
where DT.Kinhphi = 
(
	SELECT MAX(DT.Kinhphi)
	FROM TBLDeTai AS DT
)

SELECT K.Tenkhoa, COUNT(SV.Masv) AS SO_SV
FROM TBLKhoa AS K JOIN TBLSinhVien AS SV
ON K.Makhoa = SV.Makhoa
GROUP BY K.Tenkhoa

SELECT DT.Madt, DT.Tendt
FROM TBLDeTai AS DT