create database hackathon;
use hackathon;
create table dmkhoa
(
    MaKhoa  varchar(20) primary key,
    TenKhoa varchar(255)
);

create table dmnganh
(
    MaNganh  int auto_increment primary key,
    TenNganh varchar(255),
    MaKhoa   varchar(20) not null,
    foreign key (MaKhoa) references dmkhoa (MaKhoa)
);

create table dmhocphan
(
    MaHP    int primary key auto_increment,
    TenHP   varchar(255),
    Sodvht  int,
    MaNganh int not null,
    HocKy   int not null,
    foreign key (MaNganh) references dmnganh (MaNganh)
);

create table dmlop
(
    MaLop      varchar(20) primary key,
    TenLop     varchar(255),
    MaNganh    int not null,
    KhoaHoc    int,
    HeDT       varchar(255),
    NamNhapHoc int,
    foreign key (MaNganh) references dmnganh (MaNganh)
);

create table sinhvien
(
    MaSV     int primary key auto_increment,
    HoTen    varchar(255),
    MaLop    varchar(20) not null,
    GioiTinh tinyint(1),
    NgaySinh date,
    DiaChi   varchar(255),
    foreign key (MaLop) references dmlop (MaLop)
);

create table dienhp
(
    MaSV   int not null,
    MaHP   int not null,
    DiemHP float,
    foreign key (MaSV) references sinhvien (MaSV),
    foreign key (MaHP) references dmhocphan (MaHP)
);

-- 	Thêm dữ liệu vào các bảng như sau:
--  1.	dmkhoa
insert into dmkhoa
values ('CNTT', 'Công nghệ thông tin'),
       ('KT', 'Kế Toán'),
       ('SP', 'Sư Phạm');

-- 2.	dmnganh
insert into dmnganh
values (140902, 'Sư phạm toán tin ', 'SP'),
       (480202, 'Tin học ứng dụng', 'CNTT');

-- 3.	dmlop
insert into dmlop
values ('CT11', 'Cao đẳng tin học', 480202, 11, 'TC', 2013),
       ('CT12', 'Cao đẳng tin học', 480202, 12, 'CĐ', 2013),
       ('CT13', 'Cao đẳng tin học', 480202, 13, 'TC', 2014);

-- 4.	dmhocphan
insert into dmhocphan
values (1, 'Toán cao cấp A1', 4, 480202, 1),
       (2, 'Tiếng anh 1', 3, 480202, 1),
       (3, 'Vật lý đại cương', 4, 480202, 1),
       (4, 'Tiếng anh 2', 7, 480202, 1),
       (5, 'Tiếng anh 1', 3, 140902, 2),
       (6, 'Xác Xuất thống kê', 3, 480202, 2);

-- 5.	sinhvien
insert into sinhvien
values (1, 'Phan Thanh', 'CT12', 0, '1990-09-12', 'Tuy Phước'),
       (2, 'Nguyễn Thi Cấm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
       (3, 'võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
       (4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
       (5, 'Tran Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạch'),
       (6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
       (7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phù mỹ'),
       (8, 'Nguyễn Van Huy', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
       (9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');

-- 6.	diemhp

insert into dienhp
values (2, 2, 5.9),
       (2, 3, 4.5),
       (3, 1, 4.3),
       (3, 2, 6.7),
       (3, 3, 7.3),
       (4, 1, 4),
       (4, 2, 5.2),
       (4, 3, 3.5),
       (5, 1, 9.8),
       (5, 2, 7.9),
       (5, 3, 7.5),
       (6, 1, 6.1),
       (6, 2, 5.6),
       (6, 3, 4),
       (7, 1, 6.2);

-- 1.	 Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5     (5đ)

select sv.MaSV, sv.HoTen, sv.MaLop, d.DiemHP, d.MaHP
from sinhvien sv
         join dienhp d on sv.MaSV = d.MaSV
where d.DiemHP >= 5;

-- 2.	Hiển thị danh sách MaSV, HoTen, MaLop, MaHP, DiemHP, MaHP
-- được sắp xếp theo ưu tiên MaLop, HoTen tăng dần. (5đ)

select sv.MaSV, sv.HoTen, sv.MaLop, d.MaHP, d.DiemHP
from sinhvien sv
         join dienhp d on sv.MaSV = d.MaSV
where DiemHP >= 5
order by sv.MaLop and sv.HoTen asc;

-- 3.	Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP,
-- HocKy của những sinh viên có DiemHP từ 5  7 ở học kỳ I. (5đ)

select sv.MaSV, sv.HoTen, sv.MaLop, d.DiemHP
from sinhvien sv
         join dienhp d on sv.MaSV = d.MaSV
         join dmhocphan d2 on d2.MaHP = d.MaHP
where d2.HocKy = 1
  and d.DiemHP between 5 and 7;

-- 4.	Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT (5đ)

select sv.MaSV, sv.HoTen, sv.MaLop, d.TenLop, d2.MaKhoa
from sinhvien sv
         join dmlop d on d.MaLop = sv.MaLop
         join dmnganh d2 on d2.MaNganh = d.MaNganh
where MaKhoa = 'CNTT';

-- 5.	Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp (SiSo): (5đ)

select l.MaLop, l.TenLop, s.HoTen, count(l.MaLop) as 'Tổng số sinh viên'
from dmlop l
         join sinhvien s on l.MaLop = s.MaLop
group by l.MaLop;

-- 6.	Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ, biết công thức tính DiemTBC như sau:
-- DiemTBC = ∑▒〖(DiemHP*Sodvhp)/∑(Sodvhp)〗

SELECT d.MaSV, d2.HocKy,
       SUM(d.DiemHP * d2.Sodvht) / SUM(d2.Sodvht) AS DiemTBC
FROM dienhp d
         JOIN dmhocphan d2 ON d2.MaHP = d.MaHP
GROUP BY d.MaSV, d2.HocKy order by d.MaSV;


-- 7.	Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
select sv.MaLop, d.TenLop, case when GioiTinh = 0 then 'Nữ' when GioiTinh = 1 then 'Nam' end, count(GioiTinh)
from sinhvien sv
         join dmlop d on sv.MaLop = d.MaLop
GROUP BY sv.MaLop, GioiTinh;

-- 8	Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1
-- Biết: DiemTBC = ∑▒〖(DiemHP*Sodvhp)/∑(Sodvhp)〗

SELECT d.MaSV, 1 AS HocKy,
       SUM(d.DiemHP * d2.Sodvht) / SUM(d2.Sodvht) AS DiemTBC
FROM dienhp d
         JOIN dmhocphan d2 ON d2.MaHP = d.MaHP
WHERE d2.HocKy = 1
GROUP BY d.MaSV;



-- 9.	Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên

select sv.MaSV, sv.HoTen, count(DiemHP)
from sinhvien sv
         join dienhp d on sv.MaSV = d.MaSV
where DiemHP < 5
group by d.MaSV;

-- 10.	Đếm số sinh viên có điểm HP <5 của mỗi học phần

select MaHP, count(DiemHP)
from dienhp
where DiemHP < 5
group by MaHP;

-- 11.	Tính tổng số đơn vị học trình có điểm HP<5 của mỗi sinh viên

select sv.MaSV, sv.HoTen, sum(d2.Sodvht) as 'tongdiem'
from sinhvien sv
         join dienhp d on sv.MaSV = d.MaSV
         join dmhocphan d2 on d2.MaHP = d.MaHP
where DiemHP < 5
group by d.MaSV;

-- 12.	Cho biết MaLop, TenLop có tổng số sinh viên >2.

select d.MaLop, d.TenLop, count(s.MaSV) siso
from dmlop d
         join sinhvien s on d.MaLop = s.MaLop
group by d.MaLop
having count(s.MaSV) > 2;

-- 13.	Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm <5. (10đ)

select sv.HoTen, count(d.DiemHP)
from sinhvien sv
         join dienhp d on sv.MaSV = d.MaSV
where DiemHP < 5
group by d.MaSV
having count(d.DiemHP) >= 2;

-- 14.	Cho biết HoTen sinh viên học ít nhất 3 học phần mã 1,2,3 (10đ)

select sv.HoTen, count(MaHP)
from sinhvien sv
         join dienhp d on sv.MaSV = d.MaSV
where d.MaHP in (1, 2, 3)
group by d.MaSV having count(MaHP) >=3;