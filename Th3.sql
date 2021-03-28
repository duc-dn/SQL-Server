create database BanHang1;
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
NgayNhap datetime not null,
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
NgayXuat datetime not null,
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


insert into HangSX values
('1', 'Sam Sung', N'Hàn Quốc', '0000', 'korean'),
('2', 'Apple', N'Mỹ', '1111', 'american'),
('3', 'Redmi', N'Trung Quôc', '2222','China'),
('4', 'Vinsmart', N'Việt Nam', '3333', 'Vietnamese')

insert into SanPham values
('m01', '1', 'Điện thoại', 4, 'Đen', '30000', 'VND', 'No'),
('m02', '2', 'Laptop', 5, 'Grey', '40000', 'VND', 'No'),
('m03', '3', 'Tablet', 3, 'Blue', '25000', 'USD', 'OK'),
('m04', '4', 'Airpot', 6, 'Black', '35000', 'USD', 'great'),
('m05', '3', 'Card', 4, 'White', '2000', 'VND', 'perfect')

insert into NhanVien values
('n1', N'Đỗ', 'Nam', 'Hà Nam', '0912', 'do', 'Hanh chinh'),
('n2', N'Ngọc', 'Nữ', 'Hà Nam', '0913', 'ngoc', 'Ke toan'),
('n3', N'Đức', 'Nam', 'Hà Nội', '0002', 'duc', 'Thuc hanh'),
('n4', N'Peter', N'LGBT', 'American', '0167', 'hello', 'Hi')

insert into PNhap values
('s2', '4/20/2001', 'n2'),
('s3', '5/22/2001', 'n4'),
('s4', '6/21/2001', 'n1')

select * from PNhap

insert into Nhap values
('s1', 'm01', 4, 50000),
('s2', 'm03', 30, 34000),
('s4', 'm02', 5, 40000),
('s1', 'm04', 30, 4000)

insert into PXuat values
('px1', '3/22/2001', 'n1'),
('px2', '4/20/2020', 'n3'),
('px3', '5/20/2021', 'n2'),
('px4', '6/30/2020', 'n4')

insert into Xuat values
('px1', 'm01', 30),
('px2', 'm02', 20),
('px3', 'm01', 50),
('px4', 'm03', 35)


Create Function fn_DSSPTheoHangSX(@TenHang nvarchar(20))
Returns @bang Table (
MaSP nvarchar(10),
TenSP nvarchar(20),
SoLuong int,
MauSac nvarchar(20),
GiaBan money,
DonViTinh nvarchar(10),
MoTa nvarchar(max)
)
As
Begin
Insert Into @bang
Select MaSP, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa
From SanPham Inner join HangSX
on SanPham.MaHangSX = HangSX.MaHangSX
Where TenHang = @TenHang
Return
end


Select * From fn_DSSPTheoHangSX('Sam sung')


Create Function fn_DSSPTheoSL(@TenHang nvarchar(20), @Flag int)
Returns @bang Table (
MaSP nvarchar(10),
TenSP nvarchar(20),
TenHang nvarchar(20),
SoLuong int,
MauSac nvarchar(20),
GiaBan money,
DonViTinh nvarchar(10),
MoTa nvarchar(max)
)
As
Begin
If(@flag=0)
Insert Into @bang
Select MaSP,TenSP,TenHang,SoLuong,MauSac,GiaBan,DonViTinh,MoTa
From SanPham Inner join HangSX
on SanPham.MaHangSX = HangSX.MaHangSX
Where TenHang = @TenHang And SoLuong=0
Else
If(@flag =1)
Insert Into @bang
Select MaSP,TenSP,TenHang,SoLuong,MauSac,GiaBan,DonViTinh,MoTa
From SanPham Inner join HangSX
on SanPham.MaHangSX = HangSX.MaHangSX
Where TenHang = @TenHang And SoLuong >0
Return
End


Select * From fn_DSSPtheoSL('Apple',1)
Select * From fn_DSSPtheoSL('vinsmart',1)

