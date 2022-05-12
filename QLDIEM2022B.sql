create database QLDIEM2022B
use QLDIEM2022B

drop database QLDIEM2022B

create table Lop (Malop char(10) primary key, Tenlop nvarchar(100), Sosv int);
create table Sinhvien (Masv char(10) primary key, Tensv nvarchar(50), Gioitinh nvarchar(3), Ngaysinh date, Malop char(10) not null references Lop(Malop), Tinh nvarchar(100), Hocbong float);
create table Monhoc (Mamon char(10) primary key, Tenmon nvarchar(100), Sotc int);
create table Diem (Masv char(10) not null references Sinhvien(Masv), Mamon char(10) not null references Monhoc(Mamon), Diem1 float, Diem2 float, Diem3 float, Diemhp float, primary key(Masv, Mamon));

--Xem thong tin CSDL
exec sp_helpdb QLDIEM2022B
exec sp_help Sinhvien
exec sp_help Lop
exec sp_help Monhoc
exec sp_help Diem

--Them truong Ghichu vao bang Monhoc
alter table Monhoc add Ghichu nvarchar(50)
--Xoa truong Ghichu trong bang Monhoc
alter table Monhoc drop column Ghichu

--Doi ten cot
exec sp_rename 'Monhoc.Sotc', 'Tongtc', 'Column';


select * from Lop;
select * from Monhoc;
select * from Sinhvien;
select * from Diem;

insert into Lop values ('CNTT62A', N'Công nghệ thông tin 62A', 0),
					   ('CNTT62B', N'Công nghệ thông tin 62B', 0),
					   ('KHMT62A', N'Khoa học máy tính 62A', 0),
					   ('KHMT62B', N'Khoa học máy tính 62B', 0),
					   ('HTTTQL62A', N'Hệ thống thông tin quản lý 62A', 0),
					   ('HTTTQL62B', N'Hệ thống thông tin quản lý 62B', 0),
					   ('TMDT62A', N'Thương mại điện tử 62A', 0);

select count(Malop) from Lop as Solop;
select Malop, Tenlop from Lop;

insert into Monhoc values ('TCC', N'Toán cao cấp', 3),
						  ('GDTC1', N'Giáo dục thể chất 1', 2),
						  ('GDTC2', N'Giáo dục thể chất 2', 3),
						  ('VLDC1', N'Vật lý đại cương 1', 3),
						  ('TRR', N'Toán rời rạc', 4);

--GDTC1 Thay doi len 3 tin chi
update Monhoc set Sotc = 3 where Mamon = 'GDTC1'

insert into Sinhvien values ('SV01', N'Trần Văn An', N'Nam', '5-12-2002', 'CNTT62A', N'Hà Nội', 0),
							('SV02', N'Trần Thái Hà', N'Nam', '1-12-2002', 'CNTT62A', N'Hà Nội', 0),
							('SV03', N'Trần Thanh Tâm', N'Nữ', '12-15-2002', 'CNTT62B', N'Bắc Ninh', 0),
							('SV04', N'Trần Quốc Nam', N'Nam', '6-22-2002', 'CNTT62B', N'Bắc Ninh', 0),
							('SV05', N'Nguyễn Thanh Hà', N'Nữ', '6-21-2002', 'CNTT62A', N'Hà Nam', 0),
							('SV06', N'Trịnh Nam Sơn', N'Nam', '6-22-2002', 'HTTTQL62A', N'Bắc Ninh', 0),
							('SV07', N'Trần Hải', N'Nữ', '1-21-2002', 'HTTTQL62A', N'Hà Nam', 0),
							('SV08', N'Trịnh Quốc Nam', N'Nữ', '3-22-2002', 'HTTTQL62A', N'Bắc Ninh', 0),
						    ('SV09', N'Lê Hoàng Nam', N'Nam', '6-21-2002', 'TMDT62A', N'Bắc Ninh', 0),
							('SV10', N'Lã Ngọc Thanh', N'Nữ', '6-22-2002', 'TMDT62A', N'Hà Nam', 0),
							('SV11', N'Lê Hồng Nhung', N'Nữ', '7-12-2002', 'KHMT62A', N'Hà Tĩnh', 0);

insert into Diem values ('SV01', 'TCC', 10, 7, 6.5, 0),
						('SV01', 'GDTC1', 9, 8, 8, 0),
						('SV01', 'GDTC2', 7, 9, 2, 0),
						('SV01', 'VLDC1', 8, 5, 7, 0),
						('SV01', 'TRR', 8, 5, 7, 0);

insert into Diem values ('SV02', 'TCC', 10, 7, 7, 0),
						('SV02', 'GDTC1', 9, 8, 9, 0),
						('SV02', 'GDTC2', 7, 6, 8, 0),
						('SV02', 'VLDC1', 8, 3, 9, 0),
						('SV02', 'TRR', 8, 7, 6, 0);

insert into Diem values ('SV03', 'TCC', 10, 8, 9, 0),
						('SV03', 'GDTC1', 9, 8, 6, 0),
						('SV03', 'GDTC2', 9, 8, 2, 0),
						('SV03', 'VLDC1', 8, 7, 9, 0),
						('SV03', 'TRR', 10, 7, 6, 0);

insert into Diem values ('SV04', 'TCC', 9, 8, 9, 0),
						('SV04', 'GDTC1', 9, 8, 9, 0),
						('SV04', 'GDTC2', 7, 8, 6, 0),
						('SV04', 'VLDC1', 8, 7, 9, 0),
						('SV04', 'TRR', 10, 7, 6, 0);

insert into Diem values ('SV05', 'TCC', 10, 8, 9, 0),
						('SV05', 'GDTC1', 9, 8, 9, 0),
						('SV05', 'GDTC2', 7, 8, 6, 0);

insert into Diem values ('SV06', 'TCC', 10, 8, 9, 0),
						('SV06', 'GDTC1', 6, 8, 9, 0),
						('SV06', 'GDTC2', 9, 9, 8, 0),
						('SV06', 'VLDC1', 9, 7, 9, 0),
						('SV06', 'TRR', 10, 7, 6, 0);

insert into Diem values ('SV07', 'TCC', 10, 8, 9, 0),
						('SV07', 'VLDC1', 4, 7, 9, 0);

insert into Diem values ('SV08', 'TRR', 9, 8, 4, 0),
						('SV08', 'VLDC1', 4, 7, 9, 0),
						('SV08', 'TCC', 10, 8, 9, 0);

insert into Diem values ('SV09', 'TRR', 9, 8, 4, 0),
						('SV09', 'VLDC1', 4, 7, 9, 0),
						('SV09', 'TCC', 10, 8, 9, 0);

--Xoa diem cua Sinh vien co Masv = 'SV03' va Mamon = 'TCC'
delete from Diem where Masv = 'SV03' and Mamon = 'TCC';

--Tinh diem thanh phan
update Diem set Diemhp = (Diem1 * 0.1 + Diem2 * 0.4 + Diem3 * 0.5);

--Dem co bao nhieu sinh vien hoc mon GDTC1
select count(Masv) from Diem where Mamon = 'GDTC1';

--Dem co bao nhieu sinh vien diem hoc phan >= 7
select  count(distinct Masv) from Diem where Diemhp >= 7;

--Update lop CNTT62A 40SV, CNTT62B 45SV, các lớp còn lại 50SV
update Lop set Sosv = 40 where Malop = 'CNTT62A';
update Lop set Sosv = 45 where Malop = 'CNTT62B';
update Lop set Sosv = 50 where Malop not in ('CNTT62A', 'CNTT62B');

select distinct Gioitinh from Sinhvien;
select distinct Masv from Sinhvien;
select * from Sinhvien where Gioitinh = N'Nam';
select * from Sinhvien where Gioitinh = N'Nữ';

--So luong sinh vien nam, nữ
select count(distinct Masv) as Soluong from Sinhvien where Gioitinh = N'Nam';
select count(distinct Masv) as Soluong from Sinhvien where Gioitinh = N'Nữ';

--So luong sinh vien > 5 (theo gioi tinh)
select Gioitinh, count(Masv) as Soluong from Sinhvien group by Gioitinh having count(Masv) > 5

--Trong table Diem, cho biet So luong Sinh vien theo tung mon hoc
select distinct(Mamon), count(Masv) as Soluong from Diem group by Mamon

--Trong table Diem, cho biet So luong Sinh vien theo tung mon hoc, Diemhp >= 8
select distinct(Mamon), count(Masv) as Soluong from Diem where Diemhp >= 8 group by Mamon

--Trong table Diem, cho biet So luong Sinh vien theo tung mon hoc > 7
select distinct(Mamon), count(Masv) as Soluong from Diem group by Mamon having count(Masv) > 7

----------------------------------------VIEW----------------------------------------
create view Sinhvien_Lop
as
	select Masv, Tensv, Sinhvien.Malop, Tenlop, Gioitinh, Ngaysinh
	from Sinhvien, Lop
	where Lop.Malop = Sinhvien.Malop;

select * from Sinhvien_Lop;

--Co bao nhieu sinh vien sinh thang 6
select count(Masv) from Sinhvien_Lop where month(Ngaysinh) = 6;
--Co bao hieu sinh vien sinh thang 5, 6
select count(Masv) from Sinhvien_Lop where month(Ngaysinh) in (5, 6);

create view V_Diem1
as
	select Sinhvien.Masv, Tensv, Malop, Diem.Mamon, Tenmon, Sotc, Diem1, Diem2, Diem3, Diemhp
	from Sinhvien, Monhoc, Diem
	where Sinhvien.Masv = Diem.Masv and Diem.Mamon = Monhoc.Mamon

select * from V_Diem1

--Co bao nhieu mon hoc duoc sinh vien dang ky
select count(distinct Mamon) from V_Diem1

--Liet ke cac mon hoc duoc sinh vien dang ky
select distinct Mamon, Tenmon from V_Diem1

--Co bao nhieu sinh vien da dang ky hoc
select count(distinct Masv) as Soluong from V_Diem1

--Mon hoc nao co sinh vien dang ky nhieu nhat
select Mamon, count(Mamon) from V_Diem1 as Soluong group by Mamon having count(Mamon) >= all(select count(Mamon) as Soluong from V_Diem1 group by Mamon)

--Mon hoc nao co sinh vien dang ky it nhat
select Mamon, count(Mamon) from V_Diem1 as Soluong group by Mamon having count(Mamon) <= all(select count(Mamon) as Soluong from V_Diem1 group by Mamon)

--Lop nao co so sinh vien nhieu nhat
select Malop, count(Malop) from Sinhvien_Lop as Soluong group by Malop having count(Malop) >= all(select count(Malop) as Soluong from Sinhvien_Lop group by Malop)

--Lop nao co so sinh vien it nhat
select Malop, count(Malop) from Sinhvien_Lop as Soluong group by Malop having count(Malop) <= all(select count(Malop) as Soluong from Sinhvien_Lop group by Malop)

--Tim ma lop khong co trong bang sinh vien
select Malop, Tenlop from Lop where Malop not in (select Malop from Sinhvien)

--Liet ke cac ma lop trong bang sinh vien
select Malop, Tenlop from Lop where Malop in (select Malop from Sinhvien)

--Liet ke cac lop co so sinh vien >= 3
select Malop, Tenlop, count(Masv) as Soluong from Sinhvien_Lop group by Malop, Tenlop having count(Masv) >= 3

create view V_Diem2 
as
	select Sinhvien.Masv, Tensv, Malop, Monhoc.Mamon, Tenmon, Sotc, Diem1, Diem2, Diem3, (Diem1 * 0.1 + Diem2 * 0.4 + Diem3 * 0.5) as Diemhp 
	from Sinhvien, Monhoc, Diem
	where Sinhvien.Masv = Diem.Masv and Monhoc.Mamon = Diem.Mamon

select * from V_Diem2

create view V_Diem3
as
	select Sinhvien.Masv, Tensv, Gioitinh, Ngaysinh, Tinh, Hocbong, Sinhvien.Malop, Monhoc.Mamon, Tenmon, Sotc, Diem1, Diem2, Diem3, (Diem1 * 0.1 + Diem2 * 0.4 + Diem3 * 0.5) as Diemhp, Sosv
	from Sinhvien, Monhoc, Diem, Lop
	where Sinhvien.Masv = Diem.Masv and Monhoc.Mamon = Diem.Mamon and Lop.Malop = Sinhvien.Malop

select * from V_Diem3;

--Cac ban nu lop CNTT62A va HTTTQL62A
select * from V_Diem3 where Gioitinh = N'Nữ' and Malop = 'HTTTQL62A';
select * from V_Diem3 where Gioitinh = N'Nữ' and Malop = 'CNTT62A';
select * from V_Diem3 where Gioitinh = N'Nữ' and Malop in ('HTTTQL62A', 'CNTT62A');


exec sp_helptext V_Diem3;
exec sp_help Sinhvien;

--Thu tuc tim ma lop va gioi tinh
alter proc sp_Malop @Malop char(10), @Gioitinh nvarchar(6)
as
	select * from Sinhvien where Malop = @Malop and Gioitinh = @Gioitinh

exec sp_Malop 'CNTT62A', N'Nữ'

--Viet thu tuc xoa lop trong bang lop
create proc sp_Xoalop @Malop char(10)
as
	if exists(select Malop from Sinhvien where Malop = @Malop)
		print N'Mã lớp này đang được sử dụng trong bảng sinh viên, không thể xóa'
	else 
		if not exists(select Malop from Lop where Malop = @Malop)
			print N'Mã lớp không tồn tại'
		else 
			delete from Lop where Malop = @Malop
		
exec sp_Xoalop 'CNTT62A' 

--Viet thu tuc them lop trong bang lop
create proc sp_Themlop @Malop char(10), @Tenlop nvarchar(100), @Sosv int
as
begin
	if exists(select Malop from Lop where Malop = @Malop)
		print N'Mã lớp này đã tồn tại, không thể thêm';
	else 
		insert into Lop values (@Malop, @Tenlop, @Sosv);
end

--Them, xoa Sinh vien trong bang Sinh vien
exec sp_help Sinhvien

create proc sp_Xoasv @Masv char(10)
as
	if exists(select Masv from Diem where Masv = @Masv)
		print N'Mã sinh viên này sử dụng trong bảng Điểm, không thể xóa' 
	else 
		if exists(select Masv from Sinhvien where @Masv = Masv)
			delete from Sinhvien where Masv = @Masv
		else 
			print N'Mã sinh viên không tồn tại'

exec sp_Xoasv 'SV15'

create proc sp_Themsv @Masv char(10), @Tensv nvarchar(100), @Gioitinh nvarchar(6), @Ngaysinh date, @Malop char(10), @Tinh nvarchar(200), @Hocbong float
as
begin
	if exists(select Masv from Sinhvien where Masv = @Masv)
		print N'Mã sinh viên đã tồn tại'
	else 
		if exists(select Malop from Lop where Malop = @Malop)
			insert into Sinhvien values (@Masv, @Tensv, @Gioitinh, @Ngaysinh, @Malop, @Tinh, @Hocbong)
		else 
			print N'Mã lớp không tồn tại'
end

--Tim kiem sinh vien theo tinh va lop
create proc sp_Timkiemsv @Malop char(10), @Tinh nvarchar(200)
as
	select * from Sinhvien where Malop = @Malop and Tinh = @Tinh


--Cap nhat mon hoc
create proc sp_CapnhatMonhoc @Mamon char(10), @Sotc int
as
	if not exists(select Mamon from Monhoc where Mamon = @Mamon)
		print N'Mã môn học không tồn tại' 
	else 
		update Monhoc set Sotc = @Sotc where Mamon = @Mamon

exec sp_CapnhatMonhoc 'TRR', 6

--Cap nhat diem
create proc sp_Capnhatdiem @Masv char(10), @Mamon char(10), @Diem1 float, @Diem2 float, @Diem3 float
as
begin
	if not exists(select Masv, Mamon from Diem where Masv = @Masv and Mamon = @Mamon)
		print N'Không có sinh viên và điểm trong hệ thống'
	else
		update Diem set Diem1 = @Diem1, Diem2 = @Diem2, Diem3 = @Diem3, Diemhp = (@Diem1 * 0.1 + @Diem2 * 0.4 + @Diem3 * 0.5)
		where Masv = @Masv and Mamon = @Mamon
end

select * from V_Diem3

--Danh sach tong tin chi tung sinh vien
select Masv, sum(Sotc) as SoTC from V_Diem3 group by Masv

--Tinh diem TB tung sinh vien: Sum(Diemhp * Sotc)/Sum(Sotc)
select Masv, round(sum(Diemhp * Sotc)/sum(Sotc), 1) as DiemTB from V_Diem3 group by Masv

select Masv, sum(Sotc) as SoTC, round(sum(Diemhp * Sotc)/sum(Sotc), 1) as DiemTB from V_Diem3 group by Masv

--Function tính điểm TBHK
create function TinhdiemTBHK (@Masv char(10))
returns float
as
begin
	return(select round(sum(Diemhp * Sotc)/sum(Sotc), 1) from V_Diem3 where Masv = @Masv group by Masv)
end

exec dbo.TinhdiemTBHK 'SV01'
--Function tính tổng TC
create function TongTC (@Masv char(10))
returns int
as
begin
	return (select sum(Sotc) from V_Diem3 where Masv = @Masv group by Masv)
end

--Tao view tinh diem tong ket
create view V_Tongket(Masv, Tensv, Malop, TongsoTC, DiemTK)
as
	select distinct Masv, Tensv, Malop, dbo.TongTC(Masv), dbo.TinhdiemTBHK(Masv) from V_Diem3

select * from V_Tongket

--Thu tuc xet hoc bong
--Xet hoc bong cho nhung sinh vien co so tin chi > 10
create proc sp_Hocbong
as
begin
	update Sinhvien
	set Hocbong = (case
					   when (DiemTK >= 8.5) then 700
					   when (DiemTK >= 7.5) then 500
					   when (DiemTK >= 6) then 300
				   else 0
				   end)
	from Sinhvien, V_Tongket where V_Tongket.Masv = Sinhvien.Masv and V_Tongket.TongsoTC > 10
end

exec sp_Hocbong
select * from Sinhvien




