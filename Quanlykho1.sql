create database QLKho1;
use QLKho1;

create table Ton
(
MaVT char(10) not null primary key,
TenVT char(30) not null,
SoLuongT int not null
);

create table Nhap
(
SoHDN char(10) not null,
MaVT char(10) not null,
SoLuongN int not null,
DonGiaN int not null,
NgayN datetime not null
primary key(SoHDN, MaVT),
foreign key(MaVT) references Ton(MaVT)
);

create table Xuat
(
SoHDX char(10) not null,
MaVT char(10) not null,
SoLuongX int not null,
DonGiaX int not null,
NgayX datetime not null,
primary key(SoHDX, MaVT),
foreign key(MaVT) references Ton(MaVT)
);

insert into Ton values 
('M01', N'Nhôm', 30),
('M02', N'Sắt', 20),
('M03', N'Đồng', 15),
('M04', N'Chì', 25),
('M05', N'Kẽm', 10);

insert into Nhap values
('N03', 'M05', 20, 200, '4/25/2002'),
('N04', 'M04', 20, 2300, '4/22/2001'),
('N01', 'M01', 20, 2300, '4/22/2020'),
('N02', 'M02', 23, 1400, '3/22/2001'),
('N01', 'M03', 22, 2500, '11/14/2001');

insert into Xuat values
('X01', 'M02', 20, 1300, '1/22/2000'),
('X01','M01', 15, 2000, '3/22/2021'),
('X02', 'M03', 10, 1500, '4/22/2002'),
('X02', 'M02', 13, 1800, '5/22/2003'),
('X03', 'M05', 14, 2000, '2/22/2004'),
('X01', 'M04', 12, 3000, '1/22/2005');


select * from Ton
select * from Nhap
select * from Xuat


create view cau2 
as
select ton.MaVT, TenVT, sum(SoLuongX * DonGiaX) as 'Tien ban'
from xuat inner join ton
on xuat.MaVT = ton.MaVT
group by ton.MaVT, TenVT

select * from cau2


create view cau3
as
select TenVT, sum(SoLuongX) as 'Tong SLX'
from ton inner join xuat
on ton.MaVT = Xuat.MaVT
group by TenVT

select * from cau3


CREATE VIEW CAU5
AS
select ton.mavt,ton.tenvt,sum(soluongN)-sum(soluongX) + sum(soluongT) as
tongton
from nhap inner join ton on nhap.mavt=ton.mavt
inner join xuat on ton.mavt=xuat.mavt
group by ton.mavt,ton.tenvt

select * from cau5