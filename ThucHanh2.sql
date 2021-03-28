create database BanHang;
go

create table HangSX
(
MaHangSX char(10) not null primary key,
TenHang nvarchar(30) not null,
DiaChi nvarchar(30) not null,
SoDT char(15) not null, 
Email char(30) not null
);


create table SanPham
(
MaSP char(10) not null primary key,
MaHangSX char(10) not null,
TenSP nvarchar(30) not null,
SoLuong int not null,
MauSac nvarchar(10) not null,
GiaBan int not null,
DonViTinh char(10) not null,
MoTa nvarchar(30) not null,
foreign key(MaHangSX) references HangSX(MaHangSX)
);

create table NhanVien 
(
MaNV char(10) not null primary key,
TenNV nvarchar(30) not null,
GioiTinh char(5) not null,
DiaChi nvarchar(30) not null,
SoDT char(15) not null,
Email char(30) not null,
TenPhong nvarchar(20) not null
);

create table PNhap
(
SoHDN char(10) not null primary key,
NgayNhap date not null,
MaNV char(10) not null
foreign key(MaNV) references NhanVien(MaNV),
);

create table Nhap
(
SoHDN char(10) not null,
MaSP char(10) not null,
SoLuongN int not null,
DonGiaN int not null,
primary key(SoHDN, MaSP),
foreign key(MaSP) references SanPham(MaSP),
foreign key(SoHDN) references PNhap(SoHDN)
);


create table PXuat 
(
SoHDX char(10) not null primary key,
NgayXuat date not null,
MaNV char(10) not null,
foreign key(MaNV) references NhanVien(MaNV)
);


create table Xuat
(
SoHDX char(10) not null,
MaSP char(10) not null,
SoLuongX int not null,
primary key(SoHDX, MaSP),
foreign key(MaSP) references SanPham(MaSP),
foreign key(SoHDX) references PXuat(SoHDX)
);


/*a*/
create view CauA
as
Select HangSX.MaHangSX, TenHang, Count(*) As N'So luong SP'
From SanPham Inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
Group by HangSX.MaHangSX, TenHang

/*b*/
create view CauB
as
Select SanPham.MaSP,TenSP, sum(SoLuongN*DonGiaN) As N'Tổng tiền nhập'
From Nhap Inner join SanPham on Nhap.MaSP = SanPham.MaSP
Inner join PNhap on PNhap.SoHDN=Nhap.SoHDN
Where Year(NgayNhap)=2020
Group by SanPham.MaSP,TenSP


/*c*/
create view CauC
as
Select SanPham.MaSP,TenSP,sum(SoLuongX) As N'Tổng xuất'
From Xuat Inner join SanPham on Xuat.MaSP = SanPham.MaSP
Inner join HangSX on HangSX.MaHangSX = SanPham.MaHangSX
Inner join PXuat on Xuat.SoHDX=PXuat.SoHDX
Where Year(NgayXuat)=2018 And TenHang = 'Samsung'
Group by SanPham.MaSP,TenSP
Having sum(SoLuongX) >=10000


/*d*/

create view CauD
as
select TenPhong, count(MaNV) as 'Sl NV Nam'
from NhanVien
where GioiTinh = 'Nam'
group by TenPhong


/*e*/
create view CauE
as
select HangSX.MaHangSX, TenHang, sum(SoLuongN) as 'SoLuongN'
from SanPham inner join Nhap on SanPham.MaSP = Nhap.MaSP
		   inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
		   inner join PNhap on Nhap.SoHDN = PNhap.SoHDN
where year(NgayNhap) = '2018'
group by HangSX.MaHangSX, TenHang

/*f*/
create view CauF
as
select NhanVien.MaNV, TenNV, sum(SoLuongX) as 'SoLuongX 2018'
from NhanVien inner join PXuat on NhanVien.MaNV = PXuat.MaNV
		      inner join Xuat on PXuat.SoHDX = Xuat.SoHDX
where year(NgayXuat) = '2018'
group by NhanVien.MaNV, TenNV

/*g*/
create view CauG
as
select NhanVien.MaNV, TenNV, sum(SoLuongN * DonGiaN) as 'Tong Tien Nhap'
from NhanVien inner join PNhap on NhanVien.MaNV = PNhap.MaNV
			  inner join Nhap on PNhap.SoHDN = Nhap.SoHDN
where year(NgayNhap) = '2018' and month(NgayNhap) = '8'
group by NhanVien.MaNV, TenNV
having sum(SoLuongN * DonGiaN) > 100000

/*h*/
create view CauH
as
Select SanPham.MaSP,TenSP
From SanPham Inner join nhap on SanPham.MaSP = nhap.MaSP
Where SanPham.MaSP Not In (Select MaSP From Xuat)

/*Cau i*/
create view CauI
as
select TenSP, SanPham.MaSP
from SanPham inner join Nhap on SanPham.MaSP = Nhap.MaSP
			 inner join PNhap on Nhap.SoHDN = PNhap.SoHDN
			 inner join Xuat on SanPham.MaSP = Xuat.MaSP
			 inner join PXuat on Xuat.SoHDX = PXuat.SoHDX
where YEAR(NgayNhap) = '2020' and year(NgayXuat) = '2020'
and SanPham.MaSP in (select Nhap.MaSP from Nhap)
and SanPham.MaSP in (select Xuat.MaSP from Xuat);

/*Cau j*/
create view CauJ
as
select TenNV, NhanVien.MaNV
from NhanVien inner join PNhap on NhanVien.MaNV = PNhap.MaNV
			  inner join Nhap on Nhap.SoHDN = PNhap.SoHDN
			  inner join PXuat on NhanVien.MaNV = PXuat.MaNV
			  inner join Xuat on PXuat.SoHDX = Xuat.SoHDX
where NhanVien.MaNV in (select PNhap.MaNV from PNhap)
and NhanVien.MaNV in (select PXuat.MaNV from PXuat);

/* Cauk*/
create view Cauk
as
select TenNV, NhanVien.MaNV
from NhanVien inner join PNhap on NhanVien.MaNV = PNhap.MaNV
			  inner join Nhap on Nhap.SoHDN = PNhap.SoHDN
			  inner join PXuat on NhanVien.MaNV = PXuat.MaNV
			  inner join Xuat on PXuat.SoHDX = Xuat.SoHDX
where NhanVien.MaNV not in (select PNhap.MaNV from PNhap)
and NhanVien.MaNV  not in (select PXuat.MaNV from PXuat);

/*Cau l*/

create view demo
as
select SanPham.MaSP, sum(soluongx) as TongSl
from SanPham inner join xuat on SanPham.MaSP = Xuat.MaSP
group by SanPham.masp

create view CauL
as
select TenSP
from SanPham inner join Xuat on SanPham.MaSP = Xuat.MaSP
			 inner join PXuat on Xuat.SoHDX = Xuat.SoHDX
group by TenSP
having sum(SoLuongX) = (select max(TongSl) from demo)


/*Cau m*/
create view m
as 
select TenSP, TenHang
from SanPham inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
where GiaBan = (select min(GiaBan) from SanPham);

/*Cau cuoi*/

create view caucuoi
as
select tensp
from SanPham inner join Xuat on SanPham.MaSP = Xuat.MaSP
				inner join PXuat on PXuat.SoHDX = Xuat.SoHDX
where year(NgayXuat) = '2020'
group by TenSP
having count(TenSP) > 10



Create view caul 
As
Select TenSP,SoLuongN
From SanPham inner join Nhap on SanPham.MaSP=Nhap.MaSP
Where SoLuongN=(select sum(SoLuongN) from Nhap)
Group by TenSP
Having SoLuongN=(select max(SoLuongN) from Nhap)
Select *from caul