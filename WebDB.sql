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
	legislation_id int PRIMARY KEY,
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

go
alter table article_info add constraint ai_category_id_ci foreign key (category_id) references category_info(category_id)
go
alter table category_info add constraint ci_ministry_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table legislation_info add constraint li_ministry_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table ministry_articles_configuration add constraint mac_ministry_article_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table ministry_category_configuration add constraint mcc_ministry_article_id_mi foreign key (ministry_id) references ministry_info(ministry_id)
go
alter table article_img add constraint aimg_article_id_ainfo foreign key (article_id) references article_info(article_id)
go
alter table legislation_configuration add constraint lc_legislation_id_li foreign key (legislation_id) references legislation_info(legislation_id)
go
alter table category_info add constraint ci_category_type_id_ct foreign key (category_type_id) references category_type(category_type_id)
go 
alter table ministry_category_configuration add constraint mcc_category_id_ci foreign key (category_id) references category_info(category_id) 

/*go
alter table article_link
drop column ministry
add category nvarchar(50)
*/


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
select * from ministry_info

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

go
select * from category_info
go
select * from ministry_info

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
select * from category_info;

go
insert into ministry_category_configuration(ministry_id,category_id,article_url_xpath,article_thumbnail_xpath,page_rule,schedule_minute,article_param_xpath) values
	--phân loại tin tức bộ công thương
	(2, 1,
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',
	1,12,
	'//*[@id="_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_ocerSearchContainerPageIterator"]/div/ul//a/@href'),
	--phân loại tin tức bộ công an
	(1, 7,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[11]/div/a/@href'),
	--thông cáo báo chí - tin tổng hợp bộ giáo dục
	(4, 15,
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/a/img/@src',1,12,
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div[2]/div[2]/div/a/@href'),
	--thông báo bộ giáo dục
	(4, 16, 
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div[2]/div/ul/li/a/img/@src',1,12,
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div[2]/div[2]/div/a/@href'),
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
	--tin tức-sự kiện bộ nội vụ
	--(3,
	--'//*[@id="list_news"]/div[1]/div/div/ul/li/p/a/@href',	
	--'//*[@id="list_news"]/div/div/div/ul/li/a/img/@src',12), ---không lấy được param
	--tin tức-sự kiện bộ quốc phòng
	(11, 53,
	'//*[@id="listArticle"]/div/div/h1/a/@href',	
	'//*[@id="listArticle"]/div/div[1]/a/img/@src',1,12,
	'//*[@class="page"]/a/@href'),
	--tin tức-sự kiện bộ tài chính
	--(12,
	--'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	--'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',12),
	----tin địa phương bộ ''
	--(12,
	--'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	--'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',12),
	----tin video bộ ''
	--(12,
	--'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	--'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',12),
	--phân loại tin tức bộ thông tin và truyền thông
	(14, 54,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',1,12,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div[2]/div[2]/ul/li[7]/a/@href'),
	--chỉ đạo điều hành bộ tư pháp
	--(15,61,
	--'//*[@id="ctl00_ctl35_g_7165e992_2505_4b19_ad5f_44b0d061a060"]/div/div/div/div/div/p/a/@href',	
	--'//*[@id="ctl00_ctl35_g_7165e992_2505_4b19_ad5f_44b0d061a060"]/div/div/div/div/div/a/img/@src',1,12,
	--'//*[@id="ctl00_ctl35_g_7165e992_2505_4b19_ad5f_44b0d061a060"]/div[2]/div/div[2]/div/div[10]/div/a/@href'),
	--văn bản chính sách mới bộ tư pháp
	(15,60,
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div/div/div/div/div/p/a/@href',	
	'',1,12,'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div[2]/div/div[2]/div/div[10]/div/a/@href'),
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
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_PhanTrang_D"]/div/a/@href')
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

go
select * from ministry_category_configuration

go
select ministry_id,article_url_xpath,article_thumbnail_xpath from ministry_category_configuration where ministry_id = 1 or ministry_id = 2 or ministry_id = 4 or ministry_id = 8 or ministry_id = 15 order by ministry_id asc

go
select ministry_id,page_rule,article_param_xpath from ministry_category_configuration

go
select article_title_xpath,article_description_xpath,article_time_xpath,article_author_xpath,article_content_xpath from ministry_articles_configuration where ministry_id = 1

go
select* from ministry_info

go 
insert into ministry_articles_configuration(ministry_id,article_title_xpath,article_description_xpath,article_time_xpath,
											article_author_xpath,article_content_xpath, article_tag_xpath) values
	
	--Bộ công thương
	(2,
	'//div[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/h1/text()',
	'//p[@id="change_font_size"]/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/p[1]/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/div[2]/div[2]/text()',
	'//*[@id="contentnews"]/p/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/div/header/a[1]/text()'
	),
	--Bộ công an
	(1,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/h1/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[2]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[1]/div[1]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[5]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[4]/div/p/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[1]/ul/li/a/text()'
	),	
	--Bộ giáo dục
	(4,
	'//*[@id="news-title"]/text()',
	'//*[@id="news-des"]/text()',
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div[2]/div/div[1]/div/div[1]/p/span[1]/text()',
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div[2]/div/div[1]/div/p/text()',
	'//*[@id="news-detail"]/div/p/text()',
	' '
	),	
	--Bộ giao thông vận tải
	(5,
	'//*[@id="divArticleDescription3"]/h1/text()',
	'//*[@id="divArticleDescription1"]/p/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_275cd07f_7dd8_4f62_97b3_19577a1ec443_ctl00_pnHide"]/span/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_275cd07f_7dd8_4f62_97b3_19577a1ec443_ctl00_pnNguontin"]/p/font/text()',
	'//*[@id="divArticleDescription2"]/p/span/span/text()',
	' '
	),	
	--Bộ khoa học công nghệ
	(7,
	'//*[@id="divArticleDescription3"]/h1/text()',
	'//*[@id="divArticleDescription1"]/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_275cd07f_7dd8_4f62_97b3_19577a1ec443_ctl00_pnNguontin"]/p[1]/font/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_275cd07f_7dd8_4f62_97b3_19577a1ec443_ctl00_pnNguontin"]/p/font/text()',
	'//*[@id="divArticleDescription2"]/div/p/text()',
	' '
	),	
	--Bộ lao động - thương binh xã hội
	(8,
	'//*[@id="ctl00_ctl50_g_8ad360dc_c37c_41f7_aa64_94b051f219f8"]/div[1]/div[1]/h1/text()',
	'//*[@id="divArticleDescription"]/p[1]/text()',
	'//*[@id="ctl00_ctl50_g_8ad360dc_c37c_41f7_aa64_94b051f219f8"]/div[1]/div[1]/p/text()',
	'//*[@id="divArticleDescription"]/div[10]/strong/em/text()',
	'//*[@id="divArticleDescription"]/div/text()',
	' '
	),	
	--Bộ ngoại giao
	(9,
	'//*[@id="WebPartWPQ1"]/table/tbody/tr[1]/td/text()',
	'//*[@id="WebPartWPQ1"]/table/tbody/tr[2]/td/div[1]/text()',
	'//*[@id="WebPartWPQ1"]/table/tbody/tr[1]/td/div[1]/text()',
	' ',
	'//*[@id="WebPartWPQ1"]/table/tbody/tr[2]/td/div[2]/div/p/font',
	' '
	),	
	--Bộ nội vụ
	(3,
	'//*[@id="news_details"]/div[3]/div/div[1]/h1/text()',
	'//*[@id="show_description"]/p/text()',
	'//*[@id="news_details"]/div[3]/div/div[1]/div[1]/p/text()',
	'//*[@id="show_content"]/p/b/text()',
	'//*[@id="show_content"]/p/text()',
	' '
	),	
	--Bộ nông nghiệp và phát triển nông thôn
	(10,
	'//*[@id="txtTitle"]/text()',
	'//*[@id="divArticleDescription"]/p[1]/text()',
	'//*[@id="txtDateString"]/text()',
	'//*[@id="divArticleDescription"]/p[2]/text()',
	'//*[@id="ctl00_PlaceHolderMain_ctl00_ctl07__ControlWrapper_RichHtmlField"]/p/text()',
	'//*[@id="Tags"]/a/span/text()'
	),	
	--Bộ quốc phòng
	(11,
	'//*[@id="layoutContainers"]/div/table/tbody/tr/td[1]/table/tbody/tr/td/div/div/div[4]/div[1]/h1/span/text()',
	'//*[@id="layoutContainers"]/div/table/tbody/tr/td[1]/table/tbody/tr/td/div/div/div[4]/div[1]/div[1]/p[1]/text()',
	'//*[@id="layoutContainers"]/div/table/tbody/tr/td[1]/table/tbody/tr/td/div/div/div[4]/div[1]/h2/text()',
	'//*[@id="layoutContainers"]/div/table/tbody/tr/td[1]/table/tbody/tr/td/div/div/div[4]/div[1]/div[2]/b/span	/text()',
	'//*[@id="layoutContainers"]/div/table/tbody/tr/td[1]/table/tbody/tr/td/div/div/div[4]/div[1]/div[1]/p/text()',
	' '
	),	
	--Bộ tài chính
	(12,
	'//*[@id="T:oc_5868747166region1:listTmplt:pbl6"]/text()',
	'//*[@id="T:oc_5868747166region1:listTmplt:pbl8"]/div[3]/div/div/p[1]/text()',
	'//*[@id="T:oc_5868747166region1:listTmplt:pbl33"]/span[1]/text()',
	'//*[@id="T:oc_5868747166region1:listTmplt:pbl8"]/div[3]/div/div/p[11]/span/text()',
	'//*[@id="T:oc_5868747166region1:listTmplt:pbl8"]/div[3]/div/div/p/text()',
	' '
	),	
	--Bộ thông tin truyền thông
	(14,
	'//*[@id="news_content"]/div[1]/h1/text()',
	'//*[@id="divArticleDescription"]/p/text()',
	'//*[@id="news_content"]/div[1]/div[1]/div[1]/div/text()',
	'//*[@id="news_content"]/div[1]/p[1]/strong/text()',
	'//*[@id="divArticleContent"]/p/text()',
	'//*[@id="news_content"]/div[1]/p[3]/a/text()'
	),	
	--Bộ tư pháp
	(15,
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div/div/div[2]/div[2]/div/h1/text()',
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div/div/div[2]/div[2]/div/div[2]/text()',
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div/div/div[2]/div[2]/div/span/text()',
	' ',
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div/div/div[2]/div[2]/div/div[3]/p/text()',
	' '
	),	
	--Bộ xây dựng
	(17,
	'//*[@id="divArticleDescription3"]/h1/text()',
	'//*[@id="divArticleDescription1"]/p/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_9c0a5a28_df68_408d_abaa_1ef0666cf35c_ctl00_pnHide"]/div[2]/span/text()',
	'//*[@id="ctl00_SPWebPartManager1_g_9c0a5a28_df68_408d_abaa_1ef0666cf35c_ctl00_pnNguontin"]/p/font/text()',
	'//*[@id="divArticleDescription2"]/p/text()',
	' '
	),	
	--Bộ y tế
	(18,
	'//*[@id="p_p_id_101_INSTANCE_3Yst7YhbkA5j_"]/div/div/div/div[1]/div[1]/h3/text()',
	'//*[@id="_101_INSTANCE_3Yst7YhbkA5j_753365"]/div[1]/p/strong/text()',
	'//*[@id="p_p_id_101_INSTANCE_3Yst7YhbkA5j_"]/div/div/div/div[1]/div[2]/div[1]/p/text()',
	'//*[@id="_101_INSTANCE_3Yst7YhbkA5j_753365"]/div[3]/h2/span/text()',
	'//*[@id="_101_INSTANCE_3Yst7YhbkA5j_753365"]/div[3]/h2/text()',
	' '
	),	
	--chính phủ
	(19,
	'//*[@id="aspnetForm"]/div[9]/div[1]/div[1]/h1/text()',
	'//*[@id="aspnetForm"]/div[9]/div[1]/div[2]/div[2]/div[1]/text()',
	'//*[@id="aspnetForm"]/div[9]/div[1]/div[1]/p/text()',
	'//*[@id="aspnetForm"]/div[9]/div[1]/div[2]/div[2]/div[2]/strong/text()',
	'///*[@id="aspnetForm"]/div[9]/div[1]/div[2]/div[2]/p/text()',
	'//*[@id="aspnetForm"]/div[9]/div[1]/div[2]/div[2]/p[2]/span[2]/a/text()'
	),	
	--Ủy ban dân tộc
	(20,
	'//*[@id="BodyContent_ctl00_ctl01_newsTitle"]/text()',
	'//*[@id="BodyContent_ctl00_ctl01_newsContent"]/text()',
	'//*[@id="BodyContent_ctl00_ctl01_lblDate"]/text()',
	'//*[@id="BodyContent_ctl00_ctl02_lblNguonThongTin"]/text()',
	'//*[@id="divNewsDetails"]/p/text()',
	' '
	),	
	--ngân hàng
	(21,
	'//*[@id="T:oc_7115552043region:pbl6"]/text()',
	'//*[@id="pbl20"]/text()',
	'//*[@id="T:oc_7115552043region:j_id__ctru16pc8"]/label/text()',
	'//*[@id="pbl21"]/div/p/text()',
	'//*[@id="pbl21"]/div/p/span/text()',
	' '
	),	
	--văn phòng chính phủ
	(22,
	'//*[@id="ctl00_bodyContent_lbHeadline"]/text()',
	'//*[@id="primarycontent"]/div[2]/div[4]/p/text()',
	'//*[@id="ctl00_bodyContent_lbDate"]/text()',
	' ',
	'//*[@id="primarycontent"]/div[2]/p/text()',
	' '
	),	
	--Bảo hiểm xã hội
	(23,
	'//*[@id="ctl00_ctl39_g_39077cd2_a1b4_4fab_a70a_fa7caf624e92"]/div[2]/div[2]/div[2]/div[1]/p/text()',
	'//*[@id="contenttin"]/p[1]/text()',
	'//*[@id="ctl00_ctl39_g_39077cd2_a1b4_4fab_a70a_fa7caf624e92"]/div[2]/div[2]/div[2]/div[2]/div/p/text()',
	'//*[@id="contenttin"]/p/text()',
	'//*[@id="contenttin"]/div/p/text()',
	' '
	),	
	--ủy ban quản lý vốn nhà nước
	(26,
	'//*[@id="testabc"]/div[1]/h1/text()',
	'//*[@id="testabc"]/p/strong/text()',
	'//*[@id="testabc"]/div[1]/p/text()',
	'//*[@id="testabc"]/div[2]/p/text()',
	'//*[@id="testabc"]/div[2]/div/p/text()',
	' '
	),	
	--viện hàn lâm khcn
	(24,
	'//*[@id="contentnews"]/h1/text()',
	'//*[@id="contentnews"]/div[2]/text()',
	'/html/body/div/header/section/div/text()',
	'//*[@id="contentnews"]/div[5]/div[1]/text()',
	'//*[@id="contentnews"]/div[4]/p/text()',
	' '
	),	
	--viện hàn lâm khxh
	(25,
	'//*[@id="ctl00_m_g_f5a086cc_d90c_4742_8d72_0b1dd429f5b4"]/div[2]/div/div/div/div/div/h1/text()',
	'//*[@id="ctl00_m_g_f5a086cc_d90c_4742_8d72_0b1dd429f5b4"]/div[2]/div/div/div/div/div/div[1]/p[2]/text()',
	'//*[@id="ctl00_m_g_f5a086cc_d90c_4742_8d72_0b1dd429f5b4"]/div[2]/div/div/div/div/div/div[1]/p[1]/text()',
	'//*[@id="anhnoidungdetail"]/p/strong/text()',
	'//*[@id="anhnoidungdetail"]/p/text()',
	' '
	)

go
select ministry_id,category_link_root from category_info order by ministry_id asc

--go
--insert into category_info (ministry_id,category_name,category_type_id,category_link_root) values
--	(1, N'Thời sự - Bộ Công Thương',1, 'http://www.moit.gov.vn/web/guest/thoi-su?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur='),
--	(2, N'Thời sự - Bộ Công Thương',1, 'https://moet.gov.vn/tintuc/Pages/Thongbao.aspx?date=&EventID=0&Page='),
--	(3, N'Thời sự - Bộ Công Thương',1, 'http://www.moit.gov.vn/web/guest/thoi-su?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur='),
--	(1, N'Thời sự - Bộ Công Thương',1, 'http://www.moit.gov.vn/web/guest/thoi-su?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur=')


go
select * from category_info 

--go
--insert into article_link(article_url, mabo, link_root,loai_link,ten_link,page_param,page_rule,schedule_minute) values
--	('http://www.moit.gov.vn/web/guest/thoi-su','G02','/web/guest/thoi-su','internal','bo cong thuong muc thoi su',2,1, getdate()),
--	('http://bocongan.gov.vn/tin-tuc-su-kien/chi-dao-dieu-hanh-24.html','G01','/tin-tuc-su-kien/chi-dao-dieu-hanh-24.html','internal','bo con an muc chi dao dieu hanh',2,1, getdate()),
--	('https://moet.gov.vn/tintuc/Pages/thong-cao-bao-chi.aspx','G03','/tintuc/Pages/thong-cao-bao-chi.aspx','internal','bo giao duc va dao tao muc thong cao bao chi',2,1, getdate()),
--	('https://www.mt.gov.vn/vn/Pages/Tintuc.aspx','G04','/vn/Pages/Tintuc.aspx','internal','bo giao duc va dao tao muc tin tuc',2,1, getdate()),
--	('http://www.mpi.gov.vn/Pages/ttptktxh.aspx','G05','/Pages/ttptktxh.asp','internal','bo ke hoach va dau tu muc thong tin phat trien kinh te xa hoi',2,1, getdate())

--go
--INSERT INTO bonganh
--    (mabo, tenbo, gioithieuchung, chucnang)
--VALUES
--    ('G01', N'Bộ Công an',N'Công an nhân dân là lực lượng vũ trang nhân dân làm nòng cốt trong thực hiện nhiệm vụ bảo vệ an ninh quốc gia, bảo đảm trật tự, an toàn xã hội, đấu tranh phòng, chống tội phạm và vi phạm pháp luật về an ninh quốc gia, trật tự, an toàn xã hội.',N'Công an nhân dân có chức năng tham mưu với Đảng, Nhà nước về bảo vệ an ninh quốc gia, bảo đảm trật tự, an toàn xã hội, đấu tranh phòng, chống tội phạm và vi phạm pháp luật về an ninh quốc gia, trật tự, an toàn xã hội; thực hiện quản lý nhà nước về bảo vệ an ninh quốc gia, bảo đảm trật tự, an toàn xã hội, đấu tranh phòng, chống tội phạm và vi phạm pháp luật về an ninh quốc gia, trật tự, an toàn xã hội; đấu tranh phòng, chống âm mưu, hoạt động của các thế lực thù địch, các loại tội phạm và vi phạm pháp luật về an ninh quốc gia, trật tự, an toàn xã hội.' ),
--	('G02', N'Bộ Công Thương',N'Bộ Công Thương là cơ quan của Chính phủ, thực hiện chức năng quản lý nhà nước về công nghiệp và thương mại',N'Điện, than, dầu khí, năng lượng mới, năng lượng tái tạo, hóa chất, vật liệu nổ công nghiệp, công nghiệp cơ khí, luyện kim, công nghiệp khai thác mỏ và chế biến khoáng sản, công nghiệp tiêu dùng, công nghiệp thực phẩm, công nghiệp hỗ trợ, công nghiệp môi trường, công nghiệp công nghệ cao; cụm công nghiệp, tiểu thủ công nghiệp, khuyến công; thương mại trong nước; xuất nhập khẩu, thương mại biên giới; phát triển thị trường ngoài nước; quản lý thị trường; xúc tiến thương mại; thương mại điện tử; dịch vụ thương mại; hội nhập kinh tế quốc tế; cạnh tranh, bảo vệ quyền lợi người tiêu dùng, phòng vệ thương mại; các dịch vụ công trong các ngành, lĩnh vực thuộc phạm vi quản lý nhà nước của bộ.' ),
--	('G03', N'Bộ Giáo dục và Đào tạo',N'Bộ Giáo dục và Đào tạo là cơ quan của Chính phủ, thực hiện chức năng quản lý nhà nước đối với giáo dục mầm non, giáo dục phổ thông, trung cấp sư phạm, cao đẳng sư phạm, giáo dục đại học và các cơ sở giáo dục khác',N'quản lý nhà nước đối với giáo dục mầm non, giáo dục phổ thông, trung cấp sư phạm, cao đẳng sư phạm, giáo dục đại học và các cơ sở giáo dục khác về: Mục tiêu, chương trình, nội dung giáo dục; quy chế thi, tuyển sinh và văn bằng, chứng chỉ; phát triển đội ngũ nhà giáo và cán bộ quản lý giáo dục; cơ sở vật chất và thiết bị trường học; bảo đảm chất lượng, kiểm định chất lượng giáo dục; quản lý nhà nước các dịch vụ sự nghiệp công thuộc phạm vi quản lý nhà nước của bộ.' ),
--	('G04', N'Bộ Giao thông vận tải',N'Bộ Giao thông vận tải là cơ quan của Chính phủ, thực hiện chức năng quản lý nhà nước về giao thông vận tải đường bộ',N'quản lý nhà nước về giao thông vận tải đường bộ, đường sắt, đường thủy nội địa, hàng hải, hàng không trong phạm vi cả nước; quản lý nhà nước các dịch vụ công theo quy định của pháp luật.' ),
--	('G05', N'Bộ Kế hoạch và Đầu tư',N'Bộ Kế hoạch và Đầu tư là cơ quan của Chính phủ, thực hiện chức năng quản lý nhà nước về kế hoạch, đầu tư phát triển và thống kê',N'quản lý nhà nước về kế hoạch, đầu tư phát triển và thống kê, bao gồm: Tham mưu tổng hợp về chiến lược, quy hoạch, kế hoạch phát triển kinh tế - xã hội, kế hoạch đầu tư công của quốc gia; cơ chế, chính sách quản lý kinh tế; đầu tư trong nước, đầu tư của nước ngoài vào Việt Nam và đầu tư của Việt Nam ra nước ngoài; khu kinh tế; nguồn hỗ trợ phát triển chính thức (ODA), vốn vay ưu đãi và viện trợ phi chính phủ nước ngoài; đấu thầu; phát triển doanh nghiệp, kinh tế tập thể, hợp tác xã; thống kê; quản lý nhà nước các dịch vụ công trong các ngành, lĩnh vực thuộc phạm vi quản lý nhà nước của Bộ theo quy định của pháp luật.' )


insert into legislation_configuration(legislation_id, legislation_name_xpath, legislation_so_hieu_van_ban, legislation_ngay_ban_hanh, legislation_ngay_hieu_luc, 
			legislation_ngay_ky, legislation_trich_yeu, legislation_co_quan_ban_hanh, legislation_nguoi_ky, 
			legislation_loai_van_ban, legislation_tinh_trang, legislation_link_download) values
	--Bộ công thương
	(1,
	'//*[@id="p_p_id_ELegalDocumentView_WAR_ELegalDocumentportlet_INSTANCE_ixT9f4WbWm6A_"]/div/div/section/h4/text()',
	'//*[@id="table_pna"]/tbody/tr[1]/td[2]/text()',
	'//*[@id="table_pna"]/tbody/tr[2]/td[2]/text()',
	'//*[@id="table_pna"]/tbody/tr[3]/td[2]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="table_pna"]/tbody/tr[5]/td[2]/text()',
	'//*[@id="table_pna"]/tbody/tr[6]/td[2]/text()',
	'//*[@id="table_pna"]/tbody/tr[7]/td[2]/text()',
	'//*[@id="table_pna"]/tbody/tr[8]/td[2]/text()',
	'//*[@id="table_pna"]/tbody/tr[9]/td[2]/text()',
	'//*[@id="table_pna"]/tbody/tr[10]/td[2]/div/div/a/@href'
	),
	--Bộ công an
	(2,
	'//*[@id="parentHorizontalTab"]/div/div[2]/div[1]/div[1]/a/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[2]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[6]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[7]/td[2]/text()',
	'', -- không hiển thị ngày ký
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[1]/td/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[4]/td[2]',	
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[5]/td[2]',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[3]/td[2]/text()',
	'//*[@id="parentHorizontalTab"]/div/div[2]/table/tbody/tr[8]/td[2]/text()',
	'//*[@id="A2"]/@href'
	),
	--Bộ giáo dục
	(3,
	'//*[@id="ctl00_ctl24_g_025164b8_2c99_46cb_ad7d_e00c79535b91"]/div/div[2]/div/div[2]/div[1]/a/h5/text()',
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
	)
go
use master
drop database WebDB

go
select ministry_id,article_url_xpath,article_thumbnail_xpath from ministry_category_configuration where ministry_id = 15

