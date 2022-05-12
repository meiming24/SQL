create database QLKTX2022
use QLKTX2022

create table Nhanvien (
	Manv char(10) not null primary key,
	Hoten nvarchar(20) not null,
	Ngaysinh date not null,
	Gioitinh nvarchar(3) not null,
	Dienthoai char(10) not null
)

create table NhaKTX (
	Manha char(10) not null primary key,
	Tennha nvarchar(20) not null,
	Manv char(10) foreign key references Nhanvien(Manv),
	Soluongphong int
)

create table PhongO (
	Maphong char(10) not null primary key,
	Manha char(10) foreign key references NhaKTX(Manha),
	Soluongcho int
)

create table Sinhvien (
	Masv char(10) not null primary key,
	Hoten nvarchar(20) not null,
	Lop char(10) not null,
	Khoa nvarchar(20) not null,
	Ngaysinh date not null,
	Gioitinh nvarchar(3) not null
)

create table PhanphongO (
	Namhoc int,
	Maphong char(10) foreign key references PhongO(Maphong),
	Masv char(10) foreign key references Sinhvien(Masv),
	tungay date not null,
	denngay date not null
)

insert into Nhanvien values ('NV01', N'Mai Vĩnh Minh', '09/24/2002', 'Nam', '0934545066'),
							('NV02', N'Võ Thị Huyền', '02/17/2002', 'Nữ', '0356456789'),
							('NV03', N'Nguyễn Anh Tuấn', '03/21/1999', 'Nam', '0915647897');

insert into NhaKTX values ('N01', 'Nhà 01', 'NV01', 50),
						  ('N02', 'Nhà 02', 'NV02', 40),
						  ('N03', 'Nhà 03', 'NV03', 55);

insert into PhongO values ('P101', 'N01', 5),
						  ('P102', 'N01', 5),
						  ('P201', 'N02', 4),
						  ('P202', 'N02', 4),
						  ('P301', 'N03', 5),
						  ('P302', 'N03', 6);

insert into Sinhvien values ('SV01', N'Nguyễn Văn A', '62B', 'CNTT', '01/22/2002', 'Nam'),
							('SV02', N'Nguyễn Tiến Đạt', '62B', 'CNTT', '03/05/2002', 'Nam'),
							('SV03', N'Hà Thị Như', '61B', 'KHMT', '01/21/2002', 'Nữ'),
							('SV04', N'Đỗ Duy Mạnh', '62A', 'CNTT', '05/12/2002', 'Nam'),
							('SV05', N'Trần Quang Khải', '61B', 'KHMT', '07/02/2002', 'Nam'),
							('SV06', N'Tố Đức Duy', '61A', 'HTTTQL', '02/24/2002', 'Nam'),
							('SV07', N'Hồ Thị Ngân', '62B', 'CNTT', '03/14/2002', 'Nữ');

insert into PhanphongO values (2021, 'P101', 'SV01', '04/05/2021', '03/21/2024'),
							  (2021, 'P101', 'SV02', '04/05/2021', '03/21/2024'),
							  (2021, 'P102', 'SV03', '04/05/2021', '03/21/2024'),
							  (2021, 'P102', 'SV04', '04/05/2021', '03/21/2024'),
							  (2021, 'P201', 'SV05', '04/05/2021', '03/21/2024'),
							  (2021, 'P201', 'SV06', '04/05/2021', '03/21/2024'),
							  (2021, 'P301', 'SV07', '04/05/2021', '03/21/2024');

select * from Nhanvien
select * from NhaKTX
select * from PhongO
select * from Sinhvien
select * from PhanphongO

create proc sp_Themphong @Maphong char(10), @Manha char(10), @Soluongcho int
as
begin
	if not exists (select * from NhaKTX where Manha = @Manha)
		print 'Ma nha khong ton tai !!!'
	else 
		insert into PhongO values (@Maphong, @Manha, @Soluongcho)
end

exec sp_Themphong 'P303', 'N04', 7;

select Maphong, Masv from PhongO, Sinhvien

exec sp_help PhanphongO
create proc sp_Phanphongsv @Namhoc int, @Maphong char(10), @Masv char(10), @tungay date, @denngay date
as
begin
	if not exists (select Maphong, Masv from PhongO, Sinhvien where Maphong = @Maphong and Masv = @Masv)
		print N'Ma phong, ma sinh vien khong ton tai'
	else 
		declare @soluong int = (select count(Masv) from PhanphongO)
		declare @gt nvarchar(5) = (select distinct Gioitinh from Sinhvien where Masv in (select Masv from PhanphongO))
	if @soluong < (select Soluongcho from PhongO where Maphong = @Maphong)
		if @gt = (select Gioitinh from Sinhvien where Masv = @Masv)
			insert into PhanphongO values (@Namhoc, @Maphong, @Masv, @tungay, @denngay)
		else 
			print N'Phong nay danh cho người khac gioi'
	else 
		print N'Phong nay da du nguoi'
end

exec sp_Phanphongsv 

alter view v_PhongO
as
select Namhoc, Maphong, 
	   Sinhvien.Masv, 
	   Hoten, 
	   Lop, 
	   Khoa, 
	   Ngaysinh, 
	   Gioitinh,
	   tungay, denngay 
from PhanphongO, Sinhvien where PhanphongO.Masv = Sinhvien.Masv

select * from v_PhongO


alter proc sp_thongke5 @option int, @ma char(10), @so int
as 
begin
	if @option = 1
	begin
		select count(*) as Tongsophong from
		(select Maphong, count(Maphong) as Sosv from PhanphongO where Namhoc = @so group by Maphong) as a
		where a.Sosv < 15
	end

	if @option = 2
	begin 
		select ((select sum(Soluongcho) as Tongcho from PhongO where Manha = @ma) - (select count (*) as Tongchodao from PhanphongO, PhongO where PhanphongO.Maphong = PhongO.Maphong and PhongO.Manha = @ma)) as Sochocontrong
	end

end
