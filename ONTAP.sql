﻿CREATE DATABASE QLTHUOC1
USE QLTHUOC1

GO

CREATE TABLE NSX
(
MANSX CHAR(10) NOT NULL PRIMARY KEY,
TENNSX NVARCHAR(20) NOT NULL, 
DC NVARCHAR(20) NOT NULL,
DT CHAR(12) NOT NULL
)


CREATE TABLE THUOC
(
MATHUOC CHAR(10) NOT NULL PRIMARY KEY,
TENTHUOC NVARCHAR(20) NOT NULL,
SLCO INT NOT NULL, 
SOLO INT NOT NULL,
NGAYSX DATETIME NOT NULL,
HANSD DATETIME NOT NULL,
MANSX CHAR(10) NOT NULL,
CONSTRAINT FK1 FOREIGN KEY(MANSX) REFERENCES NSX(MANSX)
)

CREATE TABLE PN
(
SOPN CHAR(10) NOT NULL, 
MATHUOC CHAR(10) NOT NULL, 
NGAYNHAP DATETIME NOT NULL, 
SOLUONG INT NOT NULL,
DONGIA INT NOT NULL,
PRIMARY KEY(SOPN, MATHUOC),
CONSTRAINT FK2 FOREIGN KEY(MATHUOC) REFERENCES THUOC(MATHUOC)
)


INSERT INTO NSX VALUES
('N1', 'NSX1', N'HÀ NỘI', '0000000'),
('N2', 'NSX2', N'HÀ NAM', '111111'),
('N3', 'NSX3', N'NAM ĐỊNH', '222222'),
('N4', 'NSX4', N'HÀ GIANG', '333333')


INSERT INTO THUOC VALUES 
('T1', 'THUOC1', 22, 1, '3/22/2021', '5/22/2021', 'N1'),
('T2', 'THUOC2', 10, 1, '6/21/2021', '10/21/2021', 'N2'),
('T3', 'THUOC3', 11, 3, '2/25/2021', '10/25/2021', 'N3'),
('T4', 'THUOC4', 12, 2, '1/22/2021', '9/22/2021', 'N4')

INSERT INTO PN VALUES
('PN1', 'T1', '3/30/2021', 200, 30000),
('PN2', 'T1', '3/28/2021', 100, 21000),
('PN3', 'T2', '6/22/2021', 150, 25000),
('PN4', 'T3', '2/27/2021', 120, 22000),
('PN5', 'T4', '2/22/2021', 130, 24000),
('PN6', 'T2', '6/23/2021', 135, 14000)

SELECT * FROM NSX
SELECT * FROM THUOC
SELECT * FROM PN


CREATE FUNCTION TINHTONG(@MATHUOC CHAR(10))
RETURNS INT
AS
BEGIN
	DECLARE @TONG INT
	SELECT @TONG = SUM(SOLUONG) 
	FROM PN
	WHERE PN.MATHUOC = @MATHUOC
	GROUP BY MATHUOC
	RETURN @TONG
END

SELECT DBO.TINHTONG('T1')


CREATE PROC THEM(@MANSX CHAR(10), @TENNSX NVARCHAR(20), @DC NVARCHAR(20), @DT CHAR(12))
AS
BEGIN
	IF (EXISTS(SELECT * FROM NSX WHERE MANSX = @MANSX))
		PRINT(@MANSX + ' DA TON TAI')
	ELSE
		INSERT INTO NSX VALUES (@MANSX, @TENNSX, @DC, @DT)
END

EXEC THEM 'N5', 'NSX5', N'CÀ MAU', '999999'
SELECT * FROM NSX


ALTER PROC SEARCH(@MATHUOC CHAR(10))
AS
BEGIN
	IF (EXISTS (SELECT * FROM THUOC WHERE MATHUOC = @MATHUOC))
		BEGIN
			PRINT(@MATHUOC + 'DA TON TAI')
			SELECT * FROM THUOC
			WHERE MATHUOC = @MATHUOC
		END
	ELSE
		PRINT(@MATHUOC + 'KHONG TON TAI')
END

EXEC SEARCH 'T1'
