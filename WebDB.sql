use master
create database WebDB

go
use WebDB

go
create table NEWSINFO(
	WEBPATH varchar(500) PRIMARY KEY, 
	HTMLXPATH varchar(300),
	TITLE nvarchar(100),
	DOCUMENTNUMBER varchar(20) 
)

go
create table DOCUMENTINFO(
	DOCUMENTNUMBER varchar(20) PRIMARY KEY,
	DOCUMENTFILE varchar(300),
	DATEISSUED DATE,
	SIGNEDBY nvarchar(200),
	AGENCYISSUED nvarchar(100),
	DOCUMENTCATEGORY nvarchar (50),
	DOCUMENTSTATUS nvarchar(30)
)

go
alter table NEWSINFO add constraint DOCUMENTINFO_DOCUMENTNUMBER_NEWSINFO foreign key (DOCUMENTNUMBER) references DOCUMENTINFO(DOCUMENTNUMBER)

go 
insert into NEWSINFO values
	('http://www.moit.gov.vn/web/guest/tin-chi-tiet/-/chi-tiet/viet-nam-to-chuc-thanh-cong-phien-ra-soat-chinh-sach-thuong-mai-lan-thu-hai-tai-wto-22003-22.html',
	'//div[@id="contentnews"]/p',
	N'Việt Nam tổ chức thành công Phiên rà soát Chính sách thương mại lần thứ hai tại WTO',
	''),
	('http://www.moit.gov.vn/web/guest/tin-chi-tiet/-/chi-tiet/ra-mat-he-thong-canh-bao-thuong-mai-toan-cau-eping-phien-ban-tieng-viet-22000-22.html',
	'//div[@id="contentnews"]/p',
	N'Ra mắt Hệ thống cảnh báo thương mại toàn cầu ePing phiên bản tiếng Việt',
	'')
	
go 
Select * from NEWSINFO

drop table NEWSINFO

use master
drop database WebDB

