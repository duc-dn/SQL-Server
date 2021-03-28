use master 
go
create database QLISV
on primary 
(
	name = 'QLSV.dat',
	filename = 'C:\Users\Asus\OneDrive\Documents\SQL.mdf',
	size = 5MB,
	maxsize = 100MB,
	filegrowth = 10MB
)

log on
(
	name = 'QLSV.log',
	filename = 'C:\Users\Asus\OneDrive\Documents\SQL.ldf',
	size = 1MB,
	maxsize = 10MB,
	filegrowth = 10%
)
go
use QLSV
go

create table LOP(
	maLop varchar(20) not null primary key ,
	tenLop varchar(20) not null,
	phong varchar(20) not null,
)

create table SinhVien (
	maSV varchar(20) not null primary key,
	tenSV varchar(20) not null,
	maLop varchar(20) not null,
	foreign key (maLop) references LOP(maLop)
)

-- A: Tạo bảng CSDL
insert into LOP values ( '1', 'CD', '1')
insert into LOP values ( '2', 'DH', '2')
insert into LOP values ( '3', 'LT', '2')
insert into LOP values ( '4', 'CH', '4')

select * from LOP

insert into SinhVien values ( '1', 'A', '1')
insert into SinhVien values ( '2', 'B', '2')
insert into SinhVien values ( '3', 'C', '1')
insert into SinhVien values ( '4', 'D', '3')

select * from SinhVien




-- Câu 1:

create function ThongKe( @malop varchar(20) )
returns int as
begin 
	declare @soluong int 
	select @soluong = count(SinhVien.maSV) 
	from SinhVien,LOP
	where SinhVien.maLop = LOP.maLop  and LOP.maLop = @maLop
	Group by LOP.tenLop
	return @soluong
end

create function thongke22(@malop int)
returns int
as
begin
	declare @sl int
	select @sl=count(*)
	from SinhVien 
	where SinhVien.MaLop =@malop
	return @sl
end;

select dbo.ThongKe('1')
select dbo.thongke22('1')

-- Câu 2:

create function cau2_c1(@tenLop varchar(20))
returns table 
return (
	select SinhVien.maSV, SinhVien.tenSV  
	from  SinhVien inner join LOP on  LOP.maLop = SinhVien.maLop
	where LOP.tenLop = @tenLop
	group by SinhVien.maSV, SinhVien.tenSV 
)

select * from dbo.cau2_c1('CD')

create function cau2_c2(@TenLop nvarchar(20))
returns @DS table (MaSV nvarchar(20),TenSV nvarchar(20))
as
begin
	insert into @DS
		select SinhVien.MaSV,SinhVien.TenSV
		from SinhVien inner join LOP on SinhVien.MaLop=LOP.MaLop
		where LOP.TenLop=@TenLop
		group by SinhVien.MaSV,SinhVien.TenSV
return 
end

select * from dbo.cau2_c2('CD')

/*Đưa ra hàm thống kê sinhvien: malop,tenlop,soluong sinh viên trong lớp, với tên lớp
được nhập từ bàn phím. Nếu lớp đó chưa tồn tại thì thống kê tất cả các lớp, ngược lại nếu
lớp đó đã tồn tại thì chỉ thống kê mỗi lớp đó.*/

create function ThongKeSV(@tenLop nvarchar(20))
returns @ThongKeSV table (maLop varchar(20), tenLop varchar(20), soluongSV int)
as
begin 
	if(not exists(select maLop from LOP where tenLop = @tenLop))
		insert into @ThongKeSV
		select LOP.maLop, LOP.tenLop, count(SinhVien.maSV)
		from LOP inner join SinhVien on LOP.maLop = SinhVien.maLop
		group by LOP.maLop, LOP.tenLop
	else
		insert into @ThongKeSV
		select LOP.maLop, LOP.tenLop, COUNT(SinhVien.maSV)
		from LOP inner join SinhVien on LOP.maLop = SinhVien.maSV
		where LOP.tenLop = @tenLop
		group by LOP.maLop, LOP.tenLop
		
	return 
end

select * from dbo.ThongKeSV('TIN1')

-- Câu 4: . Đưa ra phòng học của tên sinh viên nhập từ bàn phím.
create function cau4_c1(@tenSV varchar(20))
returns int as
begin 
	declare @tenPhong varchar(20)
	select @tenPhong = LOP.phong
	from LOP inner join SinhVien on SinhVien.maLop = LOP.maLop
	group by LOP.phong
	return @tenPhong
end

select dbo.cau4_c1('A')

--Câu 5:

create function Cau5(@phong varchar(20))
returns @cau5 table(maSV varchar(20), tenSV varchar(20), tenLop varchar(20))
as 
begin
	if(not exists(select phong from LOP where phong = @phong))
		insert into @cau5
		select SinhVien.maSV, SinhVien.tenSV, LOP.tenLop
		from SinhVien inner join LOP on SinhVien.maLop = LOP.maLop
		group by  SinhVien.maSV, SinhVien.tenSV, LOP.tenLop
	else 
		insert into @cau5
		select SinhVien.maSV, SinhVien.tenSV, LOP.tenLop
		from SinhVien inner join LOP on SinhVien.maLop = LOP.maLop
		where LOP.phong = @phong
	return
end 

select * from dbo.cau5('2')

-- Cau6
create function Cau6(@phong varchar(20))
returns int
as
	begin
		if(not exists(select phong from LOP where phong = @phong))
			return 0
		else 
			declare @soluong int
			select @soluong = count(LOP.maLop)
			from LOP
			where LOP.phong = @phong
			group by LOP.phong
			return @soluong
	end

select dbo.Cau6('6')