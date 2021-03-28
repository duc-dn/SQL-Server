create database QlBanHang;

create table VATTU
(
MaVTU char(4) not null primary key,
TenVTu nvarchar(100) not null,
DvTinh nvarchar(10) not null,
PhanTram real not null
);

create table NHACC
(
MaNhaCc char(3) primary key not null,
TenNhaCc nvarchar(100) not null,
DiaChi nvarchar(200) not null,
DienThoai varchar(20) not null
);

create table DONDH
(
SoDh char(4) primary key not null,
NgayDh datetime not null,
MaNhaCc char(3) not null foreign key references NHACC(MaNhaCc) on delete cascade on update cascade
);

create table CTDONDH
(
SoDh char(4) not null,
MaVTu char(4) not null,
SlDat int not null,
constraint pk1 primary key(SoDh, MaVTu),
constraint fk1 foreign key(MaVTu) references VATTU(MaVTu),
foreign key(SoDh) references DONDH(SoDh) on delete cascade on update cascade
);

create table PNhap
(
SoPn char(4) not null primary key,
NgayNhap Datetime not null,
SoDh char(4) not null,
constraint fk2 foreign key(SoDh) references DONDH(SoDh) on delete cascade on update cascade
);

create table CTPNHAP
(
SoPn char(4) not null,
MaVTu char(4) not null, 
SlNhap Int not null,
DgNhap Money not null,
primary key(SoPn, MaVTu),
foreign key(MaVTu) references VATTU(MaVTu) on delete cascade on update cascade
);
alter table CTPNHAP add foreign key(SoPn) references PNhap(SoPn);

create table PXUAT
(
SoPx char(4) not null primary key,
NgayXuat Datetime not null,
TenKh nvarchar(100) not null
);

create table CTPXUAT
(
SoPx char(4) not null,
MaVTu char(4) not null,
SlXuat Int not null,
DgXuat money not null,
primary key(SoPx, MaVTu),
foreign key(SoPx) references PXuat(SoPx) on delete cascade on update cascade,
foreign key(MaVTu) references VATTU(MaVTu) on delete cascade on update cascade
);

create table TONKHO
(
NamThang char(6) not null,
MaVTu char(4) not null,
SLDau int not null,
TongSLN int not null,
TongSLX int not null,
SLCuoi int not null
primary key(NamThang, MaVTu),
foreign key(MaVTu) references VATTU(MaVTu) on delete cascade on update cascade
);
