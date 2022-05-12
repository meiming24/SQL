create database QL_HK2022;
use QL_HK2022;

create table HK (
	Makhach nvarchar(50),
	Tenkhach nvarchar(50),
	Diachi nvarchar(50),
	Dienthoai nvarchar(50),
	SCMT nvarchar(50),
	primary key (Makhach)
);
drop table HK

create table TB (
	MaTB nvarchar(50),
	Noidi nvarchar(50),
	Noiden nvarchar(50),
	Thoigian nvarchar(5),
	Giatien_1 bigint,
	Giatien_2 bigint,
	primary key (MaTB)
);
drop table TB


create table VB (
	Sove nvarchar(50) primary key,
	Makhach nvarchar(50),
	foreign key (Makhach) references HK (Makhach), 
	MaTB nvarchar(50)
	foreign key (MaTB) references TB (MaTB), 
	Loai char(3) check(loai = 'T' or loai = 'V') not null,
	Tinhtrang char(5) check(Tinhtrang = 'H' or Tinhtrang = 'T' or Tinhtrang = 'B') not null,
	Ngaydi date
);
drop table VB;


insert into HK 
values
	('A1','Mai Vinh Minh','Bac Tu Liem, Ha Noi','0934545066','001202012036'), 
	('A2','Edward Jonh','New York, USA','1982393876','001202012036'),
	('B1','Thomas Jefferson','Moscow, Russia','1986014825','001127238235'),
	('B2','Killin Wang','Chinatown, USA','1963266276','001440410529'),
	('C1','Bruce Wayne', 'Gotham, USA','1949972362','001060219770'),
	('C2','Wally West','Metropolis, USA','1997909673','001185338914'),
	('D1','Nema Kong','Rio, Brazil','1961438740','001337603526'),
	('D2','Thorson Gunther','Texas, USA','1939754719','001254896869'),
	('E1','Tony Stark','Last Vegas, USA','1980642192','001060593282'),
	('E2','Bruce Banner','Texas, USA','1997163539','001073736017');


insert into TB 
values
	('01','Ha Noi','Sai Gon','01:00',1000000, 1500000),
	('02','New York','Last Vegas','02:00',1200000, 2500000),
	('03','Moscow','Kiev','03:00',1300000, 1500000),
	('04','Chinatown','Thailand','24:00',1100000, 2000000),
	('05','New York','Sweden','13:00',1600000, 1700000),
	('06','Rio','Saint Peterburg','07:00',1800000, 1900000),
	('07','New York','London','03:00',2700000, 3500000),
	('08','Texas','Vien','05:00',1100000, 1500000);


insert into VB 
values 
	('VE01', 'A1', '01', 'T', 'B','2022-03-23'),
	('VE02', 'A2', '02', 'V', 'H','2022-03-02'),
	('VE03', 'B1', '03', 'V', 'B','2022-03-03'),
	('VE04', 'B2', '04', 'T', 'B','2022-02-03'),
	('VE05', 'C1', '05', 'T', 'T','2022-04-13'),
	('VE06', 'C2', '06', 'V', 'B','2022-03-05'),
	('VE07', 'D1', '07', 'T', 'B','2022-11-15'),
	('VE08', 'D2', '08', 'V', 'H','2022-02-26');	
	
select * from HK;
select * from TB;
select * from VB;

create view v_Bthg03_2022 as
select HK.Makhach, Tenkhach, Diachi, Dienthoai, SCMT, Tinhtrang 
from HK, VB
where HK.Makhach = VB.Makhach and VB.Tinhtrang = 'B' and month(VB.Ngaydi) = '03' and year(VB.Ngaydi) = '2022'

drop view v_Bthg03_2022

select * from v_Bthg03_2022

alter proc sp_themSoVe @Sove nvarchar(50), @Makhach nvarchar(50), @MaTB nvarchar(50), @Loai char(3), @Tinhtrang char(5), @Ngaydi date
as 
begin 
	if exists (select * from HK where Makhach = @Makhach)
		if exists (select * from TB where MaTB = @MaTB)
			if not exists (select * from VB where Sove = @Sove)
			begin 
				insert into VB(Sove, Makhach, MaTB, Loai, Tinhtrang, Ngaydi)
				values (@Sove, @Makhach, @MaTB, @Loai, @Tinhtrang, @Ngaydi)
				print N'Đã thêm vé thành công'
			end 
			else print N'Mã khách hàng ko valid'
		else print N'Mã tuyến bay ko valid'
	else print N'Số vé đã tồn tại'
end

exec sp_themSoVe 'VE09','E1','05','T','B','2022-03-05'

exec sp_help HK
create proc sp_themHanhKhach @Makhach nvarchar(100), @Tenkhach nvarchar(100), @Diachi nvarchar(100), @Dienthoai nvarchar(100), @SCMT nvarchar(100)
as
	begin
		if exists(select Makhach from HK where Makhach = @Makhach)
			print N'Khách hàng đã tồn tại'
		else 
			insert into HK values (@Makhach, @Tenkhach, @Diachi, @Dienthoai, @SCMT)
			print N'Thêm khách thành công'
	end

exec sp_themHanhKhach 'F1','Broly Bans','Hollo, USA','1907163519','001073735642'




