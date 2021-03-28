create database QLSV
go

create table Lop
(
Malop char(5) not null primary key,
TenLop char(10) not null,
Phong char(5) not null
)

create table SinhVien
(
MaSV char(5) not null primary key,
TenSV char(10) not null,
MaLop char(5) not null,
constraint fk_MaLop foreign key(MaLop) references Lop(MaLop)
)

insert into LOP values ( '1', 'CD', '1')
insert into LOP values ( '2', 'DH', '2')
insert into LOP values ( '3', 'LT', '2')
insert into LOP values ( '4', 'CH', '4')



insert into SinhVien values ( '1', 'A', '1')
insert into SinhVien values ( '2', 'B', '2')
insert into SinhVien values ( '3', 'C', '1')
insert into SinhVien values ( '4', 'D', '3')


-- Cau1
create function Cau1(@malop char(5))
returns int
as
begin 
	declare @sl int
	select @sl = count(SinhVien.MaSV)
	from SinhVien inner join Lop
	on SinhVien.MaLop = Lop.Malop
	where lop.Malop = @malop
	group by lop.Malop
	return @sl
end

select dbo.cau1('1')

-- Cau 2
create function Cau2(@tenlop char(10))
returns @danhsach table (masv char(5), tensv char(10))
as
begin
	insert into @danhsach
	select MaSV, TenSV
	from SinhVien inner join lop
	on SinhVien.MaLop = lop.Malop
	where TenLop = @tenlop
	return
end

select * from dbo.Cau2('CD')

-- Cau 4
create function Cau4(@tensv char(10))
returns char(10)
as
begin
	declare @tenphong char(10)
	select @tenphong = Lop.Phong
	from SinhVien inner join Lop
	on SinhVien.MaLop = Lop.Malop
	where TenSV = @tensv
	return @tenphong
end

select dbo.cau4('D')

-- Cau5
create function Cau5(@phong char(10))
returns @DS table (masv char(5), tensv char(10), tenlop char(5))
as
begin
	insert into @DS
	select MaSV, TenSV, TenLop
	from SinhVien inner join Lop
	on SinhVien.MaLop = Lop.Malop
	where lop.Phong = @phong
	return 
end

select * from dbo.cau5('2')

create function Cau5_1(@phong varchar(20))
returns @cau5 table(maSV varchar(20), tenSV varchar(20), tenLop varchar(20))
as 
begin
	if(not exists(select phong from LOP where phong = @phong))
		insert into @cau5
		select SinhVien.maSV, SinhVien.tenSV, LOP.tenLop
		from SinhVien inner join LOP on SinhVien.maLop = LOP.maLop
	else 
		insert into @cau5
		select SinhVien.maSV, SinhVien.tenSV, LOP.tenLop
		from SinhVien inner join LOP on SinhVien.maLop = LOP.maLop
		where LOP.phong = @phong
	return
end 

select * from dbo.Cau5_1('5')

-- Cau 3
create function Cau3(@tenlop char(10))
returns @thongke table(malop char(10), tenlop char(10), slsv int)
as
begin
	if (not exists(select Malop from Lop where Lop.TenLop = @tenlop))
		insert into @thongke
		select lop.Malop,TenLop, count(SinhVien.MaSV)
		from SinhVien inner join Lop
		on SinhVien.MaLop = Lop.Malop
		group by lop.Malop, TenLop
	else
		insert into @thongke
		select lop.Malop,TenLop, count(SinhVien.MaSV)
		from SinhVien inner join Lop
		on SinhVien.MaLop = Lop.Malop
		where TenLop = @tenlop
		group by lop.Malop, TenLop	
		return
end

select * from dbo.Cau3('CX')

-- Cau6
create function Cau6(@phong char(10))
returns int
as
begin 
	if (not exists(select Phong from Lop where Lop.Phong = @phong))
		return 0
	else
		declare @sl int
		select @sl = count(lop.Malop)
		from Lop
		where lop.Phong = @phong
		group by lop.Phong
		return @sl
end

select dbo.cau6('4')
	