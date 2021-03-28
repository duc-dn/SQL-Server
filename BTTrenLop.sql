-- create thu tuc chen
create proc SP_NhapKhoa(@MAKHOA int, @TENKHOA nvarchar(20), @DIENTHOAI nvarchar(12))
as
begin
	if (exists(select * from Khoa where Tenkhoa = @TENKHOA))
		print 'TEN KHOA ' + @tenkhoa + 'DA TON TAI'
	else
		insert into khoa values (@MAKHOA, @TENKHOA, @DIENTHOAI)
end

--- Test
select * from Khoa
exec SP_NhapKhoa 6, 'XYZ', '122232'
exec SP_NhapKhoa 7, 'XTZ', '12242'


-- create thu tuc xoa
create proc SP_XoaKhoa(@MaKhoa int)
as
	begin 
		if(not exists(select * from Khoa where MaKhoa = @MaKhoa))
			print 'Ma Khoa' + @makhoa + 'khong ton tai'
		else
			delete khoa where makhoa = @MaKhoa
	end
--test
select * from khoa
exec SP_XoaKhoa 2

-- create thu tuc sua
create proc sp_SuaKhoa(@MaKhoa int, @TenKhoa nvarchar(20), @DienThoai nvarchar(12))
as
	begin
		if(not exists(select * from khoa where Makhoa = @MaKhoa))
			print 'Ma khoa ' + @makhoa + 'khong ton tai'
		else
			update khoa set tenkhoa = @TenKhoa, dienthoai = @DienThoai
			where makhoa = @makhoa
	end

-------------------------
-- thu tuc tim kiem
create proc SP_TIMKHOA(@MAKHOA int)
as
	begin
		if (not exists(select * from khoa where makhoa = @MAKHOA))
			print 'Ma khoa ' + @makhoa + ' khong ton tai'
		else
			select * from khoa
			where makhoa = @MAKHOA
	end

--test
drop proc SP_TIMKHOA
exec sp_timkhoa 8


-------------------------
-- tạo thủ tục sửa
create proc SP_SUAKHOA(@MaKhoa int, @TenKhoa nvarchar(20), @DienThoai nvarchar(12))
as
begin
	if(not exists(select * from Khoa where makhoa = @MaKhoa)
		print 'Ma khoa ' + @makhoa + ' khong ton tai'
	else
		update khoa set tenkhoa = @TenKhoa, dienthai = @DienThoai
		where makhoa = @MaKhoa
end




-----------------------------------------------------------
----------- Bai TH2 -------------------------
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



-- cau b
CREATE view ThongKe 
As
Select CungUng.MaCT, CungUng.MaSP, TenCT, sum(SoLuongcungung*GiaBan) as 'TongTien' 
From CungUng inner join SanPham 
On CungUng.MaSP = SanPham.MaSP 
Inner join CongTy on CungUng.MaCT= SanPham.MaCT 
Group By CungUng.MaCT, CungUng.MaSP, TenCT

-- cau c
create proc LuuTru(@tencty nvarchar(20))
as
begin
	if (not exists(select TenCT from CongTy where TenCT = @tencty))
		print 'CONG TY ' + @tencty + ' KHONG TON TAI'
	else
		declare @table table(macty char(10), tencty nvarchar(20), masp char(10))
		insert into @table
		select congty.MaCT, congty.TenCT, sanpham.MaSP
		from CongTy inner join CungUng on CongTy.MaCT = CungUng.MaCT
					inner join SanPham on CungUng.MaSP = SanPham.MaSP
	where TenCT = @tencty
end

