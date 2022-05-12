CREATE DATABASE QLKTX2022B;
USE QLKTX2022B;

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

insert into NhanVien values ('1-A1', N'Nguyễn Văn Khanh', '2002-5-12',N'Nam', '0902882339');
insert into NhanVien values ('1-A2', N'Phạm Dương Khanh', '2002-6-14',N'Nữ', '0904589089');
insert into NhanVien values ('1-A3', N'Trần Việt Hoàng', '2002-4-2',N'Nam', '0387697336');
insert into NhanVien values ('1-A4', N'Nguyễn Triều Đinh', '2001-5-6',N'Nam', '0965654657');
insert into NhanVien values ('1-A5', N'Lương Thị Linh', '1999-5-12',N'Nữ', '03876547828');
insert into NhanVien values ('1-B1', N'Nguyễn Vân Anh', '2001-6-13',N'Nữ', '09895824284');
insert into NhanVien values ('1-B2', N'Bùi Đức Anh', '2002-6-1',N'Nam', '0904827248');
insert into NhanVien values ('1-B3', N'Nguyễn Vân Trang', '2002-5-2',N'Nữ', '0984567469');
insert into NhanVien values ('1-B4', N'Nguyễn Văn Khanh', '2002-5-12',N'Nam', '0902882339');
insert into NhanVien values ('1-B5', N'Nguyễn Văn Khang', '2002-6-12',N'Nam', '0902882339');

insert into SinhVien values ('SV1', N'TRẦN VĂN AN','CNTT62A', N'K62' ,'2002-5-12',N'NAM');
insert into SinhVien values ('SV2', N'TRẦN THÁI HÀ','CNTT62A',N'K61' ,'2002-1-12',N'NAM');
insert into SinhVien values ('SV3', N'TRẦN THANH TÂM','CNTT62B' ,N'K62','2002-12-15', N'NỮ');
insert into SinhVien values ('SV4', N'TRINH QUỐC NAM', 'CNTT62B',N'K59', '2002-12-15',N'NAM');
insert into SinhVien values ('SV5', N'NGUYỄN THANH HÀ','CNTT62A',N'K62','2002-6-21',  N'NỮ');
insert into SinhVien values ('SV6', N'TRẦN VĂN AN','CNTT62A', N'K62' ,'2002-5-12',N'NAM');
insert into SinhVien values ('SV7', N'TRẦN THÁI HÀ','CNTT62A',N'K61' ,'2002-1-12',N'NAM');
insert into SinhVien values ('SV8', N'TRẦN THANH TÂM','CNTT62B' ,N'K62','2002-12-15', N'NỮ');
insert into SinhVien values ('SV9', N'TRINH QUỐC NAM', 'CNTT62B',N'K59', '2002-12-15',N'NAM');
insert into SinhVien values ('SV10', N'NGUYỄN THANH HÀ','CNTT62A',N'K62','2002-6-21',  N'NỮ');

insert into NhaKTX values('NHA1',N'NHÀ 1','1-A1',5);
insert into NhaKTX values('NHA2',N'NHÀ 2','1-A2',4);
insert into NhaKTX values('NHA3',N'NHÀ 3','1-A3',5);
insert into NhaKTX values('NHA4',N'NHÀ 4','1-A4',2);
insert into NhaKTX values('NHA5',N'NHÀ 5','1-A5',1);
insert into NhaKTX values('NHA6',N'NHÀ 6','1-B1',5);
insert into NhaKTX values('NHA7',N'NHÀ 7','1-B2',4);
insert into NhaKTX values('NHA8',N'NHÀ 8','1-B3',3);
insert into NhaKTX values('NHA7',N'NHÀ 9','1-B4',2);
insert into NhaKTX values('NHA8',N'NHÀ 10','1-B5',1);

insert into PhongO values('P11','NHA1',4);
insert into PhongO values('P12','NHA1',4);
insert into PhongO values('P13','NHA1',4);
insert into PhongO values('P14','NHA1',4);
insert into PhongO values('P21','NHA2',4);
insert into PhongO values('P22','NHA2',3);
insert into PhongO values('P23','NHA2',5);
insert into PhongO values('P31','NHA3',8);
insert into PhongO values('P32','NHA3',4);
insert into PhongO values('P33','NHA3',5);
insert into PhongO values('P41','NHA4',4);
insert into PhongO values('P51','NHA5',7);
insert into PhongO values('P52','NHA5',6);
insert into PhongO values('P61','NHA6',9);
insert into PhongO values('P62','NHA6',4);
insert into PhongO values('P71','NHA7',6);
insert into PhongO values('P72','NHA7',10);
insert into PhongO values('P81','NHA8',7);
insert into PhongO values('P82','NHA8',7);
insert into PhongO values('P91','NHA9',7);
insert into PhongO values('P92','NHA9',8);
insert into PhongO values('P101','NHA10',9);
insert into PhongO values('P102','NHA10',4);

insert into PhanPhongO values(2020,'P11','SV1','2020-01-01','2021-12-31');
insert into PhanPhongO values(2020,'P81','SV2','2020-01-01','2020-12-31');
insert into PhanPhongO values(2020,'P22','SV3','2020-01-01','2022-04-20');
insert into PhanPhongO values(2020,'P32','SV4','2020-01-01','2020-08-30');
insert into PhanPhongO values(2020,'P51','SV5','2020-01-01','2021-12-31');
insert into PhanPhongO values(2020,'P82','SV6','2020-01-01','2021-12-31');

select * from PhanPhongO;
select * from PhongO;
select * from NhanVien;
select * from NhaKTX;
select * from SinhVien;