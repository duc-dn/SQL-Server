create function FN_THONGKEKHOA(@TenKhoa nvarchar(20)
returns int
as
	begin
		declare @Tong int
		select @Tong = count(*) from lop inner join Khoa
		on lop.makhoa = khoa.makhoa
		where  tenkhoa = @tenkhoa
		return @tong
	end

select dbo.FN_THONGKEKHOA('DTVT')