CREATE DATABASE QL
USE QL

CREATE TABLE KHOA
(
MAKHOA CHAR(10) PRIMARY KEY NOT NULL, 
TENKHOA NVARCHAR(20) NOT NULL,
DIENTHOAI CHAR(15) NOT NULL
)

CREATE TABLE LOP
(
MALOP CHAR(10) NOT NULL PRIMARY KEY,
TENLOP CHAR(10) NOT NULL,
KHOA NVARCHAR(20) NOT NULL,
HEDT NVARCHAR(20) NOT NULL,
NAMNH INT NOT NULL,
MAKHOA CHAR(10) NOT NULL,
CONSTRAINT FK1 FOREIGN KEY(MAKHOA) REFERENCES KHOA(MAKHOA)
)

INSERT INTO KHOA VALUES
('CNTT', 'CNTT', '0913504677'),
('KT', 'KE TOAN', '01679587704'),
('QTKD', 'KINH DOANH', '0912504677')

INSERT INTO LOP VALUES
('CNTT5', '05', N'CÔNG NGHỆ THÔNG TIN', 'TIẾN SĨ', 2019, 'CNTT'),
('KT2', '02', N'KẾ TOÁN', 'THẠC SĨ', 2018, 'KT'),
('QTKD1', '03', N'KINH DOANH', 'CỬ NHÂN', 2016, 'QTKD')


CREATE PROC SP_NHAPLOP(@MALOP CHAR(10), @TENLOP CHAR(10), @KHOA NVARCHAR(20), @HEDT NVARCHAR(20), @NAMNH INT, @MAKHOA CHAR(10), @KQ INT OUTPUT)
AS
BEGIN
	IF (EXISTS(SELECT * FROM LOP WHERE TENLOP = @TENLOP))
		SET @KQ = 0
	ELSE 
		IF (NOT EXISTS(SELECT * FROM KHOA WHERE KHOA.MAKHOA = @MAKHOA))
			SET @KQ = 1
		ELSE
			BEGIN
				INSERT INTO LOP VALUES(@MALOP, @TENLOP, @KHOA, @HEDT, @NAMNH, @MAKHOA)
				SET @KQ = 2	
			END
	RETURN @KQ
END

DECLARE @LOI INT
EXEC SP_NHAPLOP 'CNTTD', '07', 'CNTT', 'TIEN SI', 2019, 'CNTP', @LOI OUTPUT
SELECT @LOI


SELECT * FROM LOP

----------------------------------------------------------------------------------
--câu 3
Create proc sp_nhapkhoa3(@makhoa int,@tenkhoa nvarchar(20),
@dienthoai nvarchar(12),@kq int output)
as
begin
if(exists(select * from khoa where tenkhoa=@tenkhoa))
set @kq=03
else
insert into khoa values(@makhoa,@tenkhoa,@dienthoai)
return @kq
end
--Gọi thủ tục
DECLARE @LOI INT
EXEC SP_NHAPKHOA3 '8','CNTT','12356',@LOI OUTPUT
SELECT @LOI

SELECT * FROM KHOA

-----------------------------------------------------------
--câu 2
Create proc sp_nhaplop1(@malop int,@tenlop nvarchar(20),
@khoa int,@hedt nvarchar(20),
@namnhaphoc int, @makhoa int)
as
begin
if(exists(select * from lop where tenlop=@tenlop))
print 'lop da ton tai'
else
if(not exists(select * from khoa where makhoa=@makhoa))
print 'khoa nay chua ton tai'
else
insert into lop
values(@malop,@tenlop,@khoa,@hedt,@namnhaphoc,@makhoa)
end
--Gọi thủ tục
SELECT * FROM LOP
SELECT * FROM khoa


-------------------------------------------------
-- câu 1
Create proc sp_nhapkhoa2(@makhoa int,@tenkhoa nvarchar(20),
@dienthoai nvarchar(12))
as
begin
if(exists(select * from khoa where tenkhoa=@tenkhoa))
print 'ten khoa ' + @tenkhoa + 'da ton tai'
else
insert into khoa values(@makhoa,@tenkhoa,@dienthoai)
end
--Gọi thủ tục:
SELECT * FROM khoa
exec sp_nhapkhoa2 12, 'KE TOAN 1', '1234324'
