use master
create database WebDB

go
use WebDB

go
create table article_info(
	article_id int identity (1,1) PRIMARY KEY,
	category_id int,
	article_url varchar(1000),
	article_title nvarchar(200),
	article_description nvarchar(500),
	article_time varchar(10),
	article_author nvarchar(100),
	article_content nvarchar(max),
	article_tag nvarchar(100),
	article_thumbnail_link varchar(500),
    article_title_html varchar(200),
    article_description_html varchar(1000),
    article_time_html varchar(2000),
    article_author_html varchar(200),
    article_content_html varchar(max),
    article_tag_html varchar(200),
    article_thumbnail_link_html varchar(200),
    article_html varchar(max)
)

go
create table article_img(
	article_img_id int identity (1,1),
	article_id int, 
	article_img_link varchar(500)
)

go
create table legislation_info(
	legislation_id int identity (1,1) PRIMARY KEY,
	ministry_id int,
	legislation_name varchar(200),	
	legislation_url varchar(500),	
	so_hieu_van_ban varchar(20),
	ngay_ban_hanh varchar(10),
	ngay_hieu_luc varchar(10),
	ngay_ky varchar(10),
	trich_yeu nvarchar(100),
	co_quan_ban_hanh nvarchar(100),
	nguoi_ky nvarchar(50),
	loai_van_ban nvarchar(50),
	tinh_trang nvarchar(50),
	link_download varchar(100)
)

go
create table legislation_configuration (
	ministry_id int,
	legislation_name_xpath varchar(200),
	legislation_so_hieu_van_ban varchar(200),
	legislation_ngay_ban_hanh varchar(200),
	legislation_ngay_hieu_luc varchar(200),
	legislation_ngay_ky varchar(200),
	legislation_trich_yeu varchar(200),
	legislation_co_quan_ban_hanh varchar(200),
	legislation_nguoi_ky varchar(200),
	legislation_loai_van_ban varchar(200),
	legislation_tinh_trang varchar(200),
	legislation_link_download varchar(200)
)

select legislation_name_xpath, legislation_so_hieu_van_ban, legislation_ngay_ban_hanh, legislation_ngay_hieu_luc, 
	   legislation_ngay_ky, legislation_trich_yeu, legislation_co_quan_ban_hanh, legislation_nguoi_ky,
	   legislation_loai_van_ban, legislation_tinh_trang from legislation_configuration where ministry_id = $

go
create table ministry_info(
	ministry_id int identity (1,1) PRIMARY KEY,
	ministry_name nvarchar(100)
)

go
create table category_info(
	category_id int identity (1,1) PRIMARY KEY,
	ministry_id int,
	category_name nvarchar (200),
	category_type_id int,
	category_link_root varchar(1000),
	page_param int	
)

go
create table legislationinfo(
	legislation_id int identity (1,1) PRIMARY KEY,
	ministry_id int,
	legislation_name nvarchar (200),
	legislation_type_id int,
	legislation_link_root varchar(1000),	
)

go
create table legislation_type(
	legislation_type_id int identity (1,1) PRIMARY KEY,
	legislation_type_name nvarchar(100)
)

go
create table ministry_category_configuration (
	ministry_id int,			
	category_id int,
	article_url_xpath varchar(200),
	article_thumbnail_xpath varchar(200),
	page_rule int,
	schedule_minute int,
	article_param_xpath varchar(200)
)

go
create table ministry_legislation_configuration (
	ministry_id int,			
	legislation_id int,
	legislation_url_xpath varchar(200),
	page_rule int,
	schedule_minute int,
	legislation_param_xpath varchar(200)
)

go
create table ministry_articles_configuration (
	ministry_id int,
	article_title_xpath varchar(200),
	article_description_xpath varchar(200),
	article_time_xpath varchar(200),
	article_author_xpath varchar(200),
	article_content_xpath varchar(200),
	article_tag_xpath varchar(200)
)

go
create table category_type(
	category_type_id int identity (1,1) PRIMARY KEY,
	category_type_name nvarchar(100)
)

select ministry_id, legislation_url_xpath from ministry_legislation_configuration where ministry_id = 1

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
	(N'Văn phòng Chính phủ'),
	(N'Bảo hiểm Xã hội Việt Nam'),
	(N'Viện Hàn lâm Khoa học và Công nghệ Việt Nam'),
	(N'Viện Hàn lâm Khoa học Xã hội Việt Nam'),
	(N'Ủy ban quản lý vốn nhà nước tại doanh nghiệp')

go
insert into category_type(category_type_name) values
	(N'Thời sự'),
	(N'Hoạt động'),
	(N'Quốc tế'),
	(N'Phát triển nguồn nhân lực'),
	(N'Thông tin họp báo'),
	(N'Bản tin Thị trường Nông Lâm Thủy sản'),
	(N'70 năm ngành Công Thương'),
	
	(N'Hoạt động của Bộ'),
	(N'Hoạt động của địa phương'),
	(N'Chỉ đạo điều hành'),
	(N'Thông tin đối ngoại'),
	(N'Tin an ninh trật tự'),
	(N'Người tốt, việc tốt'),
	(N'Hoạt động xã hội'),
	
	(N'Thông cáo'),
	(N'Thông báo'),
	(N'Tin tổng hợp'),
	(N'Tin video'),
	(N'Tin audio'),
	(N'Tin địa phương'),
	
	(N'Hoạt động lãnh đạo'),
	(N'Tin hoạt động ngành GTVT'),
	(N'Tin đấu thầu'),
	(N'Thông cáo báo chí'),
	(N'Văn bản mới ban hành'),
	(N'Công trình giao thông'),
	(N'Video'),
	
	(N'Thông tin KT-XH'),
	(N'Số liệu KT_XH'),
	(N'Chỉ tiêu KT-XH'),
	
	(N'Điểm báo KH&CN'),
	
	(N'Việc làm - Lao động'),
	(N'Tiền lương - Lao động'),
	(N'Bảo hiểm xã hội - Lao động'),
	(N'Lao động ngoài nước - Lao động'),
	(N'An toàn, vệ sinh lao động - Lao động'),
	(N'Giáo dục nghề nghiệp - Lao động'),
	(N'Người có công'),
	(N'Bảo trợ xã hội - Xã hội'),
	(N'Giảm nghèo - Xã hội'),
	(N'Phòng chống tệ nạn xã hội - Xã hội'),
	(N'Trẻ em - Xã hội'),
	(N'Bình đẳng giới - Xã hội'),
	(N'Thông tin cơ sở - Địa phương - Cơ sở'),
	(N'Chuyên đề địa phương - Địa phương - Cơ sở'),
	(N'Mô hình kinh nghiệm - Địa phương - Cơ sở'),
	(N'Kết nối thông tin - Địa phương - Cơ sở'),
	(N'Kỷ niệm các ngày lễ lớn của Đất nước - Đảng - Đoàn thể'),
	(N'Công tác Đảng - Đảng - Đoàn thể'),
	(N'Công Đoàn - Đảng - Đoàn thể'),
	(N'Đoàn Thanh niên - Đảng - Đoàn thể'),
	(N'Tin tức dịch Covid-19 - Các vấn đề khác'),
	(N'ASEAN Việt Nam 2020 - Các vấn đề khác'),
	(N'Thanh tra LĐXH - Các vấn đề khác'),
	(N'Hoạt động chung - Các vấn đề khác'),
	(N'Kinh tế - Xã hội - Các vấn đề khác'),
	(N'Chăm sóc người có công và công tác xã hội - Các vấn đề khác'),

	(N'Tin tức sự kiện'),
	(N'Tin chỉ đạo điều hành'),

	(N'Nông nghiệp - Tin chuyên ngành'),
	(N'Lâm nghiệp - Tin chuyên ngành'),
	(N'Thủy lợi - Tin chuyên ngành'),
	(N'Phòng chống thiên tai - Tin chuyên ngành'),
	(N'Thủy sản - Tin chuyên ngành'),
	(N'Quản lý chất lượng - Tin chuyên ngành'),
	(N'Chế biến và thị trường - Tin chuyên ngành'),
	(N'Phát triển nông thôn - Tin chuyên ngành'),
	(N'Khuyến nông - Tin chuyên ngành'),

	(N'Hội nhập quốc tế'),
	(N'Tham vấn chính sách TN&MT'),

	(N'Bưu chính'),
	(N'Viễn thông'),	
	(N'CNTT'),
	(N'ATTT'),
	(N'Công nghiệp ICT'),
	(N'Báo chí truyền thông'),

	(N'Văn bản chính sách mới'),
	(N'Chỉ đạo điều hành'),
	(N'Nghiên cứu trao đổi'),
	(N'Thông tin khác'),

	(N'Bộ với các đơn vị'),
	(N'Bộ với các địa phương'),
	(N'Giao lưu - Hợp tác quốc tế'),
	(N'Điểm báo'),
	(N'Thông tin - trao đổi'),

	(N'Tin hoạt động'),
	(N'Tin cải cách hành chính'),
	(N'Giới thiệu văn bản mới'),

	(N'Tin liên quan'),

	(N'Tin nổi bật'),

	(N'Hoạt động của Bộ trưởng, Chủ nhiệm'),
	(N'Hoạt động của Ủy ban Dân tộc'),
	(N'Ủy ban Dân tộc với Bộ ngành'),
	(N'Ủy ban Dân tộc với địa phương'),
	(N'Hoạt động của các Ban Dân tộc'),
	(N'Chủ trương - Chính sách '),
	(N'Thời sự - Chính trị'),
	(N'Kinh tế - Xã hội'),
	(N'Y tế - Giáo dục'),
	(N'Văn hóa - Văn nghệ - Thể thao'),
	(N'Khoa học - Công nghệ - Môi trường'),
	(N'Pháp luật'),
	(N'Gương điển hình tiên tiến'),
	(N'Thông tin thị trường giá cả'),

	(N'Tin tức hoạt động của Viện hàn lâm KHCNVN'),
	(N'Tin khoa học - Công nghệ trong nước'),
	(N'Nghiên cứu cơ bản'),
	(N'Nghiên cứu và Phát triển công nghệ'),
	(N'Điều tra cơ bản'),
	(N'Tin Khoa học - Công nghệ quốc tế'),

	(N'Tin tức'),

	(N'Tin hợp tác quốc tế'),
	(N'Tin tức đào tạo'),
	(N'Tin hành chính')

INSERT INTO category_info(ministry_id,category_name,category_type_id,category_link_root)
VALUES
(2,N'Thời sự - Bộ Công Thương',1,'http://www.moit.gov.vn/web/guest/thoi-su?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur='),
(2,N'Hoạt động - Bộ Công Thương',2,'http://www.moit.gov.vn/web/guest/hoat-dong?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur='),
(2,N'Quốc tế - Bộ Công Thương',3,'http://www.moit.gov.vn/web/guest/quoc-te?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur='),
(2,N'Phát triển nguồn nhân lực - Bộ Công Thương',4,'http://www.moit.gov.vn/web/guest/phat-trien-nguon-nhan-luc?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur='),
(2,N'Thông tin họp báo - Bộ Công Thương',5,'http://www.moit.gov.vn/web/guest/thong-tin-hop-bao?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur='),
(2,N'70 năm ngành Công Thương - Bộ Công Thương',7,'http://www.moit.gov.vn/web/guest/70-nam-nganh-cong-thuong?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur='),

(1,N'Hoạt động của Bộ - Bộ Công An',8,'http://bocongan.gov.vn/tin-tuc-su-kien/hoat-dong-cua-luc-luong-cong-an/tin-hoat-dong-cua-bo-2.html?Page='),
(1,N'Hoạt động của địa phương - Bộ Công An',9,'http://bocongan.gov.vn/tin-tuc-su-kien/hoat-dong-cua-luc-luong-cong-an/hoat-dong-cua-dia-phuong-23.html?Page='),
(1,N'Chỉ đạo điều hành - Bộ Công An',10,'http://bocongan.gov.vn/tin-tuc-su-kien/chi-dao-dieu-hanh-24.html?Page='),
(1,N'Thông tin đối ngoại - Bộ Công An',11,'http://bocongan.gov.vn/tin-tuc-su-kien/thong-tin-doi-ngoai-20.html?Page='),
(1,N'Tin an ninh trật tự - Bộ Công An',12,'http://bocongan.gov.vn/tin-tuc-su-kien/tin-an-ninh-trat-tu-22.html?Page='),
(1,N'Người tốt, việc tốt - Bộ Công An',13,'http://bocongan.gov.vn/tin-tuc-su-kien/nguoi-tot-viec-tot-21.html?Page='),
(1,N'Hoạt động xã hội - Bộ Công An',14,'http://bocongan.gov.vn/tin-tuc-su-kien/hoat-dong-xa-hoi-25.html?Page='),

(3,N'Tin tức sự kiện - Bộ Nội vụ',57,'https://www.moha.gov.vn/tin-tuc-su-kien.html?page=1'), --còn nhiều trang mà khum có nút kéo đến trang cuối :<

(4,N'Thông cáo báo chí - Bộ Giáo dục và Đào tạo',15,'https://moet.gov.vn/tintuc/Pages/thong-cao-bao-chi.aspx?date=&EventID=0&Page='),
(4,N'Thông báo - Bộ Giáo dục và Đào tạo',16,'https://moet.gov.vn/tintuc/Pages/Thongbao.aspx?date=&EventID=0&Page='),
(4,N'Tin tổng hợp - Bộ Giáo dục và Đào tạo',17,'https://moet.gov.vn/tintuc/Pages/tin-tong-hop.aspx?date=&EventID=0&Page='),

(5,N'Hoạt động lãnh đạo - Bộ Giao thông vận tải',21,'https://mt.gov.vn/vn/chuyen-muc/856/hoat-dong-lanh-dao-.aspx'),
(5,N'Tin hoạt động ngành GTVT - Bộ Giao thông vận tải',22,'https://mt.gov.vn/vn/chuyen-muc/855/Tin-hoat-dong-nganh.aspx'),
(5,N'Tin đấu thầu - Bộ Giao thông vận tải',23,'https://mt.gov.vn/vn/chuyen-muc/877/dau-thau.aspx'),
(5,N'Thông cáo báo chí - Bộ Giao thông vận tải',24,'https://mt.ghttps://mt.gov.vn/vn/chuyen-muc/856/hoat-dong-lanh-dao-.aspxnov.vn/vn/chuyen-muc/889/thong-cao-bao-chi.aspx'),
(5,N'Văn bản mới ban hành - Bộ Giao thông vận tải',25,'https://mt.gov.vn/vn/chuyen-muc/858/van-ban-moi-ban-hanh.aspx'),
(5,N'Công trình giao thông - Bộ Giao thông vận tải',26,'http://mt.gov.vn/vn/chuyen-muc/973/Cong-trinh-giao-thong.aspx'),
(5,N'Video - Bộ Giao thông vận tải',27,'https://mt.gov.vn/vn/chuyen-muc/1184/tinvideo.aspx'),

/*(6,N'Thông tin KT-XH - Bộ Kế hoạch và đầu tư',27,'root',587 ),
(6,N'Số liệu KT_XH - Bộ Kế hoạch và đầu tư',28,'root',587 ),
(6,N'Chỉ tiêu KT-XH - Bộ Kế hoạch và đầu tư',29,'root',587 ),*/

(7,N'Tin tổng hợp - Bộ Khoa học và Công nghệ',17,'https://www.most.gov.vn/vn/chuyen-muc/493/Tin-tong-hop.aspx?page='),
(7,N'Điểm báo KH&CN - Bộ Khoa học và Công nghệ',31,'https://www.most.gov.vn/vn/chuyen-muc/570/Diem-bao-KHCN.aspx?page='),

(8,N'Việc làm - Lao động - Bộ Lao động - Thương Binh và Xã hội',32,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=32&page='),
(8,N'Tiền lương - Lao động - Bộ Lao động - Thương Binh và Xã hội',33,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=33&page='),
(8,N'Bảo hiểm xã hội - Lao động - Bộ Lao động - Thương Binh và Xã hội',34,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=35&page='),
(8,N'Lao động ngoài nước - Lao động - Bộ Lao động - Thương Binh và Xã hội',35,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=34&page='),
(8,N'An toàn, vệ sinh lao động - Lao động - Bộ Lao động - Thương Binh và Xã hội',36,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=68&page='),
(8,N'Giáo dục nghề nghiệp - Lao động - Bộ Lao động - Thương Binh và Xã hội',37,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=69&page='),
(8,N'Người có công - Bộ Lao động - Thương Binh và Xã hội',38,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=25&page='),
(8,N'Bảo trợ xã hội - Xã hội - Bộ Lao động - Thương Binh và Xã hội',39,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=39&page='),
(8,N'Giảm nghèo - Xã hội - Bộ Lao động - Thương Binh và Xã hội',40,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=40&page='),
(8,N'Phòng chống tệ nạn xã hội - Xã hội - Bộ Lao động - Thương Binh và Xã hội',41,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=70&page='),
(8,N'Trẻ em - Xã hội - Bộ Lao động - Thương Binh và Xã hội',42,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=71&page='),
(8,N'Bình đẳng giới - Xã hội - Bộ Lao động - Thương Binh và Xã hội',43,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=72&page='),
(8,N'Thông tin cơ sở - Địa phương - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',44,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=136&page='),
(8,N'Chuyên đề địa phương - Địa phương - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',45,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=258&page='),
(8,N'Mô hình kinh nghiệm - Địa phương - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',46,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=259&page='),
(8,N'Kết nối thông tin - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',47,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=260&page='),
(8,N'Kỷ niệm các ngày lễ lớn của Đất nước - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',48,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucId=11522'),
(8,N'Công tác Đảng - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',49,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11523&page='),
(8,N'Công Đoàn - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',50,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11524&page='),
(8,N'Đoàn Thanh niên - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',51,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11525&page='),
(8,N'Tin tức dịch Covid-19 - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',52,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11521&page='),
(8,N'ASEAN Việt Nam 2020 - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',53,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11527&page='),
(8,N'Thanh tra LĐXH - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',54,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=42&page='),
(8,N'Hoạt động chung - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',55,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=43&page='),
(8,N'Kinh tế - Xã hội - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',56,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=74&page='),
(8,N'Chăm sóc người có công và công tác xã hội - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',57,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11518&page='),


--(9,N'Tin tức sự kiện - Bộ Ngoại giao',58,'https://lanhsuvietnam.gov.vn/Lists/ChuyenMuc/ChuyenMuc/ChuyenMuc.aspx?List=b6a96952%2D5329%2D4042%2D901b%2D2af247f16b68&ID=16',1 ),-----không lấy được param

--(10,N'Tin tổng hợp - Bộ Nông nghiệp và phát triển nông thôn',17,'https://www.mard.gov.vn/Pages/tin-hoat-dong.aspx',344),
--(10,N'Nông nghiệp - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',60,'https://www.mard.gov.vn/Pages/tin-tuc-tin-hoat-dong.aspx#',439),
--(10,N'Lâm nghiệp - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',61,'https://www.mard.gov.vn/Pages/tin-tuc-tin-lam-nghiep.aspx',178),
--(10,N'Thủy lợi - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',62,'https://www.mard.gov.vn/Pages/tin-tuc-tin-thuy-loi.aspx',314),
--(10,N'Phòng chống thiên tai - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',63,'https://www.mard.gov.vn/Pages/phong-chong-thien-tai.aspx',106),
--(10,N'Thủy sản - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',64,'https://www.mard.gov.vn/Pages/tin-tuc-tin-thuy-san.aspx',282),
--(10,N'Quản lý chất lượng - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',65,'https://www.mard.gov.vn/Pages/tin-tuc-tin-quan-ly-chat-luong-va-ve-sinh-attp.aspx',34),
--(10,N'Chế biến và thị trường - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',66,'https://www.mard.gov.vn/Pages/tin-tuc-tin-che-bien.aspx',398),
--(10,N'Phát triển nông thôn - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',67,'https://www.mard.gov.vn/Pages/tin-tuc-tin-phat-trien-nong-thon.aspx',18),
--(10,N'Khuyến nông - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',68,'https://www.mard.gov.vn/Pages/tin-tuc-tin-khuyen-nong.aspx',405),
--(10,N'Tin địa phương - Bộ Nông nghiệp và phát triển nông thôn',20,'https://www.mard.gov.vn/Pages/danh-sach-tin-dia-phuong.aspx',170),
--(10,N'Tin video - Bộ Nông nghiệp và phát triển nông thôn',18,'https://www.mard.gov.vn/Pages/danh-sach-tin-video.aspx',50),

(11,N'Tin tức sự kiện - Bộ Quốc phòng',58,'http://www.mod.gov.vn/wps/portal/!ut/p/b1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLdHP2CLJwMHQ38zT0sDDyNnZ1NjcOMDQ2CzIEKIoEKDHAARwPi9Du7O3qYmPsYGFj4uJsaeDp6hAZZBhobGzgaE9Ifrh8FVoLPBLACPE7088jPTdUvyA2NMMgyUQQAfwOf3g!!/dl4/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_FANR8B1A081F00I32T4LDI2064/ren/p=WCM_PI=1/p=ns_Z7_FANR8B1A081F00I32T4LDI2064_WCM_PreviousPageSize.4e92abb3-6db2-476b-85b7-8c31f62282a0=10/p=ns_Z7_FANR8B1A081F00I32T4LDI2064_WCM_Page.4e92abb3-6db2-476b-85b7-8c31f62282a0=/p=CTX=QCPmodQCPsa-mod-siteQCPsa-ttsk/-/'),

--(12,N'Tin tức sự kiện - Bộ Tài chính',58,'https://www.mof.gov.vn/webcenter/portal/tttc/r/o/ttsk?_afrLoop=2000043207816979#%40%3F_afrLoop%3D2000043207816979%26centerWidth%3D100%2525%26leftWidth%3D0%2525%26rightWidth%3D0%2525%26showFooter%3Dfalse%26showHeader%3Dfalse%26_adf.ctrl-state%3D1akhre069w_206',465 ),-----không lấy được param
--(12,N'Thông cáo báo chí - Bộ Tài chính',24,'https://www.mof.gov.vn/webcenter/portal/tttc/r/o/thongcaobaochi?_afrLoop=2000261991867489#%40%3F_afrLoop%3D2000261991867489%26centerWidth%3D100%2525%26leftWidth%3D0%2525%26rightWidth%3D0%2525%26showFooter%3Dfalse%26showHeader%3Dfalse%26_adf.ctrl-state%3D1akhre069w_272',26 ),-----không lấy được param

--(13,N'Hội nhập quốc tế - Bộ Tài nguyên và Môi trường',39,'https://monre.gov.vn/Pages/ChuyenMuc.aspx?cm=H%E1%BB%99i%20nh%E1%BA%ADp%20qu%E1%BB%91c%20t%E1%BA%BF',42 ), -----không lấy được param
--(13,N'Tham vấn chính sách TN&MT - Bộ Tài nguyên và Môi trường',70,'https://monre.gov.vn/Pages/ChuyenMuc.aspx?cm=Tham%20v%E1%BA%A5n%20ch%C3%ADnh%20s%C3%A1ch%20TN%EF%BC%86MT',1000 ),-----không lấy được param


(14,N'Bưu chính - Bộ Thông tin và Truyền thông',71,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1747/1/Buu-chinh.html'),
(14,N'Viễn thông - Bộ Thông tin và Truyền thông',72,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1748/1/Vien-thong.html'),
(14,N'CNTT - Bộ Thông tin và Truyền thông',73,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1749/1/Ung-dung-CNTT.html'),
(14,N'ATTT - Bộ Thông tin và Truyền thông',74,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1694/1/An-toan-thong-tin.html'),
(14,N'Công nghiệp ICT - Bộ Thông tin và Truyền thông',75,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1751/1/Cong-nghiep-ICT.html'),
(14,N'Báo chí truyền thông - Bộ Thông tin và Truyền thông',76,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1752/1/Bao-chi-truyen-thong.html'),

(15,N'Văn bản chính sách mới - Bộ Tư pháp',77,'https://moj.gov.vn/qt/tintuc/Pages/van-ban-chinh-sach-moi.aspx?Date=&Page='),
(15,N'Chỉ đạo điều hành - Bộ Tư pháp',78,'https://moj.gov.vn/qt/tintuc/Pages/chi-dao-dieu-hanh.aspx?Date=&Page='),

--(16,N'Bộ với các đơn vị - Bộ Văn hóa - Thể thao và Du lịch',81,'https://bvhttdl.gov.vn/hoat-dong-ky-niem-ngay-quoc-te-bao-tang-18-5-2021-20210507084003259.htm',1 ), -----không lấy được param
--(16,N'Bộ với các địa phương - Bộ Văn hóa - Thể thao và Du lịch',82,'https://bvhttdl.gov.vn/tin-tuc-va-su-kien/bo-voi-cac-dia-phuong/trang-1150.htm',1150 ),-----không lấy được param
--(16,N'Giao lưu - Hợp tác quốc tế - Bộ Văn hóa - Thể thao và Du lịch',83,'https://bvhttdl.gov.vn/g20-ung-ho-sang-kien-di-chuyen-quoc-te-an-toan-de-khoi-dong-du-lich-20210506162341549.htm',1 ), -----không lấy được param
--(16,N'Điểm báo - Bộ Văn hóa - Thể thao và Du lịch',84,'https://bvhttdl.gov.vn/diem-bao-hoat-dong-nganh-van-hoa-the-thao-va-du-lich-ngay-7-5-2021-20210507122302558.htm',1 ), -----không lấy được param
--(16,N'Thông tin - trao đổi - Bộ Văn hóa - Thể thao và Du lịch',85,'https://bvhttdl.gov.vn/van-dung-tu-tuong-ho-chi-minh-vao-cong-tac-kiem-tra-cua-dang-hien-nay-20210505073502755.htm',1 ), -----không lấy được param

(17,N'Tin tổng hợp - Bộ Xây dựng',17,'https://moc.gov.vn/vn/chuyen-muc/1173/tin-hoat-dong.aspx?page='),
(17,N'Tin hoạt động - Bộ Xây dựng',86,'https://moc.gov.vn/vn/chuyen-muc/1184/tin-tong-hop.aspx?page='),
(17,N'Tin cải cách hành chính - Bộ Xây dựng',87,'https://moc.gov.vn/vn/chuyen-muc/1166/tin-cai-cach-hanh-chinh.aspx?page='),
(17,N'Giới thiệu văn bản mới - Bộ Xây dựng',88,'https://moc.gov.vn/vn/chuyen-muc/1196/Gioi-thieu-van-ban-moi.aspx?page='),

(18,N'Tin hoạt động - Bộ y tế',86,'https://moh.gov.vn/hoat-dong-cua-lanh-dao-bo?p_p_id=101_INSTANCE_TW6LTp1ZtwaN&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=2&_101_INSTANCE_TW6LTp1ZtwaN_delta=20&_101_INSTANCE_TW6LTp1ZtwaN_keywords=&_101_INSTANCE_TW6LTp1ZtwaN_advancedSearch=false&_101_INSTANCE_TW6LTp1ZtwaN_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_TW6LTp1ZtwaN_cur='),
(18,N'Tin tổng hợp - Bộ y tế',17,'https://moh.gov.vn/tin-tong-hop?p_p_id=101_INSTANCE_k206Q9qkZOqn&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=1&_101_INSTANCE_k206Q9qkZOqn_delta=20&_101_INSTANCE_k206Q9qkZOqn_keywords=&_101_INSTANCE_k206Q9qkZOqn_advancedSearch=false&_101_INSTANCE_k206Q9qkZOqn_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_k206Q9qkZOqn_cur='),
(18,N'Tin địa phương - Bộ y tế',20,'https://moh.gov.vn/hoat-dong-cua-dia-phuong?p_p_id=101_INSTANCE_gHbla8vOQDuS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=2&_101_INSTANCE_gHbla8vOQDuS_delta=20&_101_INSTANCE_gHbla8vOQDuS_keywords=&_101_INSTANCE_gHbla8vOQDuS_advancedSearch=false&_101_INSTANCE_gHbla8vOQDuS_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_gHbla8vOQDuS_cur='),
(18,N'Tin liên quan - Bộ y tế',89,'https://moh.gov.vn/tin-lien-quan?p_p_id=101_INSTANCE_vjYyM7O9aWnX&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=1&_101_INSTANCE_vjYyM7O9aWnX_delta=20&_101_INSTANCE_vjYyM7O9aWnX_keywords=&_101_INSTANCE_vjYyM7O9aWnX_advancedSearch=false&_101_INSTANCE_vjYyM7O9aWnX_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_vjYyM7O9aWnX_cur='),

(19,N'Tin nổi bật - Chính phủ',90,'http://chinhphu.vn/portal/page/portal/chinhphu/trangchu/tinnoibat'),

(20,N'Hoạt động của Bộ trưởng, Chủ nhiệm - Ủy ban Dân tộc',91,'http://cema.gov.vn/tin-tuc/tin-hoat-dong/hoat-dong-cua-bo-truong.htm?p='),
(20,N'Hoạt động của Ủy ban Dân tộc - Ủy ban Dân tộc',92,'http://cema.gov.vn/tin-tuc/tin-hoat-dong/hoat-dong-cua-uy-ban.htm?p='),
(20,N'Ủy ban Dân tộc với Bộ ngành - Ủy ban Dân tộc',93,'http://cema.gov.vn/uy-ban-dan-toc-voi-bo-nganh.htm?p='),
(20,N'Ủy ban Dân tộc với địa phương - Ủy ban Dân tộc',94,'http://cema.gov.vn/uy-ban-dan-toc-voi-dia-phuong.htm?p='),
(20,N'Hoạt động của các Ban Dân tộc - Ủy ban Dân tộc',95,'http://cema.gov.vn/tin-tuc/tin-hoat-dong/hoat-dong-cua-cac-ban-dan-toc.htm?p='),
(20,N'Chủ trương - Chính sách  - Ủy ban Dân tộc',96,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/chu-truong-chinh-sach.htm?p='),
(20,N'Thời sự - Chính trị - Ủy ban Dân tộc',97,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/thoi-su-chinh-tri.htm?p='),
(20,N'Kinh tế - Xã hội - Ủy ban Dân tộc',98,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/kinh-te-xa-hoi.htm?p='),
(20,N'Y tế - Giáo dục - Ủy ban Dân tộc',99,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/y-te-giao-duc.htm?p='),
(20,N'Văn hóa - Văn nghệ - Thể thao - Ủy ban Dân tộc',100,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/van-hoa-van-nghe-the-thao.htm?p='),
(20,N'Khoa học - Công nghệ - Môi trường - Ủy ban Dân tộc',101,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/khoa-hoc-cong-nghe-moi-truong.htm?p='),
(20,N'Pháp luật - Ủy ban Dân tộc',102,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/phap-luat.htm?p='),
(20,N'Quốc tế - Ủy ban Dân tộc',2,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/quoc-te.htm?p='),
(20,N'Nghiên cứu trao đổi - Ủy ban Dân tộc',79,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/nghien-cuu-trao-doi.htm?p='),
(20,N'Gương điển hình tiên tiến - Ủy ban Dân tộc',103,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/guong-dien-hinh-tien-tien.htm?p='),
(20,N'Thông tin thị trường giá cả - Ủy ban Dân tộc',104,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/thong-tin-thi-truong-gia-ca.htm?p='),

(23,N'Lĩnh Vực Bảo Hiểm Y Tế - Bảo hiểm Xã hội Việt Nam',17,'https://baohiemxahoi.gov.vn/tintuc/Pages/linh-vuc-bao-hiem-y-te.aspx?CateID=169&date=&Page='),
(23,N'Lĩnh Vực Bảo Hiểm Xã Hội - Bảo hiểm Xã hội Việt Nam',17,'https://baohiemxahoi.gov.vn/tintuc/Pages/linh-vuc-bao-hiem-xa-hoi.aspx?CateID=168&date=&Page='),
(23,N'Hoạt động hệ thống Bảo Hiểm Xã Hội - Bảo hiểm Xã hội Việt Nam',17,'https://baohiemxahoi.gov.vn/tintuc/Pages/hoat-dong-he-thong-bao-hiem-xa-hoi.aspx?CateID=52&date=&Page='),
(23,N'An sinh xã hội - Bảo hiểm Xã hội Việt Nam',17,'https://baohiemxahoi.gov.vn/tintuc/Pages/an-sinh-xa-hoi.aspx?CateID=170&date=&Page='),
(23,N'BHXHVN chung tay đẩy lùi dịch bệnh Covid-19 - Bảo hiểm Xã hội Việt Nam',17,'https://baohiemxahoi.gov.vn/tintuc/Pages/bhxhvn-chung-tay-day-lui-dich-benh-covid-19.aspx?CateID=174&date=&Page='),
(23,N'Kinh tế - Xã hội - Bảo hiểm Xã hội Việt Nam',17,'https://baohiemxahoi.gov.vn/tintuc/pages/kinh-te-xa-hoi.aspx?CateID=170&date=&Page='),

(24,N'Tin tức hoạt động của Viện hàn lâm KHCNVN - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',105,'https://vast.gov.vn/web/guest/tin-tuc-hoat-ong-cua-vien-han-lam-khcnvn?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_cur='),
(24,N'Tin khoa học - Công nghệ trong nước - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',106,'https://vast.gov.vn/web/guest/tin-khoa-hoc-cong-nghe-trong-nuoc1?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_cur='),
(24,N'Nghiên cứu cơ bản - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',107,'https://vast.gov.vn/web/guest/nghien-cuu-co-ban?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_cur='),
(24,N'Nghiên cứu và Phát triển công nghệ - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',108,'https://vast.gov.vn/web/guest/nghien-cuu-va-phat-trien-cong-nghe?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_cur='),
(24,N'Điều tra cơ bản - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',109,'https://vast.gov.vn/web/guest/-ieu-tra-co-ban?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_cur='),
(24,N'Tin Khoa học - Công nghệ quốc tế - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',110,'https://vast.gov.vn/web/guest/tin-khoa-hoc-cong-nghe-quoc-te1?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_cur='),

(25,N'Tin hợp tác quốc tế - Viện Hàn lâm Khoa học Xã hội Việt Nam',112,'https://vass.gov.vn/hop-tac-quoc-te-1.0.1'),
(25,N'Tin tức đào tạo - Viện Hàn lâm Khoa học Xã hội Việt Nam',113,'https://vass.gov.vn/noidung/daotaosaudaihoc/Pages/tin-tuc-dao-tao.aspx?Date=&Page='),
(25,N'Tin Hành chính - Tổ chức - Viện Hàn lâm Khoa học Xã hội Việt Nam',114,'https://vass.gov.vn/tin-hanh-chinh-to-chuc-1.0.1'),

(26,N'Tin tức sự kiện - Ủy ban quản lý vốn nhà nước tại doanh nghiệp',58,'http://cmsc.gov.vn/tin-tuc-su-kien?p_p_id=dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=_118_INSTANCE_EWtJ5M5YE6wZ__column-1&p_p_col_count=1&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_delta=25&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_keywords=&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_advancedSearch=false&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_andOperator=true&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_resetCur=false&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_cur=')

go
insert into legislation_type(legislation_type_name) values
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

select ministry_id,legislation_link_root, legislation_id from legislationinfo where ministry_id = 1

go	
INSERT INTO legislationinfo(ministry_id,legislation_name,legislation_type_id,legislation_link_root)
VALUES
(2,N'Văn bản pháp quy - Bộ công thương',1,'http://www.moit.gov.vn/web/guest/van-ban-phap-quy'),
(2,N'Văn bản điều hành - Bộ công thương',2,'http://www.moit.gov.vn/web/guest/van-ban-dieu-hanh'),

(1,N'Văn bản quy phạm pháp luật -  Bộ công an',4,'http://bocongan.gov.vn/van-ban/van-ban-quy-pham.html'),

(4,N'Văn bản quy phạm pháp luật -  Bộ giáo dục và đào tạo',4,'https://moet.gov.vn/van-ban/vanban/Pages/default.aspx?Page='),
(4,N'Văn bản chỉ đạo, điều hành -  Bộ giáo dục và đào tạo',5,'https://moet.gov.vn/van-ban/vbdh/Pages/default.aspx?Page='),

(5,N'Văn bản chỉ đạo điều hành - Bộ giao thông vận tải',6,'https://mt.gov.vn/vn/Pages/Vanbanphapluat.aspx?TypeVB=0'),
(5,N'Văn bản pháp luật - Bộ giao thông vận tải',7,'https://mt.gov.vn/vn/Pages/VBPL.aspx?node=VB&item=78'),

(6,N'Văn bản chỉ đạo điều hành - Bộ kế hoạch đầu tư',6,'http://vbqppl.mpi.gov.vn/pages/cddh.aspx'),
(6,N'Văn bản quy phạm pháp luật - Bộ kế hoạch và đầu tư',4,'http://vbqppl.mpi.gov.vn/Pages/default.aspx'),

(7,N'Văn bản chỉ đạo, điều hành - Bộ khoa học công nghệ',5,'http://www.most.gov.vn/vn/Pages/Vanbanphapluat.aspx'),
(7,N'Văn bản pháp quy - Bộ giao khoa học công nghệ',1,'https://www.most.gov.vn/vn/Pages/VBPQ.aspx?Machuyende=VB&ChudeID=73'),

(8,N'Văn bản chỉ đạo điều hành - Bộ lao động - thương binh và xã hội',5,'http://www.molisa.gov.vn/Pages/VanBan/ChiDaoDieuHanh.aspx?Page='),
(8,N'Văn bản quy phạm pháp luật - Bộ lao động - thương binh và xã hội',4,'http://www.molisa.gov.vn/Pages/VanBan/vbpq.aspx'),

--bộ ngoại giao không có văn bản
--bộ nông nghiệp trong có trang văn bản để lấy link
(3,N'Văn bản quy phạm pháp luật - Bộ nội vụ',4,'https://doc.moha.gov.vn/Default.aspx?TabID=1736&p='),

(11,N'Văn bản pháp luật - Bộ quốc phòng',7,'http://www.mod.gov.vn/wps/portal/qlcd/vbpl/searchhome'),

(12,N'Văn bản quy phạm pháp luật - Bộ tài chính',4,'https://vbpq.mof.gov.vn/'),
(12,N'Văn bản điều hành - Bộ tài chính',2,'https://vbpq.mof.gov.vn/VBDH'),

(13,N'Văn bản chỉ đạo điều hành - Bộ tài nguyên và môi trường',5,'https://monre.gov.vn/VanBan/Pages/VanBanChiDao.aspx'),
(13,N'Văn bản quy phạm pháp luật - Bộ tài nguyên và môi trường',4,'https://monre.gov.vn/VanBan/Pages/VanBanPhapQuy.aspx'),

(14,N'Văn bản chỉ đạo điều hành - Bộ thông tin và truyền thông',5,'https://www.mic.gov.vn/mic_2020/Pages/VanBan/danhsachvanban.aspx?LVB=100'),
(14,N'Văn bản quy phạm pháp luật - Bộ thông tin và truyền thông',4,'https://www.mic.gov.vn/mic_2020/Pages/VanBan/danhsachvanban.aspx?LVB=100'),

(15,N'Văn bản chính sách mới - Bộ tư pháp',8,'https://moj.gov.vn/qt/tintuc/Pages/van-ban-chinh-sach-moi.aspx?Date=&Page='),

(16,N'Văn bản chỉ đạo điều hành - Bộ văn hóa thể thao và du lịch',5,'https://bvhttdl.gov.vn/van-ban-quan-ly.htm?coquan=0&nhom=2&theloai=0&linhvuc=0&year=0&keyword=&pageIndex=	'),
(16,N'Văn bản quy phạm pháp luật - Bộ văn hóa thể thao và du lịch',4,'https://bvhttdl.gov.vn/van-ban-quan-ly.htm?coquan=0&nhom=1&theloai=0&linhvuc=0&year=0&keyword=&pageIndex='),

(17,N'Văn bản pháp quy - Bộ xây dựng',1,'http://vbpl.vn/boxaydung/Pages/Home.aspx'),
(17,N'Văn bản điều hành - Bộ xây dựng',2,'https://moc.gov.vn/vn/Pages/Vanbanphapluat.aspx?TypeVB=1'),

--bộ ý tế không có văn bản
--chính phủ không có văn bản

(20,N'Văn bản chỉ đạo điều hành - Ủy ban dân tộc',5,'http://csdl.ubdt.gov.vn/noidung/Pages/vanbanden.aspx?type=adv&RowPerPage=10&UrlListProcess=/noidung/vanbandt/Lists/UBDTVanBanDen&PageStep=2&vbdLoaiVanBan=0&vbdLinhvuc=0&vbdCoQuanBanHanh=0&vbdTrichYeu=&vbdToanVan=&vbdSoKyHieu=&TuNgay=&DenNgay=&vbdDanToc=0&vbdDiaBanApDung=&Page='),

(21,N'Văn bản quy phạm pháp luật - Ngân hàng nhà nước',4,'https://www.sbv.gov.vn/webcenter/portal/vi/menu/trangchu/csdlvbpl?_afrLoop=24714175539752224#%40%3F_afrLoop%3D24714175539752224%26centerWidth%3D100%2525%26leftWidth%3D0%2525%26rightWidth%3D0%2525%26showFooter%3Dfalse%26showHeader%3Dfalse%26_adf.ctrl-state%3Doxc7pzry7_90'),

(22,N'Hệ thống văn bản - Văn phòng chính phủ',5,'http://vpcp.chinhphu.vn/documents/z6.vgp'),

(23,N'Văn bản chỉ đạo của Ngành - Bảo hiểm xã hội',9,'https://baohiemxahoi.gov.vn/vanban/Pages/default.aspx?LinhVuc=0&DanhMucBanHanh=3&CoQuanBanHanh=0&order=ID&TypeOfOrder=False&tenvanban=&NgayBanHanh=&FormSearch=&selectedChekBox=&LoaiNgayThang=0&FromDate=&ToDate=&NamBanHanh=0&Page='),
(23,N'Văn bản ngoài Ngành - Bảo hiểm xã hội',10,'https://baohiemxahoi.gov.vn/vanban/Pages/default.aspx?LinhVuc=0&DanhMucBanHanh=4&CoQuanBanHanh=0&order=ID&TypeOfOrder=False&tenvanban=&NgayBanHanh=&FormSearch=&selectedChekBox=&LoaiNgayThang=0&FromDate=&ToDate=&NamBanHanh=0&Page='),

--viện hàn lâm khcn và viện hàn lâm khxh không có văn bản

(26,N'Văn bản pháp luật - Ủy ban quản lý vốn nhà nước tại doanh nghiệp',7,'http://cmsc.gov.vn/van-ban-phap-quy?p_p_id=dsvanbanphapquy_WAR_vnpteportalappportlet&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=_118_INSTANCE_EWtJ5M5YE6wZ__column-1&p_p_col_count=1&_dsvanbanphapquy_WAR_vnpteportalappportlet_keyword=&_dsvanbanphapquy_WAR_vnpteportalappportlet_loaiVanBanId=0&_dsvanbanphapquy_WAR_vnpteportalappportlet_coQuanBanHanhId=0&_dsvanbanphapquy_WAR_vnpteportalappportlet_linhVucId=0&_dsvanbanphapquy_WAR_vnpteportalappportlet_startDate=&_dsvanbanphapquy_WAR_vnpteportalappportlet_endDate=&_dsvanbanphapquy_WAR_vnpteportalappportlet_delta=10&_dsvanbanphapquy_WAR_vnpteportalappportlet_keywords=&_dsvanbanphapquy_WAR_vnpteportalappportlet_advancedSearch=false&_dsvanbanphapquy_WAR_vnpteportalappportlet_andOperator=true&_dsvanbanphapquy_WAR_vnpteportalappportlet_resetCur=false&_dsvanbanphapquy_WAR_vnpteportalappportlet_cur=')


--go
--insert into ministry_category_configuration(ministry_id,category_id,article_url_xpath,article_thumbnail_xpath,page_rule,schedule_minute,article_param_xpath) values
	--phân loại tin tức bộ công thương
	--(2, 1,
	--'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	--'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',
	--1,12,
	--'//*[@id="_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_ocerSearchContainerPageIterator"]/div/ul//a/@href'),
	--phân loại tin tức bộ công an
	--(1, 7,
	--'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	--'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',1,12,
	--'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a/@href'),
	--thông cáo báo chí - tin tổng hợp bộ giáo dục
	--(4, 15,
	--'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/div/h2/a/@href',	
	--'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/a/img/@src',1,12,
	--'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div[2]/div[2]/div/a/@href'),
	--thông báo bộ giáo dục
	--(4, 16, 
	--'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div/div/ul/li/div/h2/a/@href',	
	--'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div[2]/div/ul/li/a/img/@src',1,12,
	--'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div[2]/div[2]/div/a/@href')

select ministry_id,legislation_link_root, legislation_id from legislationinfo where ministry_id = 3

go 
insert into ministry_legislation_configuration(ministry_id, legislation_id, legislation_url_xpath, page_rule, schedule_minute, legislation_param_xpath) values
	--văn bản bộ công an
	(1, 3,
	'//*[@id="parentHorizontalTab"]/div/div/div/div/a/@href',
	1,12,
	''),
	

	--văn bản pháp quy bộ công thương
	(2,2,
	'//*[@class="text_detail"]/div[1]/a/@href',
	1,12,
	'//*[@id="pagination"]/span/a/@href'), --xài không có được hic
	--văn bản điều hành bộ công thương
	(2, 2,
	'//*[@class="text_detail"]/div[1]/a/@href',
	1,12,
	'//*[@id="pagination"]/span/a/@href'), --cũng dậy
	

	--văn bản quy phạm phát luật bộ giáo dục
	(4, 4,
	'//*[@id="ctl00_ctl24_g_025164b8_2c99_46cb_ad7d_e00c79535b91"]/div/div/div/div/div/a/@href',
	1,12,
	'//*[@id="ctl00_ctl24_g_025164b8_2c99_46cb_ad7d_e00c79535b91"]/div/div/div/div/a[6]/@href'),
	--văn bản chỉ đạo điều hành bộ giáo dục
	(4, 6,
	'//*[@id="ctl00_ctl24_g_71a175fa_a10b_477d_ab07_a5477af56ca9"]/div/div/div/div/div/a/@href',
	1,12,
	'//*[@id="ctl00_ctl24_g_71a175fa_a10b_477d_ab07_a5477af56ca9"]/div/div/div/div/a[6]/@href'),
	

	--văn bản điều hành bộ gtvt
	(5, 2,
	'//*[@class="css-vanban"]/a/@href',
	1,12,
	''),
	--văn bản pháp quy bộ gtvt xpath url khác nhau


	--văn bản quy phạm phát luật bộ kế hoạch đầu tư
	(6, 4,
	'//*[@class="css-vanban"]/a/@href',
	1,12,
	''),
	--văn bản chỉ đạo điều hành bộ bộ kế hoạch đầu tư
	(6, 6,
	'//*[@id="latestItem"]/li/a/@href',
	1,12,
	''),


	--văn bản pháp quy bộ khcn
	(7, 1,
	'//*[@id="tabVB_lv1_01"]/ul/li/div/p/a/@href',
	1,12,
	''),
	--văn bản chỉ đạo, điều hành bộ khcn 
	(7, 5,
	'//*[@class="CSSTableGenerator"]/table/tr/td/div/a/@href',
	1,12,
	'//*[@class="Paging Paging_Footer_Table_Legal"]/a[2]/@href'),


	--văn bản quy phạm pháp luật bộ tài chính --không dùng được
	--(12, 4,
	--'//*[@id="showallData"]/div/div/a/h5/@href',
	--1,12,
	--'//*[@id="showallData"]/div[18]/div[2]/ul/li[9]/a/@href'),
	--văn bản điều hành bộ tài chính --không dùng được
	--(12, 5,
	--'//*[@id="showallData"]/div/div/a/h5/@href',
	--1,12,
	--'//*[@id="showallData"]/div[18]/div[2]/ul/li[9]/a'),

	
	--văn bản pháp luật bộ quốc phòng
	(11, 7,
	'//*[@class="bgTable"]/td/a/@href',
	1,12,
	'//*[@class="page"]/a[6]/@href'), -- xpath không có trang cuối

	--văn bản quy phạm pháp luật bộ nội vụ
	(3, 4,
	'//*[@class="title"]/a/@href',
	1,12,
	'//*[@class="pagination"]/ul/li[7]/a/@href'),

	--bộ ngoại giao không có văn bản

	--văn bản quy phạm pháp luật bộ lao động
	(8, 6,
	'//*[@class="title"]/a/@href',
	1,12,
	'//*[@class="pagination"]/ul/li[7]/a/@href'),
	--văn bản chỉ đạo điều hành bộ lao động
	(8, 4,
	'//*[@class="main_vbtable  table-vanban"]/table/tbody/tr/td/a/@href',
	1,12,
	'//*[@class="pagination pull-right"]/li[7]/a/@href'),

	--bộ tài nguyên môi trường xpath khác nhau

	--văn bản quy phạm pháp luật bộ thông tin truyền thông
	(14, 4,
	'//*[@class="table-vb"]/tbody/tr/td/a/@href',
	1,12,
	'//*[@id="pagevanbant"]/ul/li[8]/a/@href'),
	--văn bản điều hành bộ thông tin truyền thông
	(14, 6,
	'//*[@class="table-vb"]/tbody/tr/td/a/@href',
	1,12,
	'//*[@id="pagevanbant"]/ul/li[8]/a/a/@href'),


	--văn bản chính sách mới bộ tư pháp
	(15, 8,
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div/div/div/div/div/p/a/@href',
	1,12,
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div[2]/div/div[2]/div/div[10]/div/a[5]/@href'),


	--văn bản quy phạm pháp luật bộ văn hóa thể thao và du lịch
	(16, 4,
	'//*[@class="table-data"]/tr/td/a/@href',
	1,12,
	''), --không có sxpath trang cuối
	--văn bản điều hành bộ văn hóa thể thao và du lịch
	(16, 6,
	'//*[@class="table-data"]/tr/td/a/@href',
	1,12,
	''), --không có xpath trang cuối


	--văn bản pháp quy bộ xây dựng - đang lỗi
	--(17, 1,
	--'//*[@id="mainHtml"]/body/div/div/div/table/tbody/tr/td/a/@href',
	--1,12,
	--''), --không có sxpath trang cuối
	--văn bản điều hành bộ xây dựng
	(17, 2,
	'//*[@class="link_sokyhieu"]/@href',
	1,12,
	'//*[@id="ctl00_SPWebPartManager1_g_98940a7e_2c09_45ce_b14f_1469576fa0d6_ctl00_lkLast2"]/@href'), 

	--vào mục văn bản bộ y tế cần đăng nhập -> khum lấy được
	--trang chính phủ khum vô được
	
	--văn bản chỉ đạo điều hành ủy ban dân tộc
	(20, 6,
	'//*[@id="list-container"]/table/tr/td/a/@href',
	1,12,
	'//*[@id="paging"]/div/div/a[5]/@href'), 

	
	--văn bản quy phạm pháp luật ngân hàng
	(21, 6,
	'//*[@id="tabVB_lv1_01"]/ul/li/div/p/a/@href',
	1,12,
	''), --không có nút trang cuối


	--văn phòng chính phủ không có văn bản


	--văn bản chỉ đạo của ngành bảo hiểm xã hội
	(23, 9,
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div/div/div/div/div/div/a/@href',
	1,12,
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div/div/div/div/ul/li[7]/a/@href'),
	--văn bản ngoài Ngành bảo hiểm xã hội
	(23, 10,
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div/div/div/div/div/div/a/@href',
	1,12,
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div/div/div/div/ul/li[7]/a/@href'),

	--văn bản ngoài ủy ban quản lý vốn nhà nước
	(26, 10,
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div/div/table/tbody/tr/td/a/@href',
	1,12,
	'//*[@id="_dsvanbanphapquy_WAR_vnpteportalappportlet_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href')
	
	--viện hàn lâm khxh và viện hàn lâm khcn không có văn bản

go
insert into ministry_category_configuration(ministry_id, category_id, article_url_xpath, article_thumbnail_xpath, page_rule, schedule_minute, article_param_xpath) values
	--phân loại tin tức bộ công thương, xpath nút cuối cùng giống nhau, category id 1-7
	(2, 
	1,
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',
	1,
	12,
	'//*[@id="_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href'),
	
	(2, 
	2,
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',
	1,
	12,
	'//*[@id="_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href'),
	
	(2, 
	3,
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',
	1,
	12,
	'//*[@id="_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href'),
	
	(2, 
	4,
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',
	1,
	12,
	'//*[@id="_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href'),
	
	(2, 
	5,
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',
	1,
	12,
	'//*[@id="_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href'),
	
	(2, 
	6,
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',
	1,
	12,
	'//*[@id="_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href'),
	
	(2, 
	7,
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',
	1,
	12,
	'//*[@id="_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_ocerSearchContainerPageIterator"]/div/ul/li[4]/a/@href'),
	
	--phân loại tin tức bộ công an- xpath nút cuối cùng giống nhau, category 8-14
	(1, 
	8,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),
	(1, 
	9,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),
	(1, 
	10,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),
	(1, 
	11,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),
	(1, 
	12,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),
	(1, 
	13,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),
	(1, 
	14,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a[5]/@href'),
	
	--tin tổng hợp bộ giáo dục 
	(4, 
	17,
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div[2]/div[2]/div/a[6]/@href'),
	--thông báo bộ giáo dục
	(4, 
	16, 
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div[2]/div/ul/li/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div[2]/div[2]/div/a[2]/@href'),
	--thông cáo báo chí bộ giáo dục
	(4, 
	24, 
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div[2]/div[2]/div/a[2]/@href'),
	
	--tin video bộ giáo dục
	--(4,
	--'//*[@id="ctl00_ctl24_g_92a2c5f4_d49d_478b_9f6f_b3920bf66eb9"]/div/div/div/div/ul/li/div/div/div/p/a/@href',	
	--'//*[@id="ctl00_ctl24_g_92a2c5f4_d49d_478b_9f6f_b3920bf66eb9"]/div/div/div/div/ul/li/div/div/div/a/img/@src',12),
	----tin audio bộ giáo dục
	--(4,
	--'//*[@id="ctl00_ctl24_g_fcf11fda_52ab_4c10_b110_b18f8d5a6e0a"]/div/div/div/div/ul/li/div/div/div/p/a/@href',	
	--'//*[@id="ctl00_ctl24_g_fcf11fda_52ab_4c10_b110_b18f8d5a6e0a"]/div/div/div/div/ul/li/div/div/div/a/img/@src',12),
	--phân loại bộ gtvt
	--(5,
	--'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	--'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/div/a/img/@src',12),
	--công trình giao thông bộ gtvt
	--(5,
	--'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_rptNhomTinTuc_ctl00_pnlShowNhomTin"]/div/div/ul/li/a/@href',	
	--' ',12),--không có ảnh ----không lấy được param
	--phân loại bộ khoa học và công nghệ
	(7, 25,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/img/@src',1,12,
	'//*[@class="Paging"]/select/option/@value'),
	--phân loại bộ lao động thương binh và xã hội
	(8, 27,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--người có công bộ lao động thương binh và xã hội
	(8,33,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--tin tổng hợp bộ khoa học và công nghệ
	(7, 
	17,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_lkLast2"]'),
	--điểm báo KHCN
	(7, 
	31,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_lkLast2"]'),
	
	--việc làm bộ lao động thương binh và xã hội
	(8, 
	32,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--tiền lương ''
	(8, 33,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--bảo hiểm xã hội ''
	(8, 34,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--lao động ngoài nước ''
	(8, 35,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--an toàn, vệ sinh lao động ''
	(8, 36,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--giáo dục nghề nghiệp ''
	(8, 37,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	
	--người có công bộ lao động thương binh và xã hội
	(8,38,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--bảo trợ xã hội ''
	(8,39,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--giảm nghèo
	(8,40,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--phòng chống tệ nạn xã hội
	(8,41,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--trẻ em
	(8,42,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	--bình đẳng giới
	(8,43,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--thông tin cơ sở
	(8,44,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--chuyên đề địa phương
	(8,45,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--mô hình kinh nghiệm
	(8,46,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--kết nối thông tin
	(8,47,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	
	--kỷ niệm ngày lễ lớn
	(8,48,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	
	--công tác đảng
	(8,49,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	
	--công đoàn
	(8,50,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	
	--đoàn thanh niên
	(8,51,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),
	
	--tin tức dịch
	(8,52,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--asean vn
	(8,53,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--thanh tra ldxh
	(8,54,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--hoạt động chung	
	(8,55,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--kinh tế - xã hội
	(8,56,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--chăm sóc người có công
	(8,57,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/ul[2]/li[8]/a/@href'),

	--tin tức-sự kiện bộ nội vụ
	--(3,
	--'//*[@id="list_news"]/div[1]/div/div/ul/li/p/a/@href',	
	--'//*[@id="list_news"]/div/div/div/ul/li/a/img/@src',12), ---không lấy được param

	--tin tức-sự kiện bộ quốc phòng
	(11, 53,
	'//*[@id="listArticle"]/div/div/h1/a/@href',	
	'//*[@id="listArticle"]/div/div/a/img/@src',1,12,
	'//*[@id="pc1621525478516_lastPage"]/@href'),
	
	--tin tức-sự kiện bộ tài chính
	--(12,
	--'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	--'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',12),
	----tin địa phương bộ ''
	--(12,
	--'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	--'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',12),
	
	--phân loại tin tức bộ thông tin và truyền thông
	(14, 54,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),
	
	--bưu chính bộ thông tin và truyền thông
	(14, 
	71,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),
	
	--viễn thông bộ thông tin và truyền thông
	(14, 
	71,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),

	--cntt bộ thông tin và truyền thông
	(14, 
	71,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),

	--attt bộ thông tin và truyền thông
	(14, 
	71,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),

	--công nghiệp ict bộ thông tin và truyền thông
	(14, 
	71,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),

	--báo chí truyền thông bộ thông tin và truyền thông
	(14, 
	71,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),

	--chỉ đạo điều hành bộ tư pháp
	--(15,61,
	--'//*[@id="ctl00_ctl35_g_7165e992_2505_4b19_ad5f_44b0d061a060"]/div/div/div/div/div/p/a/@href',	
	--'//*[@id="ctl00_ctl35_g_7165e992_2505_4b19_ad5f_44b0d061a060"]/div/div/div/div/div/a/img/@src',1,12,
	--'//*[@id="ctl00_ctl35_g_7165e992_2505_4b19_ad5f_44b0d061a060"]/div[2]/div/div[2]/div/div[10]/div/a/@href'),

	--văn bản chính sách mới bộ tư pháp
	(15,
	77,
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div/div/div/div/div/p/a/@href',	
	'',
	1,
	12,
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div[2]/div/div[2]/div/div[10]/div/a[9]/@href'),
	
	--nghiên cứu trao đổi bộ tư pháp
	--(15,
	--'//*[@id="ctl00_ctl35_g_6eb44992_0f6f_427c_9748_86a2197f142d"]/div/div/div/div/div/p/a/@href',	
	--'//*[@id="ctl00_ctl35_g_6eb44992_0f6f_427c_9748_86a2197f142d"]/div/div/div/div/div/a/img/@src',12),
	----thông tin khác bộ tư pháp
	--(15,
	--'//*[@id="ctl00_ctl35_g_e985fffc_da66_42b2_bf39_3a39075bc039"]/div/div/div/div/div/p/a/@href',	
	--'//*[@id="ctl00_ctl35_g_e985fffc_da66_42b2_bf39_3a39075bc039"]/div/div/div/div/div/a/img/@src',12),
	----phân loại bộ vhttdl
	--(16,
	--'//*[@id="mainHtml"]/body/div/div/div/div/div/div/div/a/@href',	
	--'//*[@id="mainHtml"]/body/div/div/div/div/div/div/div/a/img/@src',12),

	----phân loại bộ xây dựng
	(17,65,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',1,12,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a/@href'),

	----tin hoạt động bộ xây dựng
	(17,
	86,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a/@href'),
	--tin tổng hợp
	(17,
	17,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a[6]/@href'),
	--tin cải cách hành chính
	(17,
	87,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a/@href'),
	--Giới thiệu văn bản mới
	(17,
	88,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',
	1,
	12,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a/@href'),

	----hoạt động lãnh đạo bộ y tế
	--(18,
	--'//*[@id="p_p_id_101_INSTANCE_TW6LTp1ZtwaN_"]/div/div/div/div/div/div/div/h3/a/@href',	
	--'//*[@id="p_p_id_101_INSTANCE_TW6LTp1ZtwaN_"]/div/div/div/div/div/div/div/a/img/@src',12),
	----tin tổng hợp bộ y tế
	--(18,
	--'//*[@id="p_p_id_101_INSTANCE_k206Q9qkZOqn_"]/div/div/div/div/div/div/div/h3/a/@href',	
	--'//*[@id="p_p_id_101_INSTANCE_k206Q9qkZOqn_"]/div/div/div/div/div/div/div/a/img/@src',12),
	----thông tin chỉ đạo điều hành bộ y tế
	--(18,
	--'//*[@id="p_p_id_101_INSTANCE_DOHhlnDN87WZ_"]/div/div/div/div/div/div/div/h3/a/@href',	
	--'//*[@id="p_p_id_101_INSTANCE_DOHhlnDN87WZ_"]/div/div/div/div/div/div/div/a/img/@src',12),
	----hoạt động của địa phương bộ y tế
	--(18,
	--'//*[@id="p_p_id_101_INSTANCE_gHbla8vOQDuS_"]/div/div/div/div/div/div/div/h3/a/@href',	
	--'//*[@id="p_p_id_101_INSTANCE_gHbla8vOQDuS_"]/div/div/div/div/div/div/div/a/img/@src',12),
	----điểm tin y tế bộ y tế
	--(18,
	--'//*[@id="p_p_id_101_INSTANCE_sqTagDPp4aRX_"]/div/div/div/div/div/div/div/h3/a/@href',	
	--'//*[@id="p_p_id_101_INSTANCE_sqTagDPp4aRX_"]/div/div/div/div/div/div/div/a/img/@src',12),
	----chính phủ 
	--(22,
	--'//*[@id="tinkhac"]/table/tbody/tr/td/a/@href',	
	--'//*[@id="tinkhac"]/table/tbody/tr/td/img/@src',12),
	----viện hàn lâm khoa học công nghệ
	--(24,
	--'//*[@id="ContArticleDiv"]/div/div/a/@href',	
	--'//*[@id="ContArticleDiv"]/div/a/img/@src',12),
	----tin hợp tác quốc tế viện hàn lâm khoa học xã hội
	--(25,
	--'//*[@id="ctl00_m_g_e0136335_967d_4b76_983c_c60f79107a7f"]/div/div/div/div/p/a/@href',	
	--'//*[@id="ctl00_m_g_e0136335_967d_4b76_983c_c60f79107a7f"]/div/div[2]/div/div/a/img',12),
	----tin đào tạo viện hàn lâm khoa học xã hội
	--(25,
	--'//*[@id="ctl00_m_g_43975694_b6c8_49c4_b36e_4eedbb2bce01"]/div/div/div/div/p/a/@href',	
	--'//*[@id="ctl00_m_g_43975694_b6c8_49c4_b36e_4eedbb2bce01"]/div/div[2]/div/div/a/img',12),
	----tin hành chính tổ chức viện hàn lâm khoa học xã hội
	--(25,
	--'//*[@id="ctl00_m_g_7145028f_cb69_4dea_9572_d2a1e41740e8"]/div/div/div/div/p/a/@href',	
	--'//*[@id="ctl00_m_g_7145028f_cb69_4dea_9572_d2a1e41740e8"]/div/div[2]/div/div/a/img',12),
	----phân loại ủy ban quản lý vốn nhà nước
	--(26,
	--'//*[@id="p_p_id_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_"]/div/div/div/h2/a/@href',	
	--'//*[@id="p_p_id_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_"]/div/div/div/a/img/@src',12)
	--'//*[@id="p_p_id_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_"]/div/div/div/a/img/@src',12) */

	--tin tức sự kiện ngân hàng
	(21,
	58,
	'//*[@id="T:oc_9259810424region:j_id__ctru19pc8:2:i1:1:gl3"]/@href',	
	'//*[@id="T:oc_9259810424region:j_id__ctru19pc8:2:i4:1:i6"]	/@src',
	1,
	12,
	'//*[@id="T:oc_9259810424region:i5:2:gl4"]/@href') --không có nút trang cuối t lấy đại trang 10 á --- lấy param = 200

go
select* from ministry_info

select ministry_id,legislation_link_root, legislation_id from legislationinfo where ministry_id = 2 or ministry_id = 4 order by ministry_id

go
insert into legislation_configuration(ministry_id, legislation_name_xpath, legislation_so_hieu_van_ban, legislation_ngay_ban_hanh, legislation_ngay_hieu_luc, 
			legislation_ngay_ky, legislation_trich_yeu, legislation_co_quan_ban_hanh, legislation_nguoi_ky, 
			legislation_loai_van_ban, legislation_tinh_trang, legislation_link_download) values
	--Bộ công thương - vb quy pham pháp luật
	(2,
	'//*[@id="p_p_id_ELegalDocumentView_WAR_ELegalDocumentportlet_INSTANCE_ixT9f4WbWm6A_"]/div/div/section/h4/text()',
	'//*[@id="table_pna"]/tr[1]/td[2]/text()',
	'//*[@id="table_pna"]/tr[2]/td[2]/text()',
	'//*[@id="table_pna"]/tr[3]/td[2]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="table_pna"]/tr[5]/td[2]/text()',
	'//*[@id="table_pna"]/tr[6]/td[2]/text()',
	'//*[@id="table_pna"]/tr[7]/td[2]/text()',
	'//*[@id="table_pna"]/tr[8]/td[2]/text()',
	'//*[@id="table_pna"]/tr[9]/td[2]/text()',
	'//*[@id="table_pna"]/tr[10]/td[2]/div/div/a/@href'),
	
	--Bộ công thương - vb điều hành
	(2,
	'//*[@id="p_p_id_ELegalDocumentView_WAR_ELegalDocumentportlet_INSTANCE_bxuLX3gTZKHk_"]/div/div/section/h4/text()',
	'//*[@id="table_pna"]/tr[1]/td[2]/text()',
	'//*[@id="table_pna"]/tr[2]/td[2]/text()',
	'//*[@id="table_pna"]/tr[3]/td[2]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="table_pna"]/tr[5]/td[2]/text()',
	'//*[@id="table_pna"]/tr[6]/td[2]/text()',
	'//*[@id="table_pna"]/tr[7]/td[2]/text()',
	'//*[@id="table_pna"]/tr[8]/td[2]/text()',
	'//*[@id="table_pna"]/tr[9]/td[2]/text()',
	'//*[@id="table_pna"]/tr[10]/td[2]/div/div/a/@href'
	),
	--Bộ công an - văn bản quy phạm pháp luật
	(1,
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[6]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[7]/td[2]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[4]/td[2]/text()',	
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[5]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[3]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[8]/td[2]/text()',
	'//*[@id="A2"]/@href'
	),

	--Bộ giáo dục -- văn bản quy phạm pháp luật 
	(4,
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[2]/td[4]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[4]/td[4]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[4]/td[2]/span[1]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[4]/td[2]/span[2]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[3]/td[2]/text()',
	'//*[@id="content_1"]/div/div/div[1]/ul/li[1]/text()',
	'//*[@id="ctl00_ctl24_g_a9eee66b_a86f_4cc0_b32d_539fafedbf9b"]/div[1]/div[1]/div/div/ul/li[3]/a/@href'
	),

	--Bộ giáo dục -- văn bản chỉ đạo điều hành
	(4,
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[2]/td[4]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[4]/td[4]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[4]/td[2]/span[1]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[4]/td[2]/span[2]/text()',
	'//*[@id="content_2"]/div/div/div[2]/table/tbody/tr[3]/td[2]/text()',
	'//*[@id="content_1"]/div/div/div[1]/ul/li[1]/text()',
	'//*[@id="ctl00_ctl24_g_a9eee66b_a86f_4cc0_b32d_539fafedbf9b"]/div[1]/div[1]/div/div/ul/li[3]/a/@href' -- bấm tải về hiện ra màn hình giống drive á, rồi phải bấm nút tải về nữa á m
	),

	--Bộ gtvt -- văn bản điều hành
	(5,
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4"]/div[1]/ul/li[4]/a/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblSoKyHieu"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNgayBanHanh"]/text()',
	'', --không có ngày hiệu lực
	'', -- không hiển thị ngày ký
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNoiDung"]/text()',
	'//*[@id="row_donvibanhanh_chinh"]/td[2]/text()',
	'//*[@id="row_donvibanhanh_chinh"]/td[3]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblLoaiVanBan"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblHieuluc"]/text()',
	'//*[@id="row_file"]/td[2]/span/strong/a/@href'
	),

	--Bộ gtvt -- văn bản pháp quy
	(5,
	'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[2]/td[4]/text()',
	'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[3]/td[4]/text()', --không có ngày hiệu lực
	'', -- không hiển thị ngày ký
	'', -- không có trích yếu
	'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[6]/td[2]/a/text()',
	'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[6]/td[4]/text()',
	'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[3]/td[2]/a/text()',
	'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[9]/td/text()',
	'//*[@class="fileAttack"]/@href'
	),
	
	--Bộ kế họoch và đâu tư, link download và các thuộc tính nằm khác trang
	(6,
	'//*[@id="ctl00_SPWebPartManager1_g_b2db5875_034d_426d_b939_7d77cef045d2_ctl00_lblTenVanBan"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_b2db5875_034d_426d_b939_7d77cef045d2_ctl00_lblSH"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_b2db5875_034d_426d_b939_7d77cef045d2_ctl00_lblNgayBH"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_b2db5875_034d_426d_b939_7d77cef045d2_ctl00_lblNgayHL"]/text()',
	'', -- không hiển thị ngày ký
	'', -- không có trích yêu
	'//*[@id="ctl00_SPWebPartManager1_g_b2db5875_034d_426d_b939_7d77cef045d2_ctl00_divDetails"]/div[2]/table/tr[1]/td/table/tr[6]/td[2]/table/tr/td/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_b2db5875_034d_426d_b939_7d77cef045d2_ctl00_divDetails"]/div[2]/table/tr[1]/td/table/tr[7]/td[2]/table/tr/td/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_b2db5875_034d_426d_b939_7d77cef045d2_ctl00_lblLVB"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_b2db5875_034d_426d_b939_7d77cef045d2_ctl00_lblTrangThai"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_b2db5875_034d_426d_b939_7d77cef045d2_ctl00_hlDownload"]/@href' --sao không lấy được ta ơi haiz
	),
	
	--Bộ khcn văn bản chỉ đạo điều hành
	(7,
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_pnInfo"]/div/div[1]/table/tr[1]/td/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblSoKyHieu"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNgayBanHanh"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNgayHieuLuc"]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblNoiDung"]',
	'//*[@id="row_donvibanhanh_chinh"]/td[2]/text()',
	'//*[@id="row_donvibanhanh_chinh"]/td[3]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_e110b351_5abc_4e84_8b93_9040a3dbe6c4_ctl00_lblLoaiVanBan"]/text()',
	'', --không có tình trạng
	'//*[@id="row_file"]/td[2]/strong/a/@href'
	),

	-- tự nhiên coi không được má :)
	--Bộ khcn văn bản pháp quy
	--(7,
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[1]/td/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[2]/td[2]/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[2]/td[4]/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[3]/td[4]/text()',
	--'', -- không hiển thị ngày ký
	--'', -- không có trích yêu
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[6]/td[2]/a/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[6]/td[4]/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[3]/td[2]/a/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[1]/ul/li[1]/text()',
	--'//*[@id="VanBanGoc_282382.pdf"]/@href'	--link tải file không nằm cùng trang
	--),

	--Bộ lao động văn bản pháp quy -- giống i bộ khcn luôn, nên đâu có lấy xpath đúng được :)
	--(8,
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[1]/td/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[2]/td[2]/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[2]/td[4]/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[3]/td[4]/text()',
	--'', -- không hiển thị ngày ký
	--'', -- không có trích yêu
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[6]/td[2]/a/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[6]/td[4]/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[2]/table/tbody/tr[3]/td[2]/a/text()',
	--'//*[@id="ctl00_ctl36_g_96f2018b_9950_46cb_90cc_c518b29bcf76"]/div[1]/div/div[3]/div/div[1]/ul/li[1]/text()',
	--'//*[@id="VanBanGoc_282382.pdf"]/@href'	--link tải file không nằm cùng trang
	--),
	
	--Bộ lao động văn bản chỉ đạo điều hành
	(8,
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/ul/li[3]/a/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[1]/td[2]/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[3]/td[2]/text()',
	'', -- không hiển thị ngày hiệu lực
	'', -- không hiển thị ngày ký
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[6]/td[2]/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[7]/td[2]/text()',
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[4]/td[2]/text()',
	'', --không có tình trạng
	'//*[@id="ctl00_ctl50_g_8dc7adfa_0328_4c6a_b1db_cad679bd14a1"]/div/div/table/tbody/tr[10]/td[2]/p/a/@href'
	),

	--Bộ nội vụ văn bản vi phạm pháp luật --link thuộc tính và link tải khác nhau
	(3,
	'//*[@class="tab-content"]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[2]/td[4]/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[3]/td[4]/text()',	
	'', -- không hiển thị ngày ký
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[1]/td/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[6]/td[2]/ul/li/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[6]/td[2]/ul/li/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_divthuoctinh"]/table/tbody/tr[3]/td[2]/text()',
	'//*[@id="dnn_ctr3988_IndexLawDetail_komat"]/div/div/div/div[1]/span/text()', --tình trạng nằm ở tab khác
	'//*[@id="dnn_ctr3988_IndexLawDetail_divtaive"]/ul/li[1]/a/@href' --link download nằm ở tab khác
	),

	--Bộ nông nghiệp văn bản chỉ đạo điều hành
	(10,
	'//*[@id="main_content"]/div[1]/div/div/div/div/div/div/div[1]/span/text()',
	'//*[@id="main_content"]/div[1]/div/div/div/div/div/div/div[2]/div/div/div[1]/div/p/text()',
	'//*[@id="ngaybanhanh"]/text()', --không xem ngày được, page source cũng thế
	'//*[@id="ngayhieuluc"]/text()', --như trên
	'', -- không hiển thị ngày ký
	'//*[@id="main_content"]/div[1]/div/div/div/div/div/div/div[2]/div/div/div[2]/div/p/text()',
	'//*[@id="main_content"]/div[1]/div/div/div/div/div/div/div[2]/div/div/div[8]/div/table/tbody/tr/td[1]/text()',
	'//*[@id="main_content"]/div[1]/div/div/div/div/div/div/div[2]/div/div/div[8]/div/table/tbody/tr/td[2]/text()',
	'//*[@id="main_content"]/div[1]/div/div/div/div/div/div/div[2]/div/div/div[7]/div/p/text()',
	'', --không có tình trạng
	'//*[@id="listFile"]/li[1]/a[2]/@href' 
	),

	--Bộ quốc phòng văn bản pháp luật
	(11,
	'//*[@id="tabother2"]/table/tr[2]/td[2]/text()',
	'//*[@id="tabother2"]/table/tr[2]/td[2]/text()',
	'//*[@id="tabother2"]/table/tr[3]/td[2]/text()', 
	'//*[@id="tabother2"]/table/tr[4]/td[2]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="tabother2"]/table/tr[1]/th[2]/text()',
	'//*[@id="tabother2"]/table/tr[6]/td[2]/text()',
	'//*[@id="tabother2"]/table/tr[8]/td[2]/text()',
	'//*[@id="tabother2"]/table/tr[7]/td[2]/text()',
	'', --không có tình trạng
	'' --không có link download
	),

	--Bộ tài chính văn bản quy phạm pháp luật -- không có lấy data được luôn á, trong page source cũng thế
	--(12,
	--'//*[@id="content"]/div/div[2]/div[1]/em/a/text()',
	--'//*[@id="thuoctinh"]/table/tbody/tr[1]/td[2]/text()',
	--'//*[@id="thuoctinh"]/table/tbody/tr[1]/td[4]/text()',
	--'//*[@id="thuoctinh"]/table/tbody/tr[2]/td[4]/text()',	
	--'', -- không hiển thị ngày ký
	--'', -- không có trích yếu
	--'//*[@id="thuoctinh"]/table/tbody/tr[6]/td[2]/div/text()',
	--'//*[@id="thuoctinh"]/table/tbody/tr[6]/td[4]/text()',
	--'//*[@id="thuoctinh"]/table/tbody/tr[2]/td[2]/text()',
	--'//*[@id="thuoctinh"]/table/tbody/tr[9]/td[2]/text()',
	--'--//*[@id="taive"]/table/tbody/tr/td/a/@href' 
	--),
	--Bộ quốc phòng không có văn bản chỉ đạo điều hành
	--Bộ thông tin truyền thông văn bản qppl
	(14,
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146_ctl00_lbTieuDe"]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[1]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[3]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[4]/td[2]/text()',	
	'', -- không hiển thị ngày ký
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[2]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[8]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[9]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[6]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[5]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[12]/td[2]/p/a/@href' 
	),

	--Bộ thông tin truyền thông văn bản chỉ đạo điều hành giống văn bản qppl
	(14,
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146_ctl00_lbTieuDe"]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[1]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[3]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[4]/td[2]/text()',	
	'', -- không hiển thị ngày ký
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[2]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[8]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[9]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[6]/td[2]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[5]/text()',
	'//*[@id="ctl00_ctl46_g_291fb6cc_d347_4bbc_b299_461301d6f146"]/div[2]/table/tr[12]/td[2]/p/a/@href' 
	),

	--Bộ tư pháp phải đăng nhập với lỗi link khum vô được
	--Bộ thể thao du lịch vb qppl
	(16,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/h3/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[1]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[2]/td/text()',
	'',	-- không có ngày hiệu lực
	'', -- không hiển thị ngày ký
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[4]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[5]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[3]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[6]/td/text()',
	'', --không có tình trạng
	'' --khong lấy link tải được, có xpath
	),

	--Bộ thể thao du lịch vb cddh giống vb qppl
	(16,
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/h3/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[1]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[2]/td/text()',
	'',	-- không có ngày hiệu lực
	'', -- không hiển thị ngày ký
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[4]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[5]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[3]/td/text()',
	'//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/table/tr[6]/td/text()',
	'', --không có tình trạng
	''  --không lấy link được như trên
	),

	--Bộ xây dựng khum vào được :<
	--Bộ y tế văn bản - phải đăng nhập
	--(18,
	--'//*[@id="mask-cover"]/div/div[1]/span/text()',
	--'//*[@id="details-content-meta"]/ul/li[2]/text()',
	--'//*[@id="details-content-meta"]/ul/li[12]/text()',
	--'',	-- không có ngày hiệu lực
	--'', -- không hiển thị ngày ký
	--'//*[@id="details-content-meta"]/ul/li[4]/text()',
	--'//*[@id="details-content-meta"]/ul/li[10]/text()',
	--'//*[@id="details-content-meta"]/ul/li[6]/text()',
	--'//*[@id="details-content-meta"]/ul/li[14]/text()',
	--'', --không có tình trạng
	--'//*[@id="details-content-meta"]/div[6]/table/tbody/tr/td[2]/a/@href' 
	--),
	--không vào trang của chính phủ đượt :<

	--Ủy ban dân tộc văn bản
	(20,
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[1]/td[2]/p/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[1]/td[2]/p/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[3]/td[2]/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[4]/td[2]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[5]/td[2]/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[6]/td[2]/ul/li/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[8]/td[2]/ul/li/text()',
	'//*[@id="details-content-meta"]/ul/li[14]/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[1]/tr[2]/td[2]/text()',
	'//*[@id="ctl00_m_g_6f9eabc6_a015_44fc_a1e5_288b6473100a"]/div[1]/table[2]/tr/td[2]/a/@href' 
	),

	-- Ngân hàng không lấy xpath được tại vì show nguyên cái văn bản lun
	-- VP chính phủ khum có show văn bản
	-- Bảo hiểm xã hội vb nói chung
	(23,
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[1]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[4]/strong/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[2]/div[1]/div[2]/strong/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[2]/div[2]/div[2]/strong/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[4]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[1]/div[2]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[1]/div[5]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[1]/div[1]/div[2]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[2]/div[3]/div[2]/text()',
	'//*[@id="ctl00_ctl39_g_527b57c5_f302_441a_826e_adb1bd203d1e"]/div[2]/div/div[1]/div/div[2]/div/div/div[1]/div[2]/div[1]/div[4]/div[2]/div/a/@href' 
	),

	-- Viện hàn lâm KHCN khum hiện ngày ký
	-- Viện hàn lâm KHXH khum hiện ngày ký
	-- Ủy ban quản lý vốn nhà nước văn bản nói chung
	(26,
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[1]/div/h1/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[1]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[2]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[3]/td[2]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[5]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[6]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[4]/td[2]/text()',
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[7]/td[2]/text()',
	'', -- không hiển thị tình trạng
	'//*[@id="p_p_id_dsvanbanphapquy_WAR_vnpteportalappportlet_"]/div/div/div[2]/table/tr[8]/td[2]/a/@href' -- mở ra cửa sổ như drive -> nhấn nút tải
	)


go
alter table article_info add constraint ai_category_id_ci foreign key (category_id) references category_info(category_id)
go
alter table category_info add constraint ci_ministry_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table legislation_info add constraint li_ministry_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table ministry_articles_configuration add constraint mac_ministry_article_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table ministry_category_configuration add constraint mlc_ministry_legislation_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table ministry_legislation_configuration add constraint mcc_ministry_article_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table article_img add constraint aimg_article_id_ainfo foreign key (article_id) references article_info(article_id)
go
alter table legislation_configuration add constraint lc_ministry_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table category_info add constraint ci_category_type_id_ct foreign key (category_type_id) references category_type(category_type_id)
go
alter table legislationinfo add constraint li_legislation_type_id_lt foreign key (legislation_type_id) references legislation_type(legislation_type_id)
go 
alter table ministry_category_configuration add constraint mcc_category_id_ci foreign key (category_id) references category_info(category_id) 

/*
go
sp_who
USE [master];

DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('WebDB')

EXEC(@kill);

go
use master
drop database WebDB
*/