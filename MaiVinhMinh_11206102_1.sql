create database MaiVinhMinh_11206102_1
use MaiVinhMinh_11206102_1


create table Khachhang (
	Makhach char(10) not null primary key,
	Tenkhach nvarchar(50),
	Diachi nvarchar(100),
	Dienthoai char(10),
	SoCMND char(12) unique
)

create table Loaitien (
	Maloai char(10) not null primary key,
	Loaitien nvarchar(50)
)

create table Laisuat (
	Maloai char(10),
	Makyhan char(10),
	Laisuat real,
	primary key(Makyhan, Maloai)
)

alter table Sotietkiem(
	Soso int primary key,
	Makhach char(10) references Khachhang(Makhach),
	Sotien money,
	Ngaygui date,
	Ngaydenhan date null,
	Ngayrut date null,
	Makyhan char(10),
	Maloai char(10),
	foreign key (Makyhan, Maloai) references Laisuat(Makyhan, Maloai)
)

exec sp_help Khachhang
insert into Khachhang values ('K01', N'Mai Vĩnh Minh', N'131 Lê Trọng Tấn, Hà Nội', '0934646077', '001202010236'),
							 ('K02', N'Trần Nhật Tiến', N'31 Phố Vọng, Hà Nội', '0954676067', '001202010237'),
							 ('K03', N'Lã Râu Trắng', N'22 Trường Chinh, Hà Nội', '0334045071', '001202010238'),
							 ('K04', N'Minh Râu Đen', N'13 Đào Trọng, Tuyên Quang', '0334443577', '001202010239'),
							 ('K05', N'Chúa Tể Sừng', N'56 Vũ Khánh Toàn, Hải Phòng', '0634746877', '001202010210')

select * from Khachhang;

exec sp_help Loaitien

insert into Loaitien values ('L01', N'Tiền gửi góp'),
							('L02', N'Tiền gửi định kì')

select * from Loaitien

exec sp_help Laisuat

insert into Laisuat values ('L01', 'KI01', 0.04),
						   ('L02', 'KI02', 0.05),
						   ('L01', 'KI03', 0.02),
						   ('L02', 'KI04', 0.01)

exec sp_help Sotietkiem

insert into Sotietkiem values (1, 'K01', 12000000, '03/12/2020', '04/21/2002', ),