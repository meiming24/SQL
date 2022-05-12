create database KyTucXa2022
use KyTucXa2022 

create table NhanVien(
maNV char(10) primary key,
hoTen nchar(40) not null,
ngaySinh date not null,
gioiTinh nchar(3),
dienThoai char(12))



create table NhaKTX(
maNha char(10) primary key,
tenNha nchar(32) not null,
maNV char(10) references NhanVien(maNV),
soLuongPhong int check(soLuongPhong >= 0))



create table PhongO(
maPhong char(10) primary key,
maNha char(10) references NhaKTX(maNha),
soLuongCho int check(soLuongCho>=0))



create table SinhVien(
maSV char(10) primary key,
hoTen nchar(40) not null,
lop nchar(60),
khoa nchar(60),
ngaySinh date not null,
gioiTinh bit)

create table PhanPhongO(
namHoc int check(namHoc>0),
maPhong char(10) references PhongO(maPhong),
maSV char(10) references SinhVien(maSV),
tuNgay date,
denNgay date)

INSERT INTO NhanVien values ('nv1',N'Trần Văn B','1990-2-15',N'Nam',0), ('nv2',N'Trần Văn B','1990-2-15',N'Nam',0),('nv3',N'Nguyễn Văn C','1990-3-25',N'Nam',0)
,('nv4',N'Nguyễn Thị D','1995-4-20',N'Nữ',0),('nv5',N'Mai Thanh E','1990-5-19',N'Nữ',0)

insert into SinhVien values ('sv1',N'Trần Văn G','CNTT62A','K62','2002-2-10',1), ('sv2',N'Trần Văn G','CNTT62A','K62','2002-2-10',1),
('sv3',N'Nguyễn Thị H','CNTT62A','K62','2002-3-15',0),('sv4',N'Hoàng Hồng I','CNTT62A','K62','2002-4-25',0),
('sv5',N'Trần Thanh K','CNTT62A','K62','2002-5-5',1),('sv6',N'Cao Thanh L','CNTT62B','K62','2002-6-12',0),
('sv7',N'Trần Cao M','CNTT62B','K62','2002-7-16',1),('sv8',N'Vũ Thanh N','CNTT62B','K62','2002-8-13',0),
('sv9',N'Trần Mạnh O','CNTT62B','K62','2002-9-21',1),('sv10',N'Nguyễn Thanh P','K62','CNTT62B','2002-7-2',0)

insert into NhaKTX values ('n1',N'Ký túc 1','nv1',10), ('n2',N'Ký túc 2','nv2',10), ('n3',N'Ký túc 3','nv3',10), ('n4',N'Ký túc 4','nv4',10),
 ('n5',N'Ký túc 5','nv5',10);

insert into PhongO values ('p1','n1',4), ('p2','n1',4),('p3','n1',4),('p4','n1',4),('p5','n1',4),('p6','n1',4),('p7','n1',4),('p8','n1',4),
('p9','n1',4),('p10','n1',4),('p21','n2',4),('p22','n2',4),('p23','n2',4),('p24','n2',4),('p25','n2',4),('p26','n2',4),('p27','n2',4),('p28','n2',4),
('p29','n2',4),('p210','n2',4),('p31','n3',4),('p32','n3',4),('p33','n3',4),('p34','n3',4),('p35','n3',4),('p36','n3',4),('p37','n3',4),('p38','n3',4),
('p39','n3',4),('p310','n3',4),('p41','n4',4),('p42','n4',4),('p43','n4',4),('p44','n4',4),('p45','n4',4),('p46','n4',4),('p47','n4',4),('p48','n4',4),
('p49','n4',4),('p410','n4',4);

insert into PhanPhongO values (2022,'p1','sv1','2022-1-1','2023-1-1'),(2022,'p1','sv2','2022-1-1','2023-1-1'),(2022,'p1','sv3','2022-1-1','2023-1-1'),
(2022,'p1','sv4','2022-1-1','2023-1-1'),(2022,'p2','sv5','2022-1-1','2023-1-1'),(2022,'p2','sv6','2022-1-1','2023-1-1'),(2022,'p2','sv7','2022-1-1','2023-1-1'),
(2022,'p2','sv8','2022-1-1','2023-1-1'),(2022,'p3','sv9','2022-1-1','2023-1-1'),(2022,'p3','sv10','2022-1-1','2023-1-1');

select * from NhanVien
select * from SinhVien
select * from NhaKTX
select * from PhongO 
select * from PhanPhongO

create view v_PhongO
as
select SinhVien.maSV, SinhVien.hoTen, SinhVien.lop, SinhVien.khoa, SinhVien.ngaySinh, SinhVien.gioiTinh, PhongO.maPhong, PhongO.maNha
from PhanPhongO, PhongO, SinhVien
where PhanPhongO.maPhong = PhongO.maPhong and PhanPhongO.maSV = SinhVien.maSV

drop view v_PhongO
select * from v_PhongO

create PROC THEMSV @maSV char(10) ,@hoTen nchar(80),@lop nchar(120),@khoa nchar(120),@ngaySinh date,@gioiTinh bit
as
begin
	if (exists(select maSV from SinhVien where maSV=@maSV))
		print N'Sinh viên đã tồn tại, không thể thêm.'
	else
		insert into SinhVien values (@maSV,@hoTen,@lop,@khoa,@ngaySinh,@gioiTinh)
end

select * from SinhVien
exec THEMSV 'sv27','Huyền Võ', 'CNTT62A', 'CNTTKT','05/07/2002',0