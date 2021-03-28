create database BH2;
go
use BH2
go
create table HangSX
(
	MaHangSX char(10) primary key not null,
	TenHang nvarchar(100) not null,
	DiaCh nvarchar(100) not null,
	SoDT int,
	Email char(20),
)
create table SanPham
(
	MaSP char(10) primary key not null,
	MaHangSX char(10) not null,
	TenSP nvarchar(50) not null,
	SoLuong int not null,
	MauSac nvarchar(10) not null,
	GiaBan money not null,
	DonViTinh int not null,
	MoTa nvarchar(100) not null,
	constraint FK1 foreign key (MaHangSX) references HangSX(MaHangSX) ON UPDATE CASCADE ON DELETE CASCADE,
)
create table NhanVien
(
	MaNV char(10) primary key not null,
	TenNV nvarchar(50) not null,
	GioiTinh char(5) not null,
	DiaChi nvarchar(100) not null,
	SoDT int not null,
	Email varchar(100) not null,
	TenPhong nvarchar(50) not null,
)
create table PNhap
(
	SoHDN char(10) primary key not null,
	NgayNhap datetime,
	MaNV char(10) not null,
	constraint FK3 foreign key (MaNV) references NhanVien(MaNV) ON UPDATE CASCADE ON DELETE CASCADE,
)
create table Nhap
(
	SoHDN char(10) not null,
	MaSP char(10) not null,
	SoLuongN int not null,
	DonGiaN money not null,
	constraint PK1 primary key (SoHDN,MaSP),
	constraint FK8 foreign key (SoHDN) references PNhap(SoHDN) ON UPDATE CASCADE ON DELETE CASCADE,
	constraint FK2 foreign key (MaSP) references SanPham(MaSP) ON UPDATE CASCADE ON DELETE CASCADE,
)
create table PXuat
(
	SoHDX char(10) primary key not null,
	NgayXuat datetime,
	MaNV char(10) not null,
	constraint FK5 foreign key (MaNV) references NhanVien(MaNV) ON UPDATE CASCADE ON DELETE CASCADE,
)
create table Xuat
(
	SoHDX char(10) not null,
	MaSP char(10) not null,
	SoLuongX int not null,
	constraint PK2 primary key (SoHDX,MaSP),
	constraint FK9 foreign key (SoHDX) references PXuat(SoHDX) ON UPDATE CASCADE ON DELETE CASCADE,
	constraint FK4 foreign key (MaSP) references SanPham(MaSP) ON UPDATE CASCADE ON DELETE CASCADE,
)

go
insert into HangSX values ('1','kéo','hà nội',123456,'vuvanhao');
insert into HangSX values ('2','dao','sài gòn',234567,'haodeptrai');
insert into HangSX values ('3','quần','cà mau',345678,'haomitom');
insert into HangSX values ('4','áo','hải dương',456789,'haocool');
select*from HangSX;
insert into SanPham values ('01','1','giày',10,'đỏ',100000,1,'đẹp');
insert into SanPham values ('02','3','dép',5,'xanh',15000,1,'xấu');
insert into SanPham values ('03','4','mũ',15,'tím',20000,1,'vừa');
insert into SanPham values ('04','3','nước',100,'vàng',5000,1,'tạm');
insert into SanPham values ('05','2','lọ',20,'trắng',25000,1,'xấu');
select*from SanPham;
insert into NhanVien values ('n1','hảo','nam','hà nội',123,'haohandsome','tai chinh');
insert into NhanVien values ('n2','hảo hảo','nu','ca mau',456,'haomitom','ke toan');
insert into NhanVien values ('n3','hảo mì ','nam','tuyen quang',789,'haohao','tai vu');
insert into NhanVien values ('n4','Phòng ','nam','tuyen quang',789,'haohao','tai vu');
select*from NhanVien;
insert into Nhap values ('h1','01',10,15000);
insert into Nhap values ('h5','05',165,20000);
insert into Nhap values ('h5','04',15,2000);
select*from Nhap;
insert into PNhap values ('h1','2001/2/2','n1');
insert into PNhap values ('h5','2001/5/2','n3');
select*from PNhap;
insert into Xuat values ('x2','03',10);
insert into Xuat values ('x2','02',15);
select*from Xuat;
insert into PXuat values ('x2','2002/5/4','n1');
select*from PXuat;



--caud
create function caud(@tenphong nvarchar(10))
returns @danhsach table(manv char(10), tennv nvarchar(20))
as
begin
	insert into @danhsach
	select MaNV, TenNV
	from NhanVien
	where TenPhong = @tenphong
	return
end

-- caue
