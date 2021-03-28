create table Sach
(
	Tensach nvarchar(30),
	Masach int
);

insert into Sach values
('Mắt Bão', 2),
('Giông Bão Táp', 4),
('Mắt biếc', 5),
('Tôi yêu em', 6),
('Bão lớn', 7),
('Bé Bão', 8);

select Tensach
from Sach
where Tensach like '%Bão%';

create table CTPN
(
	SoPN int, 
	TenSach nvarchar(30),
	TheLoai nvarchar(30)
);

insert into CTPN values
(1, 'Mắt biếc', 'Ngôn tình'),
(2, 'Chiếc lược ngà', 'Truyện ngắn'),
(3, 'Tôi yêu em', 'Tình cảm'),
(3, 'Anh thế giới và em', 'Ngôn tình'),
(1, 'Nhớ em', 'Chill');

select SoPN, TenSach
from CTPN

create table Mau
(
	SoLuong int,
	Gia float,
	Mau nvarchar(20)
);

insert into Mau values
(10, 30000, 'Vàng'),
(20, 2000, 'Đỏ'),
(1, 3, 'Xanh'),
(1, 4, 'Cam'),
(2, 4, 'Tím'),
(4, 3, 'Đỏ');

select SoLuong, Gia
from Mau 
where Mau = 'Đỏ' or Mau = 'Xanh' or Mau = 'Vàng';


create table Hang
(
	MaHang int,
	Mau nvarchar(20),
	TenHang nvarchar(30),
	SlCo int
);

insert into Hang values
(1, 'Xanh','LapTop', 20),
(2, 'Đỏ','BimBim', 30),
(3, 'Đỏ', 'Xôi', 40),
(4, 'Đỏ', 'Gấc', 20);

select TenHang, SlCo
from Hang
where Mau = 'Đỏ'
order by SlCo ASC