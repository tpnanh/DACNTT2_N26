use master
create database WebDB

go
use WebDB

go
create table ministry_info(
	ministry_id int identity (1,1) PRIMARY KEY,
	ministry_name nvarchar(100)
)

go
create table article_category_type(
	article_category_type_id int identity (1,1) PRIMARY KEY,
	article_category_type_name nvarchar(100)
)

go
create table legislation_category_type(
	legislation_category_type_id int identity (1,1) PRIMARY KEY,
	legislation_category_type_name nvarchar(100)
)

go
create table article_category_info(
	article_category_id int identity (1,1) PRIMARY KEY,
	ministry_id int,
	category_name nvarchar (200),
	article_category_type_id int,
	category_link_root varchar(1000)
)

go
create table legislation_category_info(
	legislation_category_id int identity (1,1) PRIMARY KEY,
	ministry_id int,
	legislation_name nvarchar (200),
	legislation_category_type_id int,
	legislation_link_root varchar(1000),
)

go
create table ministry_article_category_configuration (
	ministry_id int,			
	article_category_type_id int,
	article_url_xpath varchar(200),
	article_thumbnail_xpath varchar(200),
	page_rule int,
	article_param_xpath varchar(200)
)

go
create table ministry_article_detail_configuration (
	ministry_id int,
	article_title_xpath varchar(200),
	article_description_xpath varchar(200),
	article_time_xpath varchar(200),
	article_author_xpath varchar(200),
	article_content_xpath varchar(200),
)

go
create table ministry_legislation_category_configuration (
	ministry_id int,			
	legislation_category_type_id int,
	legislation_url_xpath varchar(200),
	page_rule int,
	legislation_param_xpath varchar(200)
)

go
create table ministry_legislation_detail_configuration (
	ministry_id int,
	legislation_name_xpath varchar(200),
	legislation_so_hieu_van_ban_xpath varchar(200),
	legislation_ngay_ban_hanh_xpath varchar(200),
	legislation_ngay_hieu_luc_xpath varchar(200),
	legislation_ngay_ky_xpath varchar(200),
	legislation_trich_yeu_xpath varchar(200),
	legislation_co_quan_ban_hanh_xpath varchar(200),
	legislation_nguoi_ky_xpath varchar(200),
	legislation_loai_van_ban_xpath varchar(200),
	legislation_tinh_trang_xpath varchar(200),
	legislation_link_download_xpath varchar(200)
)

go
create table article_info(	
	article_id int identity (1,1) PRIMARY KEY,
	ministry_id int,
	article_url nvarchar(1000) unique,
	article_title nvarchar(200),
	article_description nvarchar(500),
	article_time nvarchar(100),
	article_author nvarchar(100),
	article_content nvarchar(max),	
	article_thumbnail nvarchar(1000)
)

go
create table legislation_info(
	legislation_id int identity (1,1) PRIMARY KEY,
	ministry_id int,
	legislation_name nvarchar(500),	
	legislation_url nvarchar(500),	
	so_hieu_van_ban nvarchar(50) unique,
	ngay_ban_hanh nvarchar(100),
	ngay_hieu_luc nvarchar(100),
	trich_yeu nvarchar(500),
	co_quan_ban_hanh nvarchar(100),
	nguoi_ky nvarchar(100),
	loai_van_ban nvarchar(50),
	tinh_trang nvarchar(50),
	link_download nvarchar(300)
)

go
alter table article_info add constraint ai_ministry_id_ci foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table legislation_info add constraint li_ministry_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table article_category_info add constraint aci_ministry_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table legislation_category_info add constraint lci_ministry_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table ministry_article_detail_configuration add constraint madc_ministry_article_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table ministry_article_category_configuration add constraint macc_ministry_article_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table ministry_legislation_detail_configuration add constraint mldc_ministry_article_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table ministry_legislation_category_configuration add constraint mlcc_ministry_article_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table article_category_info add constraint ci_article_category_type_id_ct foreign key (article_category_type_id) references article_category_type(article_category_type_id)
go
alter table legislation_category_info add constraint ci_legislation_category_type_id_ct foreign key (legislation_category_type_id) references legislation_category_type(legislation_category_type_id)

go
insert into ministry_info(ministry_name) values
	(N'Bộ Công An'),
	(N'Bộ Công Thương'),
	(N'Bộ Nội Vụ'),
	(N'Bộ Giáo dục và Đào tạo'),
	(N'Bộ Giao thông vận tải'),
	(N'Bộ Kế hoạch và đầu tư'),
	(N'Bộ Khoa học và Công nghệ'),
	(N'Bộ Lao động - Thương Binh và Xã hội'),
	(N'Bộ Ngoại giao'),
	(N'Bộ Nông nghiệp và phát triển nông thôn'),
	(N'Bộ Quốc phòng'),
	(N'Bộ Tài chính'),
	(N'Bộ Tài nguyên và Môi trường'),
	(N'Bộ Thông tin và Truyền thông'),
	(N'Bộ Tư pháp'),
	(N'Bộ Văn hóa - Thể thao và Du lịch'),
	(N'Bộ Xây dựng'),
	(N'Bộ Y tế'),
	(N'Chính phủ'),
	(N'Ủy ban Dân tộc'),
	(N'Ngân hàng Nhà nước Việt Nam'),
	(N'Bảo hiểm Xã hội Việt Nam'),
	(N'Viện Hàn lâm Khoa học và Công nghệ Việt Nam'),
	(N'Viện Hàn lâm Khoa học Xã hội Việt Nam'),
	(N'Ủy ban quản lý vốn nhà nước tại doanh nghiệp')

go
insert into article_category_type (article_category_type_name) values
	(N'Tin tức - Thời sự'),
	(N'Hoạt động'),	
	(N'Chỉ đạo điều hành'),
	(N'Tin an ninh trật tự'),
	(N'Người tốt, việc tốt'),	
	(N'Thông cáo'),
	(N'Thông báo'),
	(N'Tin địa phương'),	
	(N'Việc làm'),
	(N'Bảo hiểm xã hội'),
	(N'Lao động ngoài nước'),
	(N'An toàn, vệ sinh lao động'),
	(N'Bảo trợ xã hội'),
	(N'Phòng chống tệ nạn xã hội'),
	(N'Bình đẳng giới'),
	(N'Công tác Đảng - Đảng - Đoàn thể'),
	(N'Kinh tế - Xã hội'),
	(N'Chăm sóc người có công và công tác xã hội'),
	(N'Nông - lâm - thủy sản'),	
	(N'Phòng chống thiên tai'),
	(N'Quản lý chất lượng'),
	(N'Bưu chính'),
	(N'Viễn thông'),	
	(N'Văn bản chính sách mới'),
	(N'Giao lưu - Hợp tác quốc tế'),
	(N'Tin cải cách hành chính'),
	(N'Y tế - Giáo dục'),
	(N'Văn hóa - Văn nghệ - Thể thao'),
	(N'Khoa học - Công nghệ - Môi trường'),
	(N'Thông tin thị trường'),
	(N'Tin tức đào tạo'),
	(N'Thông tin khác')

go
insert into article_category_info(ministry_id,category_name,article_category_type_id,category_link_root) values
(1,N'Hoạt động của Bộ - Bộ Công An',2,'http://bocongan.gov.vn/tin-tuc-su-kien/hoat-dong-cua-luc-luong-cong-an/tin-hoat-dong-cua-bo-2.html?Page='),
(1,N'Hoạt động của địa phương - Bộ Công An',8,'http://bocongan.gov.vn/tin-tuc-su-kien/hoat-dong-cua-luc-luong-cong-an/hoat-dong-cua-dia-phuong-23.html?Page='),
(1,N'Chỉ đạo điều hành - Bộ Công An',3,'http://bocongan.gov.vn/tin-tuc-su-kien/chi-dao-dieu-hanh-24.html?Page='),
(1,N'Thông tin đối ngoại - Bộ Công An',25,'http://bocongan.gov.vn/tin-tuc-su-kien/thong-tin-doi-ngoai-20.html?Page='),
(1,N'Tin an ninh trật tự - Bộ Công An',4,'http://bocongan.gov.vn/tin-tuc-su-kien/tin-an-ninh-trat-tu-22.html?Page='),
(1,N'Người tốt, việc tốt - Bộ Công An',5,'http://bocongan.gov.vn/tin-tuc-su-kien/nguoi-tot-viec-tot-21.html?Page='),
(1,N'Hoạt động xã hội - Bộ Công An',13,'http://bocongan.gov.vn/tin-tuc-su-kien/hoat-dong-xa-hoi-25.html?Page='),

(3,N'Tin tức sự kiện - Bộ Nội vụ',1,'https://www.moha.gov.vn/tin-tuc-su-kien.html?page=1'), 

(4,N'Thông cáo báo chí - Bộ Giáo dục và Đào tạo',6,'https://moet.gov.vn/tintuc/Pages/thong-cao-bao-chi.aspx?date=&EventID=0&page='),
(4,N'Thông báo - Bộ Giáo dục và Đào tạo',7,'https://moet.gov.vn/tintuc/Pages/Thongbao.aspx?date=&EventID=0&page='),
(4,N'Tin tổng hợp - Bộ Giáo dục và Đào tạo',1,'https://moet.gov.vn/tintuc/Pages/tin-tong-hop.aspx?date=&EventID=0&page='),

(5,N'Hoạt động lãnh đạo - Bộ Giao thông vận tải',2,'https://mt.gov.vn/vn/chuyen-muc/856/hoat-dong-lanh-dao-.aspx'),
(5,N'Tin hoạt động ngành GTVT - Bộ Giao thông vận tải',2,'https://mt.gov.vn/vn/chuyen-muc/855/Tin-hoat-dong-nganh.aspx'),
(5,N'Tin đấu thầu - Bộ Giao thông vận tải',1,'https://mt.gov.vn/vn/chuyen-muc/877/dau-thau.aspx'),
(5,N'Thông cáo báo chí - Bộ Giao thông vận tải',7,'https://mt.gov.vn/vn/chuyen-muc/889/thong-cao-bao-chi.aspx'),
(5,N'Văn bản mới ban hành - Bộ Giao thông vận tải',24,'https://mt.gov.vn/vn/chuyen-muc/858/van-ban-moi-ban-hanh.aspx'),

(7,N'Tin tổng hợp - Bộ Khoa học và Công nghệ',1,'https://www.most.gov.vn/vn/chuyen-muc/493/Tin-tong-hop.aspx?page='),
(7,N'Điểm báo KH&CN - Bộ Khoa học và Công nghệ',29,'https://www.most.gov.vn/vn/chuyen-muc/570/Diem-bao-KHCN.aspx?page='),

(8,N'Việc làm - Lao động - Bộ Lao động - Thương Binh và Xã hội',9,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=32&page=1'),
(8,N'Tiền lương - Lao động - Bộ Lao động - Thương Binh và Xã hội',9,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=33&page=1'),
(8,N'Bảo hiểm xã hội - Lao động - Bộ Lao động - Thương Binh và Xã hội',10,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=35&page=1'),
(8,N'Lao động ngoài nước - Lao động - Bộ Lao động - Thương Binh và Xã hội',11,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=34&page=1'),
(8,N'An toàn, vệ sinh lao động - Lao động - Bộ Lao động - Thương Binh và Xã hội',12,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=68&page=1'),
(8,N'Giáo dục nghề nghiệp - Lao động - Bộ Lao động - Thương Binh và Xã hội',31,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=69&page=1'),
(8,N'Người có công - Bộ Lao động - Thương Binh và Xã hội',18,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=25&page=1'),
(8,N'Bảo trợ xã hội - Xã hội - Bộ Lao động - Thương Binh và Xã hội',13,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=39&page=1'),
(8,N'Giảm nghèo - Xã hội - Bộ Lao động - Thương Binh và Xã hội',13,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=40&page=1'),
(8,N'Phòng chống tệ nạn xã hội - Xã hội - Bộ Lao động - Thương Binh và Xã hội',14,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=70&page=1'),
(8,N'Trẻ em - Xã hội - Bộ Lao động - Thương Binh và Xã hội',13,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=71&page=1'),
(8,N'Bình đẳng giới - Xã hội - Bộ Lao động - Thương Binh và Xã hội',15,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=72&page=1'),
(8,N'Thông tin cơ sở - Địa phương - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',8,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=136&page=1'),
(8,N'Chuyên đề địa phương - Địa phương - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',8,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=258&page=1'),
(8,N'Mô hình kinh nghiệm - Địa phương - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',8,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=259&page=1'),
(8,N'Kết nối thông tin - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',29,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=260&page=1'),
(8,N'Kỷ niệm các ngày lễ lớn của Đất nước - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',32,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucId=11522'),
(8,N'Công tác Đảng - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',16,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11523&page=1'),
(8,N'Công Đoàn - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',16,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11524&page=1'),
(8,N'Đoàn Thanh niên - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',16,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11525&page=1'),
(8,N'Tin tức dịch Covid-19 - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',1,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11521&page=1'),
(8,N'ASEAN Việt Nam 2020 - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',32,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11527&page=1'),
(8,N'Thanh tra LĐXH - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',32,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=42&page=1'),
(8,N'Hoạt động chung - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',2,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=43&page=1'),
(8,N'Kinh tế - Xã hội - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',17,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=74&page=1'),
(8,N'Chăm sóc người có công và công tác xã hội - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',18,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11518&page=1'),

(11,N'Tin tức sự kiện - Bộ Quốc phòng',1,'http://www.mod.gov.vn/wps/portal/!ut/p/b1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLdHP2CLJwMHQ38zT0sDDyNnZ1NjcOMDQ2CzIEKIoEKDHAARwPi9Du7O3qYmPsYGFj4uJsaeDp6hAZZBhobGzgaE9Ifrh8FVoLPBLACPE7088jPTdUvyA2NMMgyUQQAfwOf3g!!/dl4/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_FANR8B1A081F00I32T4LDI2064/ren/p=WCM_PI=1/p=ns_Z7_FANR8B1A081F00I32T4LDI2064_WCM_PreviousPageSize.4e92abb3-6db2-476b-85b7-8c31f62282a0=10/p=ns_Z7_FANR8B1A081F00I32T4LDI2064_WCM_Page.4e92abb3-6db2-476b-85b7-8c31f62282a0=/p=CTX=QCPmodQCPsa-mod-siteQCPsa-ttsk/-/'),

(14,N'Bưu chính - Bộ Thông tin và Truyền thông',22,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1747/1/Buu-chinh.html'),
(14,N'Viễn thông - Bộ Thông tin và Truyền thông',23,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1748/1/Vien-thong.html'),
(14,N'CNTT - Bộ Thông tin và Truyền thông',29,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1749/1/Ung-dung-CNTT.html'),
(14,N'ATTT - Bộ Thông tin và Truyền thông',29,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1694/1/An-toan-thong-tin.html'),
(14,N'Công nghiệp ICT - Bộ Thông tin và Truyền thông',29,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1751/1/Cong-nghiep-ICT.html'),
(14,N'Báo chí truyền thông - Bộ Thông tin và Truyền thông',32,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1752/1/Bao-chi-truyen-thong.html'),

(16,N'Hoạt động lãnh đạo Bộ - Bộ Văn hóa - Thể thao và Du lịch',2,'https://bvhttdl.gov.vn/tin-tuc-va-su-kien/hoat-dong-lanh-dao-bo.htm'),
(16,N'Chỉ đạo điều hành - Bộ Văn hóa - Thể thao và Du lịch',3,'https://bvhttdl.gov.vn/tin-tuc-va-su-kien/chi-dao-dieu-hanh.htm'),
(16,N'Bộ với các đơn vị - Bộ Văn hóa - Thể thao và Du lịch',3,'https://bvhttdl.gov.vn/tin-tuc-va-su-kien/bo-voi-cac-don-vi.htm'),
(16,N'Bộ với các địa phương - Bộ Văn hóa - Thể thao và Du lịch',3,'https://bvhttdl.gov.vn/tin-tuc-va-su-kien/bo-voi-cac-dia-phuong/trang-1150.htm'),
(16,N'Giao lưu - Hợp tác quốc tế - Bộ Văn hóa - Thể thao và Du lịch',25,'https://bvhttdl.gov.vn/tin-tuc-va-su-kien/hop-tac-quoc-te.htm'),
(16,N'Điểm báo - Bộ Văn hóa - Thể thao và Du lịch',7,'https://bvhttdl.gov.vn/su-kien-trang-chu.htm'),
(16,N'Thông tin - trao đổi - Bộ Văn hóa - Thể thao và Du lịch',7,'https://bvhttdl.gov.vn/tin-tuc-va-su-kien/thong-tin-trao-doi.htm'), 

(17,N'Tin tổng hợp - Bộ Xây dựng',1,'https://moc.gov.vn/vn/chuyen-muc/1173/tin-hoat-dong.aspx?page='),
(17,N'Tin hoạt động - Bộ Xây dựng',2,'https://moc.gov.vn/vn/chuyen-muc/1184/tin-tong-hop.aspx?page='),
(17,N'Tin cải cách hành chính - Bộ Xây dựng',26,'https://moc.gov.vn/vn/chuyen-muc/1166/tin-cai-cach-hanh-chinh.aspx?page='),
(17,N'Giới thiệu văn bản mới - Bộ Xây dựng',24,'https://moc.gov.vn/vn/chuyen-muc/1196/Gioi-thieu-van-ban-moi.aspx?page='),

(18,N'Tin hoạt động - Bộ y tế',2,'https://moh.gov.vn/hoat-dong-cua-lanh-dao-bo?p_p_id=101_INSTANCE_TW6LTp1ZtwaN&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=2&_101_INSTANCE_TW6LTp1ZtwaN_delta=20&_101_INSTANCE_TW6LTp1ZtwaN_keywords=&_101_INSTANCE_TW6LTp1ZtwaN_advancedSearch=false&_101_INSTANCE_TW6LTp1ZtwaN_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_TW6LTp1ZtwaN_cur='),
(18,N'Tin tổng hợp - Bộ y tế',1,'https://moh.gov.vn/tin-tong-hop?p_p_id=101_INSTANCE_k206Q9qkZOqn&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=1&_101_INSTANCE_k206Q9qkZOqn_delta=20&_101_INSTANCE_k206Q9qkZOqn_keywords=&_101_INSTANCE_k206Q9qkZOqn_advancedSearch=false&_101_INSTANCE_k206Q9qkZOqn_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_k206Q9qkZOqn_cur='),
(18,N'Tin địa phương - Bộ y tế',8,'https://moh.gov.vn/hoat-dong-cua-dia-phuong?p_p_id=101_INSTANCE_gHbla8vOQDuS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=2&_101_INSTANCE_gHbla8vOQDuS_delta=20&_101_INSTANCE_gHbla8vOQDuS_keywords=&_101_INSTANCE_gHbla8vOQDuS_advancedSearch=false&_101_INSTANCE_gHbla8vOQDuS_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_gHbla8vOQDuS_cur='),
(18,N'Tin liên quan - Bộ y tế',27,'https://moh.gov.vn/tin-lien-quan?p_p_id=101_INSTANCE_vjYyM7O9aWnX&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=1&_101_INSTANCE_vjYyM7O9aWnX_delta=20&_101_INSTANCE_vjYyM7O9aWnX_keywords=&_101_INSTANCE_vjYyM7O9aWnX_advancedSearch=false&_101_INSTANCE_vjYyM7O9aWnX_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_vjYyM7O9aWnX_cur='),

(19,N'Tin nổi bật - Chính phủ',1,'http://chinhphu.vn/portal/page/portal/chinhphu/trangchu/tinnoibat'),

(20,N'Hoạt động của Bộ trưởng, Chủ nhiệm - Ủy ban Dân tộc',2,'http://cema.gov.vn/tin-tuc/tin-hoat-dong/hoat-dong-cua-bo-truong.htm?p='),
(20,N'Hoạt động của Ủy ban Dân tộc - Ủy ban Dân tộc',2,'http://cema.gov.vn/tin-tuc/tin-hoat-dong/hoat-dong-cua-uy-ban.htm?p='),
(20,N'Ủy ban Dân tộc với Bộ ngành - Ủy ban Dân tộc',3,'http://cema.gov.vn/uy-ban-dan-toc-voi-bo-nganh.htm?p='),
(20,N'Ủy ban Dân tộc với địa phương - Ủy ban Dân tộc',3,'http://cema.gov.vn/uy-ban-dan-toc-voi-dia-phuong.htm?p='),
(20,N'Hoạt động của các Ban Dân tộc - Ủy ban Dân tộc',3,'http://cema.gov.vn/tin-tuc/tin-hoat-dong/hoat-dong-cua-cac-ban-dan-toc.htm?p='),
(20,N'Chủ trương - Chính sách  - Ủy ban Dân tộc',3,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/chu-truong-chinh-sach.htm?p='),
(20,N'Thời sự - Chính trị - Ủy ban Dân tộc',1,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/thoi-su-chinh-tri.htm?p='),
(20,N'Kinh tế - Xã hội - Ủy ban Dân tộc',17,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/kinh-te-xa-hoi.htm?p='),
(20,N'Y tế - Giáo dục - Ủy ban Dân tộc',27,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/y-te-giao-duc.htm?p='),
(20,N'Văn hóa - Văn nghệ - Thể thao - Ủy ban Dân tộc',28,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/van-hoa-van-nghe-the-thao.htm?p='),
(20,N'Khoa học - Công nghệ - Môi trường - Ủy ban Dân tộc',29,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/khoa-hoc-cong-nghe-moi-truong.htm?p='),
(20,N'Pháp luật - Ủy ban Dân tộc',32,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/phap-luat.htm?p='),
(20,N'Quốc tế - Ủy ban Dân tộc',25,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/quoc-te.htm?p='),
(20,N'Nghiên cứu trao đổi - Ủy ban Dân tộc',25,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/nghien-cuu-trao-doi.htm?p='),
(20,N'Gương điển hình tiên tiến - Ủy ban Dân tộc',5,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/guong-dien-hinh-tien-tien.htm?p='),
(20,N'Thông tin thị trường giá cả - Ủy ban Dân tộc',30,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/thong-tin-thi-truong-gia-ca.htm?p='),

(22,N'Lĩnh Vực Bảo Hiểm Y Tế - Bảo hiểm Xã hội Việt Nam',27,'https://baohiemxahoi.gov.vn/tintuc/Pages/linh-vuc-bao-hiem-y-te.aspx?CateID=169&date=&page='),
(22,N'Lĩnh Vực Bảo Hiểm Xã Hội - Bảo hiểm Xã hội Việt Nam',10,'https://baohiemxahoi.gov.vn/tintuc/Pages/linh-vuc-bao-hiem-xa-hoi.aspx?CateID=168&date=&page='),
(22,N'BHXHVN chung tay đẩy lùi dịch bệnh Covid-19 - Bảo hiểm Xã hội Việt Nam',1,'https://baohiemxahoi.gov.vn/tintuc/Pages/bhxhvn-chung-tay-day-lui-dich-benh-covid-19.aspx?CateID=174&date=&page='),
(22,N'Kinh tế - Xã hội - Bảo hiểm Xã hội Việt Nam',17,'https://baohiemxahoi.gov.vn/tintuc/pages/kinh-te-xa-hoi.aspx?CateID=170&date=&page='),

(24,N'Tin hợp tác quốc tế - Viện Hàn lâm Khoa học Xã hội Việt Nam',25,'https://vass.gov.vn/hop-tac-quoc-te-1.0.1'),
(24,N'Tin Hành chính - Tổ chức - Viện Hàn lâm Khoa học Xã hội Việt Nam',26,'https://vass.gov.vn/tin-hanh-chinh-to-chuc-1.0.1'),

(25,N'Tin tức sự kiện - Ủy ban quản lý vốn nhà nước tại doanh nghiệp',1,'http://cmsc.gov.vn/tin-tuc-su-kien?p_p_id=dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=_118_INSTANCE_EWtJ5M5YE6wZ__column-1&p_p_col_count=1&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_delta=25&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_keywords=&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_advancedSearch=false&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_andOperator=true&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_resetCur=false&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_cur=')

go
insert into ministry_article_category_configuration(ministry_id, article_category_type_id, article_url_xpath, article_thumbnail_xpath, page_rule, article_param_xpath) values
	(1, 2,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),

	(1,8,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),

	(1, 3,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),

	(1, 25,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),

	(1, 4,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),

	(1, 5,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),

	(1, 13,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),	
	-----
	(3, 1, 
	'//*[@id="list_news"]/div[1]/div/div/ul/li/p[1]/a/@href',	
	'//*[@id="list_news"]/div[1]/div/div/ul/li/a/img/@src',
	1,''),

	--thông cáo báo chí bộ giáo dục
	(4,	6, 
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/a/img/@src',
	1,'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div[2]/div[2]/div/a[2]/@href'),

	--thông báo bộ giáo dục
	(4, 7, 
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div[2]/div/ul/li/a/img/@src',
	1,	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div[2]/div[2]/div/a[2]/@href'),

	--tin tổng hợp bộ giáo dục 
	(4,	1,
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/a/img/@src',
	1,	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div[2]/div[2]/div/a[6]/@href'),
	
	--hoạt động lãnh đạo bộ gtvt
	(5, 2,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/div/a/img/@src',
	1,	''),

	--Tin hoạt động ngành GTVT - Bộ Giao thông vận tải
	(5, 2,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/div/a/img/@src',
	1,	''),

	--Tin đấu thầu - Bộ Giao thông vận tải
	(5, 1,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnGroupNews"]/div/div/div[2]/div/div/a/img/@src',	1,''),

	--Thông cáo báo chí - Bộ Giao thông vận tải
	(5, 7,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnGroupNews"]/div/div/div[2]/div/div/a/img/@src',	1,	''),

	--Văn bản mới ban hành - Bộ Giao thông vận tải
	(5, 24,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/div/a/img/@src',
	1,	''),

	--tin tổng hợp bộ khoa học và công nghệ
	(7, 1,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnGroupNews"]/div/div/div[2]/div/div/a/img/@src',
	1,	''),

	--điểm báo KHCN
	(7, 29,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnGroupNews"]/div/div/div[2]/div/div/a/img/@src',
	1,	''),	
	
	--việc làm bộ lao động thương binh và xã hội
	(8, 25,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--tiền lương ''
	(8, 9,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--bảo hiểm xã hội ''
	(8, 9,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--lao động ngoài nước ''
	(8, 10,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--an toàn, vệ sinh lao động ''
	(8, 11,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--giáo dục nghề nghiệp ''
	(8, 12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	
	--người có công bộ lao động thương binh và xã hội
	(8,18,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--bảo trợ xã hội ''
	(8,13,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--giảm nghèo
	(8,13,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--phòng chống tệ nạn xã hội
	(8,14,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--trẻ em
	(8,13,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--bình đẳng giới
	(8,15,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--thông tin cơ sở
	(8,8,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--chuyên đề địa phương
	(8,8,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--mô hình kinh nghiệm
	(8,8,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--kết nối thông tin
	(8,29,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	
	--kỷ niệm ngày lễ lớn
	(8,32,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[3]/a/@href'),
	
	--công tác đảng
	(8,16,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	
	--công đoàn
	(8,16,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	
	--đoàn thanh niên
	(8,16,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	
	--tin tức dịch
	(8,1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--asean vn
	(8,32,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--thanh tra ldxh
	(8,32,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--hoạt động chung	
	(8,2,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--kinh tế - xã hội
	(8,17,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--chăm sóc người có công
	(8,18,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--tin tức-sự kiện bộ quốc phòng
	(11, 1,
	'//*[@id="listArticle"]/div/div[2]/h1/a/@href',	
	'//*[@id="listArticle"]/div/div[1]/a/img/@src',1,
	''),
	
	--bưu chính bộ thông tin và truyền thông
	(14, 22,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),
	
	--viễn thông bộ thông tin và truyền thông
	(14, 23,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),

	--cntt bộ thông tin và truyền thông
	(14, 29,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),

	--attt bộ thông tin và truyền thông
	(14,29,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),

	--công nghiệp ict bộ thông tin và truyền thông
	(14, 29,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[5]/a/@href'),

	--báo chí truyền thông bộ thông tin và truyền thông
	(14,32,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),	
	
	----Hoạt động lãnh đạo Bộ - Bộ Văn hóa - Thể thao và Du lịch
	(16, 2,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[2]/a/@href',	
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[1]/a/img/@src',1,''),

	----Chỉ đạo điều hành - Bộ Văn hóa - Thể thao và Du lịch
	(16, 3,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[2]/a/@href',	
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[1]/a/img/@src',1,''),

	----Bộ với các đơn vị - Bộ Văn hóa - Thể thao và Du lịch
	(16, 3,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[2]/a/@href',	
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[1]/a/img/@src',1,''),

	----Bộ với các địa phương - Bộ Văn hóa - Thể thao và Du lịch
	(16, 3,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[2]/a/@href',	
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[1]/a/img/@src',1,''),

	----Giao lưu - Hợp tác quốc tế - Bộ Văn hóa - Thể thao và Du lịch
	(16, 25,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[2]/a/@href',	
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[1]/a/img/@src',1,''),

	----Điểm báo - Bộ Văn hóa - Thể thao và Du lịch
	(16, 7,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[2]/a/@href',	
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[1]/a/img/@src',1,''),

	----Thông tin - trao đổi - Bộ Văn hóa - Thể thao và Du lịch
	(16, 7,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[2]/a/@href',	
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/div/div[1]/a/img/@src',1,''),

	--tin tổng hợp
	(17,1,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',
	1,	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a[6]/@href'),
	--tin cải cách hành chính
	(17,2,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',
	1,'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a/@href'),
	----tin hoạt động bộ xây dựng
	(17,26,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',
	1,	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a/@href'),
	--Giới thiệu văn bản mới
	(17,24,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',
	1,	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a/@href'),

	----hoạt động lãnh đạo bộ y tế
	(18, 2,
	'//*[@id="p_p_id_101_INSTANCE_TW6LTp1ZtwaN_"]/div/div/div/div/div/div/div[2]/h3/a/@href',	
	'//*[@id="p_p_id_101_INSTANCE_TW6LTp1ZtwaN_"]/div/div/div/div/div/div/div[1]/a/img/@src',1,
	''),
	----tin tổng hợp bộ y tế
	(18, 1,
	'//*[@id="p_p_id_101_INSTANCE_k206Q9qkZOqn_"]/div/div/div/div/div/div/div[2]/h3/a/@href',	
	'//*[@id="p_p_id_101_INSTANCE_k206Q9qkZOqn_"]/div/div/div/div/div/div/div[1]/a/img/@src',1,''),
	----thông tin chỉ đạo điều hành bộ y tế
	(18,8,
	'//*[@id="p_p_id_101_INSTANCE_DOHhlnDN87WZ_"]/div/div/div/div/div/div/div[2]/h3/a/@href',	
	'//*[@id="p_p_id_101_INSTANCE_DOHhlnDN87WZ_"]/div/div/div/div/div/div/div[1]/a/img/@src',1,''),
	----hoạt động của địa phương bộ y tế
	(18,27,
	'//*[@id="p_p_id_101_INSTANCE_gHbla8vOQDuS_"]/div/div/div/div/div/div/div[2]/h3/a/@href',	
	'//*[@id="p_p_id_101_INSTANCE_gHbla8vOQDuS_"]/div/div/div/div/div/div/div[1]/a/img/@src',1,''),

	---chinh phu
	(19,1,
	'//*[@id="tinkhac"]/table/tbody/tr/td/a/@href',	
	'//*[@id="tinkhac"]/table/tbody/tr/td/img/@src',1,''),

	---Hoạt động của Bộ trưởng, Chủ nhiệm - Ủy ban Dân tộc
	(20,2,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Hoạt động của Ủy ban Dân tộc - Ủy ban Dân tộc
	(20,2,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Ủy ban Dân tộc với Bộ ngành - Ủy ban Dân tộc
	(20,3,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Ủy ban Dân tộc với địa phương - Ủy ban Dân tộc
	(20,3,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Hoạt động của các Ban Dân tộc - Ủy ban Dân tộc
	(20,3,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Chủ trương - Chính sách  - Ủy ban Dân tộc
	(20,3,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Thời sự - Chính trị - Ủy ban Dân tộc
	(20,1,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Kinh tế - Xã hội - Ủy ban Dân tộc
	(20,17,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Y tế - Giáo dục - Ủy ban Dân tộc
	(20,27,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Văn hóa - Văn nghệ - Thể thao - Ủy ban Dân tộc
	(20,28,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Khoa học - Công nghệ - Môi trường - Ủy ban Dân tộc
	(20,29,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Pháp luật - Ủy ban Dân tộc
	(20,32,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Quốc tế - Ủy ban Dân tộc
	(20,25,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Nghiên cứu trao đổi - Ủy ban Dân tộc
	(20,25,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Gương điển hình tiên tiến - Ủy ban Dân tộc
	(20,5,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div[2]/div/a/@href',	
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div[1]/div[1]/a/img/@src',1,''),

		---Thông tin thị trường giá cả - Ủy ban Dân tộc
	(20,30,
	'//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[2]/div/div/div/div[1]/a/@href',	
	'',1,''),

		----Lĩnh Vực Bảo Hiểm Y Tế - Bảo hiểm Xã hội Việt Nam
	(22, 27,
	'//*[@id="ctl00_ctl39_g_97d35d4e_1894_4db9_8173_0e02734b92b8"]/div[1]/div[2]/div/div[2]/div[2]/a/@href',	
	'//*[@id="ctl00_ctl39_g_97d35d4e_1894_4db9_8173_0e02734b92b8"]/div[1]/div[2]/div/div[1]/a/img/@src',1,
	'//*[@id="ctl00_ctl39_g_97d35d4e_1894_4db9_8173_0e02734b92b8"]/div[3]/div/ul/li[7]/a/@href'),

			----Lĩnh Vực Bảo Hiểm Xã Hội - Bảo hiểm Xã hội Việt Nam
	(22, 10,
	'//*[@id="ctl00_ctl39_g_babfa4ad_4ff5_4edb_9826_0650f32c94f9"]/div[1]/div[2]/div/div[2]/div[2]/a/@href',	
	'//*[@id="ctl00_ctl39_g_babfa4ad_4ff5_4edb_9826_0650f32c94f9"]/div[1]/div[2]/div/div[1]/a/img/@src',1,
	'//*[@id="ctl00_ctl39_g_babfa4ad_4ff5_4edb_9826_0650f32c94f9"]/div[3]/div/ul/li[7]/a/@href'),

			----BHXHVN chung tay đẩy lùi dịch bệnh Covid-19 - Bảo hiểm Xã hội Việt Nam
	(22, 1,
	'//*[@id="ctl00_ctl39_g_789593aa_9f25_43a3_a073_24c0a752728f"]/div[1]/div[2]/div/div[2]/div[2]/a/@href',	
	'//*[@id="ctl00_ctl39_g_789593aa_9f25_43a3_a073_24c0a752728f"]/div[1]/div[2]/div/div[1]/a/img/@src',1,
	'//*[@id="ctl00_ctl39_g_789593aa_9f25_43a3_a073_24c0a752728f"]/div[3]/div/ul/li[7]/a/@href'),

	----Kinh tế - Xã hội - Bảo hiểm Xã hội Việt Nam
	(22, 17,
	'//*[@id="ctl00_ctl39_g_198123bf_f632_41ed_bae0_d562d2822a9f"]/div[1]/div[2]/div/div[2]/div[2]/a/@href',	
	'//*[@id="ctl00_ctl39_g_198123bf_f632_41ed_bae0_d562d2822a9f"]/div[1]/div[2]/div/div[1]/a/img/@src',1,
	'//*[@id="ctl00_ctl39_g_198123bf_f632_41ed_bae0_d562d2822a9f"]/div[3]/div/ul/li[7]/a/@href'),

	----Tin hợp tác quốc tế - Viện Hàn lâm Khoa học Xã hội Việt Nam
	(24, 25,
	'//*[@id="ctl00_m_g_e0136335_967d_4b76_983c_c60f79107a7f"]/div/div[2]/div/div/p/a/@href',	
	'//*[@id="ctl00_m_g_e0136335_967d_4b76_983c_c60f79107a7f"]/div/div[2]/div/div/a/img/@data-original',1,
	'//*[@id="ctl00_m_g_e0136335_967d_4b76_983c_c60f79107a7f"]/div/div[2]/div/div[11]/div/a[6]/@href'),

	----Tin Hành chính - Tổ chức - Viện Hàn lâm Khoa học Xã hội Việt Nam
	(24, 26,
	'//*[@id="ctl00_m_g_7145028f_cb69_4dea_9572_d2a1e41740e8"]/div/div[2]/div/div/p/a/@href',	
	'//*[@id="ctl00_m_g_7145028f_cb69_4dea_9572_d2a1e41740e8"]/div/div[2]/div/div/a/img/@data-original',1,
	'//*[@id="ctl00_m_g_7145028f_cb69_4dea_9572_d2a1e41740e8"]/div/div[2]/div/div[11]/div/a[6]/@href'),

	----Tin tức sự kiện - Ủy ban quản lý vốn nhà nước tại doanh nghiệp
	(25, 1,
	'//*[@id="p_p_id_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_"]/div/div/div/h2/a/@href',	
	'//*[@id="p_p_id_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_"]/div/div/div/a/img/@src',1,
	'//*[@id="_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href')

go
delete from ministry_article_detail_configuration
go 
insert into ministry_article_detail_configuration(ministry_id,article_title_xpath,article_description_xpath,article_time_xpath,
											article_author_xpath,article_content_xpath) values
	--Bộ công an
	(1,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/h1/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[2]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[1]/div[1]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[5]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[4]/div/p/text()'),	
	--Bộ nội vụ
	(3,
	'//*[@id="news_details"]/div[3]/div/div[1]/h1/text()',
	'//*[@id="show_description"]/text()',
	'//*[@id="news_details"]/div[3]/div/div[1]/div[1]/p/text()',
	'//*[@id="show_content"]/b[4]/text()',
	'//*[@id="show_content"]/text()'),
	--Bộ giáo dục
	(4,
	'//*[@id="news-title"]/text()',
	'//*[@id="news-des"]/text()',
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div[2]/div/div[1]/div/div[1]/p/span[1]/text()',
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div[2]/div/div[1]/div/p/text()',
	'//*[@id="news-detail"]/div/p/text()'),	
	--Bộ giao thông vận tải
	(5,
	'//*[@id="divArticleDescription3"]/h1/text()',
	'//*[@id="divArticleDescription1"]/p/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_275cd07f_7dd8_4f62_97b3_19577a1ec443_ctl00_pnHide"]/span/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_275cd07f_7dd8_4f62_97b3_19577a1ec443_ctl00_pnNguontin"]/p/font/text()',
	'//*[@id="divArticleDescription2"]/p/span/span/text()'),	
	--Bộ khoa học công nghệ
	(7,
	'//*[@id="divArticleDescription3"]/h1/text()',
	'//*[@id="divArticleDescription1"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_275cd07f_7dd8_4f62_97b3_19577a1ec443_ctl00_pnHide"]/div[1]/span/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_275cd07f_7dd8_4f62_97b3_19577a1ec443_ctl00_pnNguontin"]/p/font/text()',
	'//*[@id="divArticleDescription2"]/div/p/text()'),	
	--Bộ lao động - thương binh xã hội
	(8,
	'//*[@id="ctl00_ctl50_g_8ad360dc_c37c_41f7_aa64_94b051f219f8"]/div[1]/div[1]/h1/text()',
	'//*[@id="divArticleDescription"]/p[1]/text()',
	'//*[@id="ctl00_ctl50_g_8ad360dc_c37c_41f7_aa64_94b051f219f8"]/div[1]/div[1]/p/text()',
	'//*[@id="divArticleDescription"]/div[10]/strong/em/text()',
	'//*[@id="divArticleDescription"]/div/text()'),	
	--Bộ quốc phòng
	(11,
	'//*[@class="moduleContentBg"]/div/h1/span/text()',
	'//*[@class="moduleContentBg"]/div/div[1]/p[1]/text()',
	'//*[@class="moduleContentBg"]/div/h2/text()',
	'//*[@class="moduleContentBg"]/div/div[2]/b/text()',
	'//*[@class="moduleContentBg"]/div/div[1]/p/text()'),	
	--Bộ thông tin truyền thông
	(14,
	'//*[@id="news_content"]/div[1]/h1/text()',
	'//*[@id="divArticleDescription"]/p/text()',
	'//*[@id="news_content"]/div[1]/div[1]/div[1]/div/text()',
	'//*[@id="news_content"]/div[1]/p[1]/strong/text()',
	'//*[@id="divArticleContent"]/p/text()'),	
	--Bộ Văn hóa - Thể thao và Du lịch
	(16,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div/div[2]/h2/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div/div[2]/p[1]/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div/div[2]/span/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div/div[2]/p[2]/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div/div[2]/div//text()'),
	--Bộ xây dựng
	(17,
	'//*[@id="divArticleDescription3"]/h1/text()',
	'//*[@id="divArticleDescription1"]/p/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_9c0a5a28_df68_408d_abaa_1ef0666cf35c_ctl00_pnHide"]/div[2]/span/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_9c0a5a28_df68_408d_abaa_1ef0666cf35c_ctl00_pnNguontin"]/p/font/text()',
	'//*[@id="divArticleDescription2"]/p/text()'),	
	--Bộ y tế
	(18,
	'//*[@class="contentDetail"]/div[1]/h3/text()',
	'//*[@class="sapo"]/strong/text()',
	'//*[@class="contentDetail"]/div[2]/div/p/text()',
	'//*[@class="journal-content-article"]/h2[20]/span/em/span/text()',
	'//*[@class="journal-content-article"]/h2/span//text()'),	
	--chính phủ
	(19,
	'//*[@id="aspnetForm"]/div[9]/div[1]/div[1]/h1/text()',
	'//*[@id="aspnetForm"]/div[9]/div[1]/div[2]/div[2]/div[1]/text()',
	'//*[@id="aspnetForm"]/div[9]/div[1]/div[1]/p/text()',
	'//*[@id="aspnetForm"]/div[9]/div[1]/div[2]/div[2]/div[2]/strong/text()',
	'///*[@id="aspnetForm"]/div[9]/div[1]/div[2]/div[2]/p/text()'),	
	--Ủy ban dân tộc
	(20,
	'//*[@id="BodyContent_ctl00_ctl01_newsTitle"]/text()',
	'//*[@id="BodyContent_ctl00_ctl01_newsContent"]/text()',
	'//*[@id="BodyContent_ctl00_ctl01_lblDate"]/text()',
	'//*[@id="BodyContent_ctl00_ctl02_lblNguonThongTin"]/text()',
	'//*[@id="divNewsDetails"]/p/text()'),		
	--Bảo hiểm xã hội
	(22,
	'//*[@class="col-xs-12 none-padding"]/p/text()',
	'//*[@id="contenttin"]/p/text()',
	'//*[@class="col-xs-6 none-padding sukien"]/p/text()',
	'//*[@class="tacgia"]/text()',
	'//*[@id="contenttin"]/div/p/text()'),		
	--viện hàn lâm khxh
	(24,
	'//*[@class="box-news"]/div/div/div/div/h1/text()',
	'//*[@class="box-news"]/div/div/div/div/div/p[2]/text()',
	'//*[@class="box-news"]/div/div/div/div/div/p[1]/text()',
	'//*[@id="anhnoidungdetail"]/p/strong/text()',
	'//*[@id="anhnoidungdetail"]/p/text()'),
	--ủy ban quản lý vốn nhà nước
	(25,
	'//*[@id="testabc"]/div[1]/h1/text()',
	'//*[@id="testabc"]/p/strong/text()',
	'//*[@id="testabc"]/div[1]/p/text()',
	'//*[@id="testabc"]/div[2]/p/text()',
	'//*[@id="testabc"]/div[2]/div/p/text()')

go
insert into legislation_category_type (legislation_category_type_name) values
	(N'Văn bản pháp quy'),
	(N'Văn bản điều hành'),
	(N'Hệ thống văn bản'),
	(N'Văn bản quy phạm pháp luật'),
	(N'Văn bản chỉ đạo - điều hành'),
	(N'Văn bản chỉ đạo điều hành'),
	(N'Văn bản pháp luật'),
	(N'Văn bản chính sách mới'),
	(N'Văn bản chỉ đạo của ngành'),
	(N'Văn bản ngoài ngành')

go	
INSERT INTO legislation_category_info (ministry_id,legislation_name,legislation_category_type_id,legislation_link_root)
VALUES
(1,N'Văn bản quy phạm pháp luật -  Bộ công an',4,'http://bocongan.gov.vn/van-ban/van-ban-quy-pham.html'),

(3,N'Văn bản quy phạm pháp luật - Bộ nội vụ',4,'https://doc.moha.gov.vn/Default.aspx?TabID=1736&p='),

(4,N'Văn bản quy phạm pháp luật -  Bộ giáo dục và đào tạo',4,'https://moet.gov.vn/van-ban/vanban/Pages/default.aspx?Page='),
(4,N'Văn bản chỉ đạo, điều hành -  Bộ giáo dục và đào tạo',5,'https://moet.gov.vn/van-ban/vbdh/Pages/default.aspx?Page='),

(5,N'Văn bản chỉ đạo điều hành - Bộ giao thông vận tải',6,'https://mt.gov.vn/vn/Pages/Vanbanphapluat.aspx?TypeVB=0'),

(7,N'Văn bản chỉ đạo, điều hành - Bộ khoa học công nghệ',1,'http://www.most.gov.vn/vn/Pages/Vanbanphapluat.aspx'),
(7,N'Văn bản pháp quy - Bộ giao khoa học công nghệ',5,'https://www.most.gov.vn/vn/Pages/VBPQ.aspx?Machuyende=VB&ChudeID=73'),

(8,N'Văn bản chỉ đạo điều hành - Bộ lao động - thương binh và xã hội',5,'http://www.molisa.gov.vn/Pages/VanBan/ChiDaoDieuHanh.aspx'),

(11,N'Văn bản pháp luật - Bộ quốc phòng',7,'http://www.mod.gov.vn/wps/portal/qlcd/vbpl/searchhome'),

(14,N'Văn bản chỉ đạo điều hành - Bộ thông tin và truyền thông',4,'https://www.mic.gov.vn/mic_2020/Pages/VanBan/danhsachvanban.aspx?LVB=100'),
(14,N'Văn bản quy phạm pháp luật - Bộ thông tin và truyền thông',5,'https://www.mic.gov.vn/mic_2020/Pages/VanBan/danhsachvanban.aspx?LVB=100'),

(16,N'Văn bản chỉ đạo điều hành - Bộ văn hóa thể thao và du lịch',4,'https://bvhttdl.gov.vn/van-ban-quan-ly.htm?coquan=0&nhom=2&theloai=0&linhvuc=0&year=0&keyword=&pageIndex=	'),
(16,N'Văn bản quy phạm pháp luật - Bộ văn hóa thể thao và du lịch',5,'https://bvhttdl.gov.vn/van-ban-quan-ly.htm?coquan=0&nhom=1&theloai=0&linhvuc=0&year=0&keyword=&pageIndex='),

(17,N'Văn bản điều hành - Bộ xây dựng',2,'https://moc.gov.vn/vn/Pages/Vanbanphapluat.aspx?TypeVB=1'),

(20,N'Văn bản chỉ đạo điều hành - Ủy ban dân tộc',5,'http://csdl.ubdt.gov.vn/noidung/Pages/vanbanden.aspx?type=adv&RowPerPage=10&UrlListProcess=/noidung/vanbandt/Lists/UBDTVanBanDen&PageStep=2&vbdLoaiVanBan=0&vbdLinhvuc=0&vbdCoQuanBanHanh=0&vbdTrichYeu=&vbdToanVan=&vbdSoKyHieu=&TuNgay=&DenNgay=&vbdDanToc=0&vbdDiaBanApDung=&Page='),

(22,N'Văn bản chỉ đạo của Ngành - Bảo hiểm xã hội',9,'https://baohiemxahoi.gov.vn/vanban/Pages/default.aspx?LinhVuc=0&DanhMucBanHanh=3&CoQuanBanHanh=0&order=ID&TypeOfOrder=False&tenvanban=&NgayBanHanh=&FormSearch=&selectedChekBox=&LoaiNgayThang=0&FromDate=&ToDate=&NamBanHanh=0&Page='),
(22,N'Văn bản ngoài Ngành - Bảo hiểm xã hội',10,'https://baohiemxahoi.gov.vn/vanban/Pages/default.aspx?LinhVuc=0&DanhMucBanHanh=4&CoQuanBanHanh=0&order=ID&TypeOfOrder=False&tenvanban=&NgayBanHanh=&FormSearch=&selectedChekBox=&LoaiNgayThang=0&FromDate=&ToDate=&NamBanHanh=0&Page='),

(25,N'Văn bản pháp luật - Ủy ban quản lý vốn nhà nước tại doanh nghiệp',7,'http://cmsc.gov.vn/van-ban-phap-quy?p_p_id=dsvanbanphapquy_WAR_vnpteportalappportlet&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=_118_INSTANCE_EWtJ5M5YE6wZ__column-1&p_p_col_count=1&_dsvanbanphapquy_WAR_vnpteportalappportlet_keyword=&_dsvanbanphapquy_WAR_vnpteportalappportlet_loaiVanBanId=0&_dsvanbanphapquy_WAR_vnpteportalappportlet_coQuanBanHanhId=0&_dsvanbanphapquy_WAR_vnpteportalappportlet_linhVucId=0&_dsvanbanphapquy_WAR_vnpteportalappportlet_startDate=&_dsvanbanphapquy_WAR_vnpteportalappportlet_endDate=&_dsvanbanphapquy_WAR_vnpteportalappportlet_delta=10&_dsvanbanphapquy_WAR_vnpteportalappportlet_keywords=&_dsvanbanphapquy_WAR_vnpteportalappportlet_advancedSearch=false&_dsvanbanphapquy_WAR_vnpteportalappportlet_andOperator=true&_dsvanbanphapquy_WAR_vnpteportalappportlet_resetCur=false&_dsvanbanphapquy_WAR_vnpteportalappportlet_cur=')

go 
insert into ministry_legislation_category_configuration (ministry_id, legislation_category_type_id, legislation_url_xpath, page_rule, legislation_param_xpath) values
	--văn bản bộ công an
	(1, 4,'//*[@id="parentHorizontalTab"]/div/div/div/div/a/@href',1,''),	

	--văn bản quy phạm pháp luật bộ nội vụ
	(3, 4,'//*[@class="title"]/a/@href',1,'//*[@class="pagination"]/ul/li[7]/a/@href'),	

	--văn bản quy phạm pháp luật bộ giáo dục
	(4, 4,'//*[@id="ctl00_ctl24_g_025164b8_2c99_46cb_ad7d_e00c79535b91"]/div/div/div/div/div/a/@href',
	1,'//*[@id="ctl00_ctl24_g_025164b8_2c99_46cb_ad7d_e00c79535b91"]/div/div/div/div/a[6]/@href'),

	--văn bản chỉ đạo điều hành bộ giáo dục
	(4, 5,'//*[@id="ctl00_ctl24_g_71a175fa_a10b_477d_ab07_a5477af56ca9"]/div/div/div/div/div/a/@href',
	1,'//*[@id="ctl00_ctl24_g_71a175fa_a10b_477d_ab07_a5477af56ca9"]/div/div/div/div/a[6]/@href'),
	
	--văn bản điều hành bộ gtvt
	(5, 6,'//*[@class="CSSTableGenerator"]/table/tr/td/div/a/@href',1,''),

	--văn bản pháp quy bộ khcn
	(7, 1,'//*[@id="tabVB_lv1_01"]/ul/li/div/p/a/@href',1,''),

	--văn bản chỉ đạo, điều hành bộ khcn 
	(7, 5,'//*[@class="CSSTableGenerator"]/table/tr/td/div/a/@href',1,
	'//*[@class="Paging Paging_Footer_Table_Legal"]/a[2]/@href'),

	--văn bản quy phạm pháp luật bộ lao động
	(8, 5,'//*[@id="ctl00_ctl50_g_fca06a59_0cbe_4eec_81f2_15f675d04c66"]/div/div[2]/table/tbody/tr/td[3]/a/@href',
	1,''),

	--văn bản pháp luật bộ quốc phòng
	(11, 7,'//*[@class="bgTable"]/td[4]/a[1]/@href',1,'//*[@class="page"]/a/@href'), 

	--văn bản quy phạm pháp luật bộ thông tin truyền thông
	(14, 4,'//*[@class="table-vb"]/tbody/tr/td/a/@href',1,''),

	--văn bản điều hành bộ thông tin truyền thông
	(14, 5,	'//*[@class="table-vb"]/tbody/tr/td/a/@href',1,	''),

	--văn bản quy phạm pháp luật bộ văn hóa thể thao và du lịch
	(16, 4,	'//*[@class="table-data"]/tr/td/a/@href',1,	''),

	--văn bản điều hành bộ văn hóa thể thao và du lịch
	(16, 5,	'//*[@class="table-data"]/tr/td/a/@href',1,''), 

	--văn bản điều hành bộ xây dựng
	(17, 2,	'//*[@class="link_sokyhieu"]/@href',1,''), 
	
	--văn bản chỉ đạo điều hành ủy ban dân tộc
	(20, 5,	'//*[@id="list-container"]/table/tr/td/a/@href',1,'//*[@id="paging"]/div/div/a[5]/@href'), 

	--văn bản chỉ đạo của ngành bảo hiểm xã hội
	(22, 9,	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div/div/div/div/div/div/a/@href',1,
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div/div/div/div/ul/li[7]/a/@href'),

	--văn bản ngoài Ngành bảo hiểm xã hội
	(22, 10,'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div/div/div/div/div/div/a/@href',
	1,'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div/div/div/div/ul/li[7]/a/@href'),

	--văn bản ngoài ủy ban quản lý vốn nhà nước
	(25, 7,	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div/div/table/tbody/tr/td/a/@href',
	1,'//*[@id="_dsvanbanphapquy_WAR_vnpteportalappportlet_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href')

go
insert into ministry_legislation_detail_configuration(ministry_id, legislation_name_xpath, legislation_so_hieu_van_ban_xpath, 
			legislation_ngay_ban_hanh_xpath, legislation_ngay_hieu_luc_xpath, 
			legislation_trich_yeu_xpath, legislation_co_quan_ban_hanh_xpath, legislation_nguoi_ky_xpath, 
			legislation_loai_van_ban_xpath, legislation_tinh_trang_xpath, legislation_link_download_xpath) values
	--Bộ công an - văn bản quy phạm pháp luật
	(1,
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[6]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[7]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[4]/td[2]/text()',	
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[5]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[3]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[8]/td[2]/text()',
	'//*[@id="A2"]/@href'
	),

	--Bộ nội vụ văn bản vi phạm pháp luật
	(3,
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[1]/td/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[2]/td[4]/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[3]/td[4]/text()',	
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[1]/td/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[6]/td[2]/ul/li/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[6]/td[2]/ul/li/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[3]/td[2]/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_komat"]/div/div/div/div[1]/span/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divtaive"]/ul/li[1]/a/@href'
	),	

	--Bộ giáo dục -- văn bản quy phạm pháp luật 
	(4,
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[2]/td[4]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[4]/td[4]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[4]/td[2]/span[1]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[4]/td[2]/span[2]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[3]/td[2]/text()',
	'//*[@id="content_1"]/div/div/div[1]/ul/li[1]/text()',
	'//*[@id="ctl00_ctl24_g_a9eee66b_a86f_4cc0_b32d_539fafedbf9b"]/div[1]/div[1]/div/div/ul/li[3]/a/@href'
	),

	--Bộ gtvt -- văn bản điều hành
	(5,
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4"]/div[1]/ul/li[4]/a/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblSoKyHieu"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNgayBanHanh"]/text()',
	'', 
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNoiDung"]/text()',
	'//*[@id="row_donvibanhanh_chinh"]/td[2]/text()',
	'//*[@id="row_donvibanhanh_chinh"]/td[3]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblLoaiVanBan"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblHieuluc"]/text()',
	'//*[@id="row_file"]/td[2]/span/strong/a/@href'
	),
	
	--Bộ khcn văn bản chỉ đạo điều hành
	(7,
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNoiDung"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblSoKyHieu"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNgayBanHanh"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNgayHieuLuc"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNoiDung"]/text()',
	'//*[@id="row_donvibanhanh_chinh"]/td[2]/text()',
	'//*[@id="row_donvibanhanh_chinh"]/td[3]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblLoaiVanBan"]/text()',
	'', 
	'//*[@id="row_file"]/td[2]/strong/a/@href'
	),
	
	----Bộ lao động văn bản chỉ đạo điều hành
	(8,
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[1]/td[2]/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[3]/td[2]/text()',
	'', 
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[6]/td[2]/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[7]/td[2]/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[4]/td[2]/text()',
	'',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[10]/td[2]/p/a/@href'
	),	

	--Bộ quốc phòng văn bản pháp luật
	(11,
	'//*[@id="tabother2"]/table/tr[1]/th[2]/text()',
	'//*[@id="tabother2"]/table/tr[2]/td[2]/text()',
	'//*[@id="tabother2"]/table/tr[3]/td[2]/text()', 
	'//*[@id="tabother2"]/table/tr[4]/td[2]/text()',
	'//*[@id="tabother2"]/table/tr[1]/th[2]/text()',
	'//*[@id="tabother2"]/table/tr[6]/td[2]/text()',
	'//*[@id="tabother2"]/table/tr[8]/td[2]/text()',
	'//*[@id="tabother2"]/table/tr[7]/td[2]/text()',
	'', 
	''
	),

	--Bộ thông tin truyền thông văn bản qppl
	(14,
	'//*[@class="main_vbtable"]/table/tr[1]/td[2]/text()',
	'//*[@class="main_vbtable"]/table/tr[1]/td[2]/text()',
	'//*[@class="main_vbtable"]/table/tr[3]/td[2]/text()',
	'//*[@class="main_vbtable"]/table/tr[4]/td[2]/text()',	
	'//*[@class="main_vbtable"]/table/tr[2]/td[2]/text()',
	'//*[@class="main_vbtable"]/table/tr[8]/td[2]/text()',
	'//*[@class="main_vbtable"]/table/tr[9]/td[2]/text()',
	'//*[@class="main_vbtable"]/table/tr[6]/td[2]/text()',
	'//*[@class="main_vbtable"]/table/tr[5]/td[2]/text()',
	'//*[@class="main_vbtable"]/table/tr/td/p/a/@href' 
	),

	--Bộ thể thao du lịch vb qppl
	(16,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/h3/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[1]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[2]/td/text()',
	'',	
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[4]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[5]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[3]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[6]/td/text()',
	'', 
	'' 
	),

	--Bộ XD
	(17,
	'//*[@id="ctl00_SPWebPartManager1_g_23baf01f_6230_4016_9ca4_72fe577b3490_ctl00_lblNoiDung"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_23baf01f_6230_4016_9ca4_72fe577b3490_ctl00_lblSoKyHieu"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_23baf01f_6230_4016_9ca4_72fe577b3490_ctl00_lblNgayBanHanh"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_23baf01f_6230_4016_9ca4_72fe577b3490_ctl00_lblNgayHieuLuc"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_23baf01f_6230_4016_9ca4_72fe577b3490_ctl00_lblNoiDung"]/text()',
	'//*[@id="row_donvibanhanh_chinh"]/td[2]/text()',
	'//*[@id="row_donvibanhanh_chinh"]/td[3]/text()',
	'',
	'', 
	'//*[@id="row_file"]/td[2]/span/strong/a/@href'
	),

	--Ủy ban dân tộc văn bản
	(20,
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[5]/td[2]/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[1]/td[2]/p/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[3]/td[2]/text()',
	'',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[5]/td[2]/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[6]/td[2]/ul/li/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[8]/td[2]/ul/li/text()',
	'',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[2]/td[2]/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[2]/tr/td[2]/a/@href' 
	),

	-- Bảo hiểm xã hội vb nói chung
	(22,
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[1]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[4]/strong/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[2]/div[1]/div[2]/strong/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[2]/div[2]/div[2]/strong/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[4]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[1]/div[2]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[1]/div[5]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[1]/div[1]/div[2]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[2]/div[3]/div[2]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[1]/div[4]/div[2]/div/a/@href' 
	),

	-- Ủy ban quản lý vốn nhà nước văn bản nói chung
	(25,
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[1]/div/h1/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[1]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[2]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[3]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[5]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[6]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[4]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[7]/td[2]/text()',
	'', 
	'//tr[8]//a/@href' 
	)

go
use WebDB

select * from article_info, ministry_info where article_info.ministry_id = ministry_info.ministry_id and ministry_info.ministry_name like N'%Bộ Công an%'

select * from article_info where ministry_id = 1

select * from legislation_info

SELECT MAX(LEN(article_content)) from article_info

select * from ministry_article_category_configuration where ministry_id = 1

select page_rule, legislation_param_xpath,ministry_id, legislation_url_xpath from ministry_legislation_category_configuration where ministry_id = 5 and legislation_category_type_id = 6

go
delete from article_info 

go
delete from legislation_info 

--go
--use master
--drop database WebDB


