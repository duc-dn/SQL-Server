CREATE DATABASE QLNV
USE QLNV

CREATE TABLE CHUCVU
(
MACV NVARCHAR(2) NOT NULL PRIMARY KEY,
TENCV NVARCHAR(30) NOT NULL
)

CREATE TABLE NHANVIEN
(
MANV NVARCHAR(4) NOT NULL PRIMARY KEY,
MACV NVARCHAR(2) NOT NULL,
TENNV NVARCHAR(30) NOT NULL, 
NGAYSINH DATETIME NOT NULL,
LUONGCB FLOAT NOT NULL,
NGAYCONG INT NOT NULL,
PHUCAP FLOAT NOT NULL,
CONSTRAINT FK1 FOREIGN KEY(MACV) REFERENCES CHUCVU(MACV)
)

INSERT INTO CHUCVU VALUES
('BV', N'BẢO VỆ'),
('GD', N'GIÁM ĐỐC'),
('HC', N'HÀNH CHÍNH'),
('KT', N'KẾ TOÁN'),
('TQ', N'THỦ QUỸ'),
('VS', N'VỆ SINH')

INSERT INTO NHANVIEN VALUES
('NV01', 'GD', N'NGUYỄN VĂN AN', '12/12/1977', 70000, 25, 50000),
('NV02', 'BV', N'BÙI VĂN TÍ', '10/10/1978', 40000, 24, 10000),
('NV03', 'KT', N'TRẦN THANH NHẬT', '9/9/1977', 60000, 26, 40000),
('NV04', 'VS', N'NGUYỄN THỊ ÚT', '10/10/1980', 30000, 26, 30000),
('NV05', 'HC', N'LỆ THỊ HÀ', '10/10/1979', 50000, 27, 20000)

SELECT * FROM CHUCVU
SELECT * FROM NHANVIEN



------------------------------------------------
--- CÂU A
CREATE PROC SP_THEM_NHAN_VIEN(@MANV CHAR(10), @MACV CHAR(10), @TENNV NVARCHAR(20), @NGAYSINH DATETIME, @LUONGCB FLOAT, @NGAYCONG INT, @PHUCAP FLOAT)
AS
BEGIN
	IF (NOT EXISTS(SELECT * FROM CHUCVU WHERE MACV = @MACV))
		PRINT('MA CONG VIEC ' + @MACV + 'KHONG TON TAI')
	ELSE
		INSERT INTO NHANVIEN VALUES(@MANV, @MACV, @TENNV, @NGAYSINH, @LUONGCB, @NGAYCONG, @PHUCAP)
END

EXEC SP_THEM_NHAN_VIEN 'NV06', 'GD', N'ĐỖ NGỌC ĐỨC', '3/22/2001', 40000, 28, 60000


-----------------------------------------------------
---CÂU B
CREATE PROC SP_CAPNHAT_NHAN_VIEN(@MANV CHAR(10), @MACV CHAR(10), @TENNV NVARCHAR(20), @NGAYSINH DATETIME, @LUONGCB FLOAT, @NGAYCONG INT, @PHUCAP FLOAT)
AS
BEGIN
	IF (NOT EXISTS(SELECT * FROM CHUCVU WHERE MACV = @MACV))
		PRINT(@MACV + 'CHUA TON TAI TRONG BANG')
	ELSE
		UPDATE NHANVIEN SET TENNV = @TENNV, NGAYSINH = @NGAYSINH, LUONGCB = @LUONGCB, NGAYCONG = @NGAYCONG, PHUCAP = @PHUCAP
		WHERE MACV = @MACV
END

SELECT * FROM NHANVIEN
EXEC SP_CAPNHAT_NHAN_VIEN '', 'BV', N'ĐỖ NGỌC HOÀI', '11/14/2006', 35000, 20, 13000


--------------------------------------------------------
---CÂU C

CREATE PROC SP_LUONGLN
AS
BEGIN
	DECLARE @LUONG FLOAT
	SELECT @LUONG = SUM(LUONGCB * NGAYCONG + PHUCAP)
	FROM NHANVIEN
	GROUP BY MANV
	RETURN @LUONG
END

DECLARE @RESULT FLOAT
EXEC SP_LUONGLN
SELECT @RESULT


