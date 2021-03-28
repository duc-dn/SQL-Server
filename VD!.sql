create function dbo.tinhdiemTB()
return table
as
	return select Kq.masv, sum(DIEM*sotc) as DTB
	from monhoc, KQ
	where monhoc.maMH = KQ.maMH
	group by KQ.Masv
	select * from dbo.tinhdiemTB()