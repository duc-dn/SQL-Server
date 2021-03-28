create database QLBH
go

create table CongTy
(
MaCT char(10) not null primary key,
TenCT nvarchar(20) not null,
TrangThai nvarchar(20) not null,
ThanhPho nvarchar(20) not null
)

create table SanPham
(
MaSP char(10) not null primary key,
MauSac nvarchar(10) not null,
SoLuong int not null,
GiaBan money not null
)

create table CungUng
(
MaCT char(10) not null,
MaSP char(10) not null,
SoLuongcungung int not null,
primary key(MaCT, MaSP),
constraint FK1 foreign key(MaCT) references CongTy(MaCT),
constraint FK2 foreign key(MaSP) references SanPham(MaSP)
)

insert into CongTy values
('FLC', 'Du lich', 'Perfect', 'Thanh Hóa'),
('FPT', 'Công nghệ', 'Good', 'Hà Nội'),
('VCB', 'Ngân Hàng', 'Good', 'Everywhere'),
('VIN', 'Công nghệ', 'Good', 'Hà Nội')

insert into SanPham values
('m01', N'Đỏ', 20, 30000),
('m02', N'Xanh', 14, 25000),
('m03', N'Vàng', 10, 10000),
('m04', N'Trắng', 25, 13000)

insert into CungUng values
('FLC', 'm01', 20),
('VIN', 'm03', 25),
('FPT', 'm02', 15),
('FLC', 'm04', 10)

select * from SanPham
select * from CungUng
select * from CongTy

CREATE PROC SP_NHAPCTY(@MACTY CHAR(10), @tencty nvarchar(20), @TRANGTHAI NVARCHAR(20), @THANHPHO NVARCHAR(20))
AS
BEGIN 
	IF (EXISTS(SELECT TenCT FROM CongTy WHERE TenCT = @tencty))
		PRINT('CONG TY ' + @TENCTY + ' DA CO TRONG TABLE CONG TY')
	ELSE
		INSERT INTO CongTy VALUES(@MACTY, @tencty, @TRANGTHAI, @THANHPHO)
END

SELECT * FROM CongTy
EXEC SP_NHAPCTY 'MBB', N'Ngân Hàng 1', 'GOOD', 'HÀ NỘI'


CREATE PROC SP_XOAMCTY1(@TENCTY CHAR(10))
AS
BEGIN
	IF (NOT EXISTS(SELECT MaCT FROM CongTy WHERE TenCT = @TENCTY))
		PRINT('CONG TY ' + @TENCTY + ' KHONG TON TAI')
	ELSE
		DELETE CongTy WHERE TenCT = @TENCTY
END

SELECT * FROM CongTy
EXEC SP_XOAMCTY1 'Ngân Hàng 1'

exec SP_NHAPCTY 'VCB', 'Tài chính', 'Exenlent', 'Hà Nội'


CREATE PROC SP_SUACTY(@TENCTY NVARCHAR(20), @TRANGTHAI NVARCHAR(20))
AS
BEGIN
	IF (NOT EXISTS(SELECT MaCT FROM CongTy WHERE TenCT = @TENCTY))
		PRINT('CONG TY ' + @TENCTY + ' KHONG TON TAI')
	ELSE
		UPDATE CONGTY SET TRANGTHAI = @TRANGTHAI
		WHERE TENCT = @TENCTY
END

EXEC SP_SUACTY 'CÔNG NGHỆ', 'BAD'
SELECT * FROM CongTy


