create database productManagement;
use productManagement;

create table CTPXuat(
    SOPX int,
    MAVTU int,
    SLXUAT int,
    DGXUAT float,
    primary key (SOPX)
);

create table PXUAT(
    SOPX INT,
    NGAYXUAT DATE,
    TENKH VARCHAR(50),
    PRIMARY KEY(SOPX),
    FOREIGN KEY (SOPX) REFERENCES CTPXuat(SOPX)
);
CREATE TABLE VATTU(
    MAVTU INT,
    TENVTU VARCHAR(255),
    DVTINH VARCHAR(50),
    PHATRAM FLOAT,
    PRIMARY KEY (MAVTU)
);

CREATE TABLE TONKHO(
    NAMTHANG DATE,
    MAVTU INT,
    SLDAU INT,
    TONGSLN INT,
    TONGSLX INT,
    SLCUOI INT,
    PRIMARY KEY (NAMTHANG),
    FOREIGN KEY (MAVTU) REFERENCES VATTU(MAVTU)
);

CREATE TABLE CTDONDH(
    SODH INT,
    MAVTU INT,
    SLDAT INT,
    PRIMARY KEY (SODH),
    FOREIGN KEY (MAVTU) REFERENCES VATTU(MAVTU)
);
CREATE TABLE CTPNHAP(
    SOPN INT,
    MAVTU INT,
    SLNHAP INT,
    DGNHAP FLOAT,
    PRIMARY KEY (SOPN),
    FOREIGN KEY (MAVTU) REFERENCES VATTU(MAVTU)
);
CREATE TABLE DONDH(
    SODH INT,
    NGAYDH DATE,
    MANHACC INT,
    PRIMARY KEY (SODH),
    FOREIGN KEY (MANHACC) REFERENCES NHACC(MANHACC));
CREATE TABLE PNHAP(
    SOPN INT,
    NGAYNHAP DATE,
    SODH INT,
    PRIMARY KEY (SOPN),
    FOREIGN KEY (SOPN) REFERENCES CTPNHAP(SOPN)
                  );
CREATE TABLE NHACC(
    MANHACC INT,
    TENNHACC VARCHAR(255),
    DIACHI VARCHAR(255),
    DIENTHOAI INT,
    PRIMARY KEY (MANHACC)
);

alter table ctpxuat add foreign key (MAVTU) references vattu(MAVTU);
alter table dondh add foreign key (SODH) references ctdondh(SODH);
alter table pnhap add foreign key (SODH) references dondh(SODH);


insert into vattu value (1, 'xi măng', 'tấn', 15);
insert into vattu value (2, 'Sắt', 'tấn', 35);
insert into vattu value (3, 'Thép', 'tấn', 10);
insert into vattu value (4, 'Sơn', 'Bình', 14);
insert into vattu value (5, 'Gạch', 'Thùng', 6);
insert into vattu value (6, 'Dây điện', 'Mét', 12);
insert into vattu value (7, 'Ống nhựa', 'Mét', 18);


insert into tonkho value ('2020-2-12',1,4,15,42,4);
insert into tonkho value ('2020-1-4',2,4,15,42,4);
insert into tonkho value ('2020-2-6',3,4,15,42,4);
insert into tonkho value ('2019-2-12',4,4,15,42,4);
insert into tonkho value ('2018-3-16',5,4,3,42,4);
insert into tonkho value ('2020-5-22',6,543,15,42,4);
insert into tonkho value ('2020-5-24',6,3,15,42,4);

insert into ctpnhap value (1,1,2,4234);
insert into ctpnhap value (2,1,2,342);
insert into ctpnhap value (3,2,2,434);
insert into ctpnhap value (4,4,2,34);
insert into ctpnhap value (5,2,2,4);
insert into ctpnhap value (6,6,2,23);
insert into ctpnhap value (7,2,2,334);
insert into ctpnhap value (8,5,2,3334);


insert into ctpxuat value (1,1,234,234);
insert into ctpxuat value (2,2,334,234);
insert into ctpxuat value (3,1,244,234);
insert into ctpxuat value (4,3,2,234);
insert into ctpxuat value (5,3,214,234);
insert into ctpxuat value (6,5,224,234);
insert into ctpxuat value (7,6,114,234);
insert into ctpxuat value (8,6,664,234);

alter table ctpxuat add column company varchar(50);
alter table pxuat drop foreign key pxuat_ibfk_1;
alter table pxuat rename column SOPX to ID;
alter table pxuat modify column ID varchar(50);
alter table ctpxuat add foreign key(company) references pxuat(ID);

insert into pxuat value ('ABC','2020-1-11','Xuan Tho');
insert into pxuat value ('DDD','2020-2-21','Xuan Tho');
insert into pxuat value ('ADC','2020-1-11','Xuan Tho');
insert into pxuat value ('CCC','2020-2-21','Xuan Tho');
insert into pxuat value ('FFF','2020-1-11','Xuan Tho');
insert into pxuat value ('XXX','2020-2-21','Xuan Tho');

drop view vw_CTPNHAP;
create view vw_CTPNHAP as select SOPN,VATTU.MAVTU, SLNHAP, DGNHAP, SLNHAP*DGNHAP as 'Tổng tiền' from vattu
    join ctpnhap on VATTU.MAVTU = CTPNHAP.MAVTU group by SOPN;
select * from vw_CTPNHAP;


create view vw_CTPNHAP_VT as select SOPN, VATTU.MAVTU, TENVTU,SLNHAP, DGNHAP, SLNHAP*DGNHAP as 'Thành Tiền'
from VATTU join CTDONDH C on VATTU.MAVTU = C.MAVTU
join CTPNHAP C2 on VATTU.MAVTU = C2.MAVTU group by SOPN, MAVTU, TENVTU, SLNHAP, DGNHAP;
DROP VIEW vw_CTPNHAP_VT;
select * from vw_CTPNHAP_VT order by SOPN;

create view w_CTPNHAP_VT_P as select CTPNHAP.SOPN, NGAYNHAP, SODH,CTPNHAP.MAVTU, TENVTU, SLNHAP,DGNHAP,SLNHAP*DGNHAP AS 'THANH TIỀN' FROM CTPNHAP
    JOIN PNHAP P on CTPNHAP.SOPN = P.SOPN
    JOIN VATTU V on CTPNHAP.MAVTU = V.MAVTU GROUP BY CTPNHAP.SOPN;
DROP VIEW w_CTPNHAP_VT_P;
SELECT *FROM w_CTPNHAP_VT_P;

CREATE VIEW vw_CTPNHAP_VT_PN_DH AS SELECT CTPNHAP.SOPN, NGAYNHAP,SODH,CTPNHAP.MAVTU,TENVTU,SLNHAP,DGNHAP, SLNHAP*DGNHAP AS 'THÀNH TIỀN'
 FROM CTPNHAP JOIN VATTU V on CTPNHAP.MAVTU = V.MAVTU
JOIN PNHAP P on CTPNHAP.SOPN = P.SOPN GROUP BY CTPNHAP.SOPN;
SELECT * FROM vw_CTPNHAP_VT_PN_DH;

CREATE VIEW vw_CTPNHAP_loc  AS SELECT SOPN, MAVTU, SLNHAP,DGNHAP, SLNHAP*DGNHAP AS 'THÀNH TIỀN' FROM CTPNHAP ;
SELECT * FROM vw_CTPNHAP_loc;

CREATE VIEW vw_CTPNHAP_VT_loc AS SELECT CTPNHAP.SOPN,CTPNHAP.MAVTU,TENVTU,SLNHAP,DGNHAP,SLNHAP*DGNHAP AS 'THÀNH TIỀN' FROM CTPNHAP
    JOIN PNHAP P on CTPNHAP.SOPN = P.SOPN
JOIN VATTU V on CTPNHAP.MAVTU = V.MAVTU;
SELECT * FROM vw_CTPNHAP_VT_loc ;

CREATE VIEW vw_CTPXUAT AS SELECT SOPX,MAVTU,SLXUAT,DGXUAT, SLXUAT*DGXUAT AS 'THÀNH TIỀN'
FROM ctpxuat;
SELECT * FROM vw_CTPXUAT;

CREATE VIEW vw_CTPXUAT_VT AS SELECT SOPX,CTPXuat.MAVTU,TENVTU,SLXUAT,DGXUAT FROM CTPXuat
    JOIN VATTU V on CTPXuat.MAVTU = V.MAVTU GROUP BY SOPX;

SELECT * FROM vw_CTPXUAT_VT;


CREATE VIEW vw_CTPXUAT_VT_PX  AS SELECT CX.SOPX , TENKH, V.MAVTU ,TENVTU,SLXUAT,DGXUAT FROM PXUAT
JOIN CTPXuat CX JOIN VATTU V on CX.MAVTU = V.MAVTU GROUP BY CX.SOPX;

DROP VIEW vw_CTPXUAT_VT_PX;
SELECT *FROM vw_CTPXUAT_VT_PX;

-- STORE PROCEDURE
CREATE PROCEDURE TONKHO(
 IN TOTAL INT
)
BEGIN SELECT* FROM TONKHO WHERE SLCUOI = TOTAL;
 END;

CALL productmanagement.TONKHO(4);

CREATE PROCEDURE TONKHO(
    IN MAVT INT
)
BEGIN  SELECT SLCUOI FROM TONKHO WHERE MAVTU = MAVT;
END;

DROP PROCEDURE TONKHO;

CALL productmanagement.TONKHO(5);

CREATE PROCEDURE TIEN_XUAT(IN MAVT INT)
BEGIN SELECT SLXUAT*DGXUAT AS 'TỔNG TIỀN' FROM CTPXuat WHERE MAVTU = MAVT;
END;

CALL TIEN_XUAT(5);
