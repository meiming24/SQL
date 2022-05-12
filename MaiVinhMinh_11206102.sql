create database QLTK_MaiVinhMinh;
use QLTK_MAIVINHMINH;

--Cau 1: 
create table KHACHHANG (
	maKH char(10) primary key,
	tenKH nvarchar(40) not null,
	soCMT BIGINT, 
	diaCHI nvarchar(100) not null,
	dienThoai char(12)
);

CREATE TABLE LOAITK (
	maLOAI char(10) primary key,
	tenLOAI nvarchar(40) not null,
	soNGAY INT, 
	loaiTIEN nvarchar(40) not null,
	laiSUAT FLOAT
);

create table HINHTHUC(
	maHT char(10) primary key not null,
	tenHT nvarchar(20),
	ghiCHU nvarchar(50)
);

create table SOTK(
	maSO char(10) primary key,
	maKH char(10) references KHACHHANG(maKH) not null,
	maLOAI char(10) references LOAITK(maLOAI) not null,
	maHT char(10) references HINHTHUC(maHT) not null,
	soTIENGUI float,
	ngayGUI date,
	ngayRUT date,
	tienLAI float,
	soTIENRUT float
);


select * from KHACHHANG;
select * from LOAITK;
select * from HINHTHUC;
select * from SOTK;

insert into KHACHHANG values ('11200001','Mai A','00001','Ha Noi','0914356763');
insert into KHACHHANG values ('11200002','Vo B','00002','Da Nang','0915356863');
insert into KHACHHANG values ('11200003','Luong C','00003','Hai Phong','0924336466');
insert into KHACHHANG values ('11200004','Ta D','00003','Ha Noi','0974356563');

insert into LOAITK values ('A1','Dong','1000','VND','0.05');
insert into LOAITK values ('B1','Bac','800','VND','0.08');
insert into LOAITK values ('C1','Vang','500','VND','0.04');

insert into HINHTHUC values ('CK','chuyen khoan',NULL);
insert into HINHTHUC values ('TT','truc tiep',NULL);

insert into SOTK values ('STK1','11200001','A1','CK',5000000, '2022-02-03','2024-04-07',0,0);
insert into SOTK values ('STK2','11200002','B1','TT',15000000,'2022-01-04','2024-02-06',0,0);
insert into SOTK values ('STK3','11200003','C1','CK',15000000,'2022-03-06','2024-01-13',0,0);

--Cau 2:
create proc sp_LOAITK(@maLOAI char(10),@tenLOAI nvarchar(40),@soNGAY int, @loaiTIEN nvarchar(40),@laiSUAT float)
as begin
	if exists (select @maLOAI from LOAITK where @maLOAI = maLOAI)
		begin 
			print 'Ma tai khoan da ton tai'
		end
	else
		begin 
			insert into KHACHHANG values (@maLOAI, @tenLOAI, @SoNGAY, @loaiTIEN, @laiSUAT);
		end
end

create proc sp_KHACHHANG(@maKH char(10),@tenKH nvarchar(40),@soCMT BIGINT, @diaCHI nvarchar(100),@dienThoai char(12))
as begin
	if exists (select @maKH FROM KHACHHANG where @maKH = maKH)
		begin 
			print 'Ma khach hang da ton tai'
		end
	else
		begin 
			insert into KHACHHANG values (@maKH, @tenKH, @soCMT, @diaCHI, @dienThoai);
		end
end


create proc SP_SOTK(@maSO char(10),@maKH char(10),@maLOAI char(10),@soTIENGUI float,@ngayGUI DATE,@ngayRUT DATE,@maHT char(10))
as begin
	if exists (select maKH from KHACHHANG where @maKH = maKH)
		begin	
			if exists (select maLOAI from LOAITK where maLOAI = @maLOAI)
				if exists (select maSO from SOTK where maSO = @maSO)
					begin 
						print 'Ma STK da ton tai'
					end
				else
					begin
						insert into SOTK(maSO, maKH, maLOAI, soTIENGUI, ngayGUI, ngayRUT, maHT) values (@maSO, @maKH, @maLOAI, @soTIENGUI, @ngayGUI, @ngayRUT, @maHT)
					end
			else 
				begin 
					print 'Ma loai khong ton tai'
				end
		end
	else
		begin 
			print 'Ma khach hang khong ton tai'
		end
end

--Cau 3:
 create view v_SOTK as(
	select maSO ,KHACHHANG.maKH,tenKH,soCMT,diaCHI,dienTHOAI,soTIENGUI ,LOAITK.maLOAI,tenLOAI,soNGAY,loaiTIEN,laiSUAT,ngayGUI,ngayRUT,HINHTHUC.maHT,tenHT ,tienLAI ,soTIENRUT
	from KHACHHANG,LOAITK,SOTK, HINHTHUC
	where KHACHHANG.maKH = SOTK.maKH and LOAITK.maLOAI = SOTK.maLOAI and HINHTHUC.maHT = SOTK.maHT
);