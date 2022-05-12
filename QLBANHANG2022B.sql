create database QLBANHANG2022B
use QLBANHANG2022B
drop database QLBANHANG2022B;


create table DMHANGHOA(
	MaHang char(10) not null primary key,
	TenHang nchar(50) not null,
	Soluongton int not null,
	Dongia int
);

create table HANGBAN(
	MaBan char(10) not null primary key,
	MaHang char(10) references DMHANGHOA(MaHang),
	NgayBan datetime,
	NguoiBan char(50),
	Soluongban int not null, 
	thanhtien int
);

insert into DMHANGHOA values('HH1','Bia 33', 200, 100)
insert into DMHANGHOA values('HH2','Bia HN', 600, 150)
insert into DMHANGHOA values('HH3','Ruou 123', 200, 40)
insert into DMHANGHOA values('HH4','Coca Cola 1', 30, 10)
insert into DMHANGHOA values('HH5','Nuoc ngot 1', 400, 50)

insert into HANGBAN values('MB1','HH1','12/12/2020',' Hong',20,0)
insert into HANGBAN values('MB2','HH2','11/12/2020',' Ha',20,0)
insert into HANGBAN values('MB3','HH2','12/15/2020',' Nga',10,0)
insert into HANGBAN values('MB4','HH3','10/12/2020',' Minh',20,0)
insert into HANGBAN values('MB5','HH1','09/12/2020',' Hung',30,0)

Select * from DMHANGHOA
Select * from HANGBAN

update HANGBAN set thanhtien = Soluongban * Dongia from HANGBAN, DMHANGHOA where DMHANGHOA.MaHang = HANGBAN.MaHang 

create trigger trg_Dathang on Hangban after insert 
as
begin 
	update DMHANGHOA set Soluongton = Soluongton - (select Soluongban from inserted where inserted.MaHang = DMHANGHOA.MaHang)
	from DMHANGHOA, inserted where inserted.MaHang = DMHANGHOA.MaHang

	update HANGBAN set thanhtien = Soluongban * Dongia from DMHANGHOA, HANGBAN where DMHANGHOA.MaHang = HANGBAN.MaHang
end
go

insert into HANGBAN values ('MB6','HH1','09/12/2020',' Hung',50,0)

--- Cập nhật số lượng
/* cập nhật hàng trong kho sau khi cập nhật đặt hàng */
CREATE TRIGGER trg_CapNhatDatHang on HANGBAN AFTER UPDATE
AS
BEGIN
   UPDATE DMHANGHOA SET SoLuongTon = SoLuongTon -
	   (SELECT SoLuongban FROM inserted WHERE MaHang = DMHANGHOA.MaHang) +
	   (SELECT SoLuongban FROM deleted WHERE MaHang = DMHANGHOA.MaHang)
   FROM DMHANGHOA,deleted WHERE DMHANGHOA.MaHang = deleted.MaHang

UPDATE HANGBAN set thanhtien = Soluongban* Dongia 
From DMHANGHOA,HANGBAN WHERE DMHANGHOA.MaHang = HANGBAN.MaHang
end
GO

Select * from HANGBAN
Update HANGBAN set Soluongban = 50 FROM HANGBAN WHERE MaBan = 'MB1'
Select * from DMHANGHOA

DISABLE TRIGGER ALL ON HANGBAN
ENABLE TRIGGER ALL ON HANGBAN

DISABLE TRIGGER trg_CapNhatDatHang ON HANGBAN
ENABLE TRIGGER trg_CapNhatDatHang ON HANGBAN

DISABLE TRIGGER trg_DatHang ON HANGBAN
ENABLE TRIGGER trg_DatHang ON HANGBAN

DISABLE TRIGGER trg_HuyDatHang ON HANGBAN
ENABLE TRIGGER trg_HuyDatHang ON HANGBAN

-- HỦY BÁN HÀNG

CREATE TRIGGER trg_HuyDatHang ON HANGBAN FOR DELETE AS 
BEGIN
	UPDATE DMHANGHOA
	      SET SoLuongTon = SoLuongTon + (SELECT SoLuongban FROM deleted WHERE MaHang = DMHANGHOA.MaHang)
	FROM DMHANGHOA, deleted WHERE  DMHANGHOA.MaHang = deleted.MaHang
END
GO
Select * FROM DMHANGHOA
Select * from HANGBAN
DELETE FROM HANGBAN WHERE MaBan = 'MB77'
-- Viết thủ tục thêm hàng hóa mới chưa có trong danh mục
ALTER PROC SP_DMHANGHOA @MaHang char(10), @TenHang nvarchar(30), @Soluong int, @Dongia int
AS
	if exists (select * from DMHANGHOA where MaHang= @MaHang)
		Print N'Thông báo: Mã hàng này đã có trong Hệ thống'
	else 
	INSERT INTO DMHANGHOA VALUES(@MaHang,@TenHang,@Soluong,@Dongia)
GO

EXEC SP_DMHANGHOA 'HH7','Bia 77',100,200
SELECT  * FROM DMHANGHOA;

-- Cập nhật thêm số lượng hàng hóa đã có trong danh mục
CREATE PROC SP_DMHANGHOA_SL @MaHang char(10), @Soluong int
AS
	if exists (select * from DMHANGHOA where MaHang= @MaHang)
	Update DMHANGHOA SET Soluongton = Soluongton + @Soluong WHERE MaHang= @MaHang
	else
	Print N'Thông báo: Mã hàng chưa có trong danh mục'
GO

EXEC SP_DMHANGHOA_SL 'HH7',200
SELECT  * FROM DMHANGHOA;

--- Viết thủ tục Bán hàng - Kiểm tra số lượng tồn có trong danh mục
CREATE PROC SP_HANGBAN @MaBan char(10), @MaHang char(10),@Ngayban datetime,@NguoiBan Char(50), @Soluong int
AS
	if exists (SELECT * FROM HANGBAN where MaBan= @MaBan)
		Print N'Thông báo: Mã bán hàng này đã có'
	else 
		if not exists (SELECT * FROM DMHANGHOA where MaHang= @Mahang)
		Print N'Thông báo: Mã hàng này chưa có trong danh mục'
		else 
		if exists (SELECT MaHang, Soluongton FROM DMHANGHOA WHERE MaHang= @Mahang and Soluongton < @Soluong)
		Print N'Thông báo: Số lượng mặt hàng này không đủ để bán'
		else 	
 insert into HANGBAN (Maban,MaHang,Ngayban,Nguoiban,Soluongban) values(@MaBan,@MaHang,@Ngayban,@NguoiBan,@Soluong)
GO

EXEC SP_HANGBAN 'MB77','HH1','09/12/2020',' Ngoc',30
