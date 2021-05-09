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
	article_thumbnail_link varchar(500)
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
create table ministry_category_configuration (
	ministry_id int PRIMARY KEY,		
	article_url_xpath varchar(200),
	article_thumbnail_xpath varchar(200),
	page_rule int,
	schedule_minute int
)

go
create table ministry_articles_configuration (
	ministry_id int PRIMARY KEY,
	article_title_xpath varchar(200),
	article_description_xpath varchar(200),
	article_time_xpath varchar(200),
	article_author_xpath varchar(200),
	article_content_xpath varchar(200),
	article_tag_xpath varchar(200)
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
select * from category_type
go
select * from ministry_info

INSERT INTO category_info(ministry_id,category_name,category_type_id,category_link_root,page_param)
VALUES

(2,N'Thời sự - Bộ Công Thương',1,'http://www.moit.gov.vn/web/guest/thoi-su?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur=',587 ),
(2,N'Hoạt động - Bộ Công Thương',2,'http://www.moit.gov.vn/web/guest/hoat-dong?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur=',336 ),
(2,N'Quốc tế - Bộ Công Thương',3,'http://www.moit.gov.vn/web/guest/quoc-te?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur=',270),
(2,N'Phát triển nguồn nhân lực - Bộ Công Thương',4,'http://www.moit.gov.vn/web/guest/phat-trien-nguon-nhan-luc?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur=',61),
(2,N'Thông tin họp báo - Bộ Công Thương',5,'http://www.moit.gov.vn/web/guest/thong-tin-hop-bao?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur=',6),
(2,N'Bản tin Thị trường Nông Lâm Thủy sản - Bộ Công Thương',6,'http://www.moit.gov.vn/web/guest/ban-tin-thi-truong-nong-lam-thuy-san?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur=',13),
(2,N'70 năm ngành Công Thương - Bộ Công Thương',7,'http://www.moit.gov.vn/web/guest/70-nam-nganh-cong-thuong?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur=',2),

(1,N'Hoạt động của Bộ - Bộ Công An',8,'http://bocongan.gov.vn/tin-tuc-su-kien/hoat-dong-cua-luc-luong-cong-an/tin-hoat-dong-cua-bo-2.html?Page=',617 ),
(1,N'Hoạt động của địa phương - Bộ Công An',9,'http://bocongan.gov.vn/tin-tuc-su-kien/hoat-dong-cua-luc-luong-cong-an/hoat-dong-cua-dia-phuong-23.html?Page=',291 ),
(1,N'Chỉ đạo điều hành - Bộ Công An',10,'http://bocongan.gov.vn/tin-tuc-su-kien/chi-dao-dieu-hanh-24.html?Page=',90 ),
(1,N'Thông tin đối ngoại - Bộ Công An',11,'http://bocongan.gov.vn/tin-tuc-su-kien/thong-tin-doi-ngoai-20.html?Page=',107 ),
(1,N'Tin an ninh trật tự - Bộ Công An',12,'http://bocongan.gov.vn/tin-tuc-su-kien/tin-an-ninh-trat-tu-22.html?Page=',187 ),
(1,N'Người tốt, việc tốt - Bộ Công An',13,'http://bocongan.gov.vn/tin-tuc-su-kien/nguoi-tot-viec-tot-21.html?Page=',77 ),
(1,N'Hoạt động xã hội - Bộ Công An',14,'http://bocongan.gov.vn/tin-tuc-su-kien/hoat-dong-xa-hoi-25.html?Page=',86 ),

(3,N'Tin tức sự kiện - Bộ Nội vụ',57,'https://www.moha.gov.vn/tin-tuc-su-kien.html?page=',356), --còn nhiều trang mà khum có nút kéo đến trang cuối :<

(4,N'Thông cáo báo chí - Bộ Giáo dục và Đào tạo',15,'https://moet.gov.vn/tintuc/Pages/thong-cao-bao-chi.aspx?date=&EventID=0&Page=',2 ),
(4,N'Thông báo - Bộ Giáo dục và Đào tạo',16,'https://moet.gov.vn/tintuc/Pages/Thongbao.aspx?date=&EventID=0&Page=',2 ),
(4,N'Tin tổng hợp - Bộ Giáo dục và Đào tạo',17,'https://moet.gov.vn/tintuc/Pages/tin-tong-hop.aspx?date=&EventID=0&Page=',238 ),
(4,N'Tin video - Bộ Giáo dục và Đào tạo',18,'https://moet.gov.vn/tintuc/Pages/tin-tong-hop.aspx',1 ),
(4,N'Tin audio - Bộ Giáo dục và Đào tạo',19,'https://moet.gov.vn/tintuc/Pages/tin-audio.aspx',1 ),

(5,N'Hoạt động lãnh đạo - Bộ Giao thông vận tải',21,'https://mt.gov.vn/vn/chuyen-muc/856/hoat-dong-lanh-dao-.aspx',71 ),
(5,N'Tin hoạt động ngành GTVT - Bộ Giao thông vận tải',22,'https://mt.gov.vn/vn/chuyen-muc/855/Tin-hoat-dong-nganh.aspx',13 ),
(5,N'Tin đấu thầu - Bộ Giao thông vận tải',23,'https://mt.gov.vn/vn/chuyen-muc/877/dau-thau.aspx',88 ),
(5,N'Thông cáo báo chí - Bộ Giao thông vận tải',24,'https://mt.ghttps://mt.gov.vn/vn/chuyen-muc/856/hoat-dong-lanh-dao-.aspxnov.vn/vn/chuyen-muc/889/thong-cao-bao-chi.aspx',9 ),
(5,N'Văn bản mới ban hành - Bộ Giao thông vận tải',25,'https://mt.gov.vn/vn/chuyen-muc/858/van-ban-moi-ban-hanh.aspx',13 ),
(5,N'Công trình giao thông - Bộ Giao thông vận tải',26,'http://mt.gov.vn/vn/chuyen-muc/973/Cong-trinh-giao-thong.aspx',1 ),
(5,N'Video - Bộ Giao thông vận tải',27,'https://mt.gov.vn/vn/chuyen-muc/1184/tinvideo.aspx',6),

/*(6,N'Thông tin KT-XH - Bộ Kế hoạch và đầu tư',27,'root',587 ),
(6,N'Số liệu KT_XH - Bộ Kế hoạch và đầu tư',28,'root',587 ),
(6,N'Chỉ tiêu KT-XH - Bộ Kế hoạch và đầu tư',29,'root',587 ),*/

(7,N'Tin tổng hợp - Bộ Khoa học và Công nghệ',17,'https://www.most.gov.vn/vn/chuyen-muc/493/Tin-tong-hop.aspx?page=',106 ),
(7,N'Điểm báo KH&CN - Bộ Khoa học và Công nghệ',31,'https://www.most.gov.vn/vn/chuyen-muc/570/Diem-bao-KHCN.aspx?page=',58 ),

(8,N'Việc làm - Lao động - Bộ Lao động - Thương Binh và Xã hội',32,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=32&page=',307 ),
(8,N'Tiền lương - Lao động - Bộ Lao động - Thương Binh và Xã hội',33,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=33&page=',91),
(8,N'Bảo hiểm xã hội - Lao động - Bộ Lao động - Thương Binh và Xã hội',34,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=35&page=',117),
(8,N'Lao động ngoài nước - Lao động - Bộ Lao động - Thương Binh và Xã hội',35,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=34&page=',147),
(8,N'An toàn, vệ sinh lao động - Lao động - Bộ Lao động - Thương Binh và Xã hội',36,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=68&page=',137),
(8,N'Giáo dục nghề nghiệp - Lao động - Bộ Lao động - Thương Binh và Xã hội',37,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=69&page=',249),
(8,N'Người có công - Bộ Lao động - Thương Binh và Xã hội',38,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=25&page=',246 ),
(8,N'Bảo trợ xã hội - Xã hội - Bộ Lao động - Thương Binh và Xã hội',39,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=39&page=',635),
(8,N'Giảm nghèo - Xã hội - Bộ Lao động - Thương Binh và Xã hội',40,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=40&page=',317),
(8,N'Phòng chống tệ nạn xã hội - Xã hội - Bộ Lao động - Thương Binh và Xã hội',41,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=70&page=',240),
(8,N'Trẻ em - Xã hội - Bộ Lao động - Thương Binh và Xã hội',42,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=71&page=',150),
(8,N'Bình đẳng giới - Xã hội - Bộ Lao động - Thương Binh và Xã hội',43,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=72&page=',65),
(8,N'Thông tin cơ sở - Địa phương - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',44,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=136&page=',54),
(8,N'Chuyên đề địa phương - Địa phương - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',45,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=258&page=',10),
(8,N'Mô hình kinh nghiệm - Địa phương - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',46,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=259&page=',18),
(8,N'Kết nối thông tin - Cơ sở - Bộ Lao động - Thương Binh và Xã hội',47,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=260&page=',8),
(8,N'Kỷ niệm các ngày lễ lớn của Đất nước - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',48,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucId=11522',1),
(8,N'Công tác Đảng - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',49,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11523&page=',8),
(8,N'Công Đoàn - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',50,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11524&page=',6),
(8,N'Đoàn Thanh niên - Đảng - Đoàn thể - Bộ Lao động - Thương Binh và Xã hội',51,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11525&page=',7),
(8,N'Tin tức dịch Covid-19 - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',52,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11521&page=',13),
(8,N'ASEAN Việt Nam 2020 - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',53,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11527&page=',11),
(8,N'Thanh tra LĐXH - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',54,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=42&page=',27),
(8,N'Hoạt động chung - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',55,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=43&page=',83),
(8,N'Kinh tế - Xã hội - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',56,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=74&page=',136),
(8,N'Chăm sóc người có công và công tác xã hội - Các vấn đề khác - Bộ Lao động - Thương Binh và Xã hội',57,'http://www.molisa.gov.vn/Pages/tintuc/chuyenmuc.aspx?ChuyenMucID=11518&page=',22),


(9,N'Tin tức sự kiện - Bộ Ngoại giao',58,'https://lanhsuvietnam.gov.vn/Lists/ChuyenMuc/ChuyenMuc/ChuyenMuc.aspx?List=b6a96952%2D5329%2D4042%2D901b%2D2af247f16b68&ID=16',1 ),

(10,N'Tin tổng hợp - Bộ Nông nghiệp và phát triển nông thôn',17,'https://www.mard.gov.vn/Pages/tin-hoat-dong.aspx',344),
(10,N'Nông nghiệp - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',60,'https://www.mard.gov.vn/Pages/tin-tuc-tin-hoat-dong.aspx#',439),
(10,N'Lâm nghiệp - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',61,'https://www.mard.gov.vn/Pages/tin-tuc-tin-lam-nghiep.aspx',178),
(10,N'Thủy lợi - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',62,'https://www.mard.gov.vn/Pages/tin-tuc-tin-thuy-loi.aspx',314),
(10,N'Phòng chống thiên tai - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',63,'https://www.mard.gov.vn/Pages/phong-chong-thien-tai.aspx',106),
(10,N'Thủy sản - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',64,'https://www.mard.gov.vn/Pages/tin-tuc-tin-thuy-san.aspx',282),
(10,N'Quản lý chất lượng - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',65,'https://www.mard.gov.vn/Pages/tin-tuc-tin-quan-ly-chat-luong-va-ve-sinh-attp.aspx',34),
(10,N'Chế biến và thị trường - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',66,'https://www.mard.gov.vn/Pages/tin-tuc-tin-che-bien.aspx',398),
(10,N'Phát triển nông thôn - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',67,'https://www.mard.gov.vn/Pages/tin-tuc-tin-phat-trien-nong-thon.aspx',18),
(10,N'Khuyến nông - Tin chuyên ngành - Bộ Nông nghiệp và phát triển nông thôn',68,'https://www.mard.gov.vn/Pages/tin-tuc-tin-khuyen-nong.aspx',405),
(10,N'Tin địa phương - Bộ Nông nghiệp và phát triển nông thôn',20,'https://www.mard.gov.vn/Pages/danh-sach-tin-dia-phuong.aspx',170),
(10,N'Tin video - Bộ Nông nghiệp và phát triển nông thôn',18,'https://www.mard.gov.vn/Pages/danh-sach-tin-video.aspx',50),

(11,N'Tin tức sự kiện - Bộ Quốc phòng',58,'http://www.mod.gov.vn/wps/portal/!ut/p/b1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLdHP2CLJwMHQ38zT0sDDyNnZ1NjcOMDQ2CzIEKIoEKDHAARwPi9Du7O3qYmPsYGFj4uJsaeDp6hAZZBhobGzgaE9Ifrh8FVoLPBLACPE7088jPTdUvyA2NMMgyUQQAfwOf3g!!/dl4/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_FANR8B1A081F00I32T4LDI2064/ren/p=WCM_PI=1/p=ns_Z7_FANR8B1A081F00I32T4LDI2064_WCM_PreviousPageSize.4e92abb3-6db2-476b-85b7-8c31f62282a0=10/p=ns_Z7_FANR8B1A081F00I32T4LDI2064_WCM_Page.4e92abb3-6db2-476b-85b7-8c31f62282a0=100/p=CTX=QCPmodQCPsa-mod-siteQCPsa-ttsk/-/',100),

(12,N'Tin tức sự kiện - Bộ Tài chính',58,'https://www.mof.gov.vn/webcenter/portal/tttc/r/o/ttsk?_afrLoop=2000043207816979#%40%3F_afrLoop%3D2000043207816979%26centerWidth%3D100%2525%26leftWidth%3D0%2525%26rightWidth%3D0%2525%26showFooter%3Dfalse%26showHeader%3Dfalse%26_adf.ctrl-state%3D1akhre069w_206',465 ),
(12,N'Thông cáo báo chí - Bộ Tài chính',24,'https://www.mof.gov.vn/webcenter/portal/tttc/r/o/thongcaobaochi?_afrLoop=2000261991867489#%40%3F_afrLoop%3D2000261991867489%26centerWidth%3D100%2525%26leftWidth%3D0%2525%26rightWidth%3D0%2525%26showFooter%3Dfalse%26showHeader%3Dfalse%26_adf.ctrl-state%3D1akhre069w_272',26 ),

--(13,N'Hội nhập quốc tế - Bộ Tài nguyên và Môi trường',39,'https://monre.gov.vn/Pages/ChuyenMuc.aspx?cm=H%E1%BB%99i%20nh%E1%BA%ADp%20qu%E1%BB%91c%20t%E1%BA%BF',42 ),
(13,N'Tham vấn chính sách TN&MT - Bộ Tài nguyên và Môi trường',70,'https://monre.gov.vn/Pages/ChuyenMuc.aspx?cm=Tham%20v%E1%BA%A5n%20ch%C3%ADnh%20s%C3%A1ch%20TN%EF%BC%86MT',1000 ),


(14,N'Bưu chính - Bộ Thông tin và Truyền thông',71,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/1747//Buu-chinh.html',4 ),
(14,N'Viễn thông - Bộ Thông tin và Truyền thông',72,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1748//Vien-thong.html',6 ),
(14,N'CNTT - Bộ Thông tin và Truyền thông',73,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1749//Ung-dung-CNTT.html',8 ),
(14,N'ATTT - Bộ Thông tin và Truyền thông',74,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1694/197/An-toan-thong-tin.html',197 ),
(14,N'Công nghiệp ICT - Bộ Thông tin và Truyền thông',75,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1751/3/Cong-nghiep-ICT.html',3 ),
(14,N'Báo chí truyền thông - Bộ Thông tin và Truyền thông',76,'https://www.mic.gov.vn/mic_2020/Pages/ChuyenMuc/PhanTrang/1752/18/Bao-chi-truyen-thong.html',18 ),

(15,N'Văn bản chính sách mới - Bộ Tư pháp',77,'https://moj.gov.vn/qt/tintuc/Pages/van-ban-chinh-sach-moi.aspx?Date=&Page=',420 ),
(15,N'Chỉ đạo điều hành - Bộ Tư pháp',78,'https://moj.gov.vn/qt/tintuc/Pages/chi-dao-dieu-hanh.aspx?Date=&Page=',355 ),

(16,N'Bộ với các đơn vị - Bộ Văn hóa - Thể thao và Du lịch',81,'https://bvhttdl.gov.vn/hoat-dong-ky-niem-ngay-quoc-te-bao-tang-18-5-2021-20210507084003259.htm',1 ),
(16,N'Bộ với các địa phương - Bộ Văn hóa - Thể thao và Du lịch',82,'https://bvhttdl.gov.vn/tin-tuc-va-su-kien/bo-voi-cac-dia-phuong/trang-1150.htm',1150 ),
(16,N'Giao lưu - Hợp tác quốc tế - Bộ Văn hóa - Thể thao và Du lịch',83,'https://bvhttdl.gov.vn/g20-ung-ho-sang-kien-di-chuyen-quoc-te-an-toan-de-khoi-dong-du-lich-20210506162341549.htm',1 ),
(16,N'Điểm báo - Bộ Văn hóa - Thể thao và Du lịch',84,'https://bvhttdl.gov.vn/diem-bao-hoat-dong-nganh-van-hoa-the-thao-va-du-lich-ngay-7-5-2021-20210507122302558.htm',1 ),
(16,N'Thông tin - trao đổi - Bộ Văn hóa - Thể thao và Du lịch',85,'https://bvhttdl.gov.vn/van-dung-tu-tuong-ho-chi-minh-vao-cong-tac-kiem-tra-cua-dang-hien-nay-20210505073502755.htm',1 ),

(17,N'Tin tổng hợp - Bộ Xây dựng',17,'https://moc.gov.vn/vn/chuyen-muc/1173/tin-hoat-dong.aspx?page=',760 ),
(17,N'Tin hoạt động - Bộ Xây dựng',86,'https://moc.gov.vn/vn/chuyen-muc/1184/tin-tong-hop.aspx?page=',2421 ),
(17,N'Tin cải cách hành chính - Bộ Xây dựng',87,'https://moc.gov.vn/vn/chuyen-muc/1166/tin-cai-cach-hanh-chinh.aspx?page=',71 ),
(17,N'Giới thiệu văn bản mới - Bộ Xây dựng',88,'https://moc.gov.vn/vn/chuyen-muc/1196/Gioi-thieu-van-ban-moi.aspx?page=',64 ),

(18,N'Tin hoạt động - Bộ y tế',86,'https://moh.gov.vn/hoat-dong-cua-lanh-dao-bo?p_p_id=101_INSTANCE_TW6LTp1ZtwaN&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=2&_101_INSTANCE_TW6LTp1ZtwaN_delta=20&_101_INSTANCE_TW6LTp1ZtwaN_keywords=&_101_INSTANCE_TW6LTp1ZtwaN_advancedSearch=false&_101_INSTANCE_TW6LTp1ZtwaN_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_TW6LTp1ZtwaN_cur=',29),
(18,N'Tin tổng hợp - Bộ y tế',17,'https://moh.gov.vn/tin-tong-hop?p_p_id=101_INSTANCE_k206Q9qkZOqn&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=1&_101_INSTANCE_k206Q9qkZOqn_delta=20&_101_INSTANCE_k206Q9qkZOqn_keywords=&_101_INSTANCE_k206Q9qkZOqn_advancedSearch=false&_101_INSTANCE_k206Q9qkZOqn_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_k206Q9qkZOqn_cur=',29),
(18,N'Tin địa phương - Bộ y tế',20,'https://moh.gov.vn/hoat-dong-cua-dia-phuong?p_p_id=101_INSTANCE_gHbla8vOQDuS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=2&_101_INSTANCE_gHbla8vOQDuS_delta=20&_101_INSTANCE_gHbla8vOQDuS_keywords=&_101_INSTANCE_gHbla8vOQDuS_advancedSearch=false&_101_INSTANCE_gHbla8vOQDuS_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_gHbla8vOQDuS_cur=',29),
(18,N'Tin liên quan - Bộ y tế',89,'https://moh.gov.vn/tin-lien-quan?p_p_id=101_INSTANCE_vjYyM7O9aWnX&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=row-0-column-2&p_p_col_count=1&_101_INSTANCE_vjYyM7O9aWnX_delta=20&_101_INSTANCE_vjYyM7O9aWnX_keywords=&_101_INSTANCE_vjYyM7O9aWnX_advancedSearch=false&_101_INSTANCE_vjYyM7O9aWnX_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_vjYyM7O9aWnX_cur=',29),

(19,N'Tin nổi bật - Chính phủ',90,'http://chinhphu.vn/portal/page/portal/chinhphu/trangchu/tinnoibat',34),

(20,N'Hoạt động của Bộ trưởng, Chủ nhiệm - Ủy ban Dân tộc',91,'http://cema.gov.vn/tin-tuc/tin-hoat-dong/hoat-dong-cua-bo-truong.htm?p=',3 ),
(20,N'Hoạt động của Ủy ban Dân tộc - Ủy ban Dân tộc',92,'http://cema.gov.vn/tin-tuc/tin-hoat-dong/hoat-dong-cua-uy-ban.htm?p=',131 ),
(20,N'Ủy ban Dân tộc với Bộ ngành - Ủy ban Dân tộc',93,'http://cema.gov.vn/uy-ban-dan-toc-voi-bo-nganh.htm?p=',23 ),
(20,N'Ủy ban Dân tộc với địa phương - Ủy ban Dân tộc',94,'http://cema.gov.vn/uy-ban-dan-toc-voi-dia-phuong.htm?p=',60 ),
(20,N'Hoạt động của các Ban Dân tộc - Ủy ban Dân tộc',95,'http://cema.gov.vn/tin-tuc/tin-hoat-dong/hoat-dong-cua-cac-ban-dan-toc.htm?p=',19 ),
(20,N'Chủ trương - Chính sách  - Ủy ban Dân tộc',96,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/chu-truong-chinh-sach.htm?p=',36 ),
(20,N'Thời sự - Chính trị - Ủy ban Dân tộc',97,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/thoi-su-chinh-tri.htm?p=',55 ),
(20,N'Kinh tế - Xã hội - Ủy ban Dân tộc',98,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/kinh-te-xa-hoi.htm?p=',39 ),
(20,N'Y tế - Giáo dục - Ủy ban Dân tộc',99,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/y-te-giao-duc.htm?p=',30 ),
(20,N'Văn hóa - Văn nghệ - Thể thao - Ủy ban Dân tộc',100,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/van-hoa-van-nghe-the-thao.htm?p=',50 ),
(20,N'Khoa học - Công nghệ - Môi trường - Ủy ban Dân tộc',101,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/khoa-hoc-cong-nghe-moi-truong.htm?p=',14 ),
(20,N'Pháp luật - Ủy ban Dân tộc',102,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/phap-luat.htm?p=',18 ),
(20,N'Quốc tế - Ủy ban Dân tộc',2,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/quoc-te.htm?p=',21 ),
(20,N'Nghiên cứu trao đổi - Ủy ban Dân tộc',79,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/nghien-cuu-trao-doi.htm?p=',7 ),
(20,N'Gương điển hình tiên tiến - Ủy ban Dân tộc',103,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/guong-dien-hinh-tien-tien.htm?p=',12 ),
(20,N'Thông tin thị trường giá cả - Ủy ban Dân tộc',104,'http://cema.gov.vn/tin-tuc/tin-tuc-su-kien/thong-tin-thi-truong-gia-ca.htm?p=',41 ),

(23,N'Tin tổng hợp - Bảo hiểm Xã hội Việt Nam',17,'https://baohiemxahoi.gov.vn/tintuc/pages/default.aspx',1 ),
(23,N'Tin audio - Bảo hiểm Xã hội Việt Nam',19,'https://baohiemxahoi.gov.vn/tintuc/audio/pages/default.aspx',1 ),

(24,N'Tin tức hoạt động của Viện hàn lâm KHCNVN - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',105,'https://vast.gov.vn/web/guest/tin-tuc-hoat-ong-cua-vien-han-lam-khcnvn?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_LuTteT5ivhkM_cur=',148 ),
(24,N'Tin khoa học - Công nghệ trong nước - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',106,'https://vast.gov.vn/web/guest/tin-khoa-hoc-cong-nghe-trong-nuoc1?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_R3nBx6kjtXRA_cur=',86 ),
(24,N'Nghiên cứu cơ bản - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',107,'https://vast.gov.vn/web/guest/nghien-cuu-co-ban?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_1bQ0InSb33t3_cur=',7 ),
(24,N'Nghiên cứu và Phát triển công nghệ - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',108,'https://vast.gov.vn/web/guest/nghien-cuu-va-phat-trien-cong-nghe?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_NsZtOJyxiwdu_cur=',5 ),
(24,N'Điều tra cơ bản - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',109,'https://vast.gov.vn/web/guest/-ieu-tra-co-ban?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_AwTPNfxls5lW_cur=',3 ),
(24,N'Tin Khoa học - Công nghệ quốc tế - Viện Hàn lâm Khoa học và Công nghệ Việt Nam',110,'https://vast.gov.vn/web/guest/tin-khoa-hoc-cong-nghe-quoc-te1?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_XcAfRPkcCv96_cur=',22 ),

(25,N'Tin hợp tác quốc tế - Viện Hàn lâm Khoa học Xã hội Việt Nam',112,'https://vass.gov.vn/hop-tac-quoc-te-1.0.16',16),
(25,N'Tin tức đào tạo - Viện Hàn lâm Khoa học Xã hội Việt Nam',113,'https://vass.gov.vn/noidung/daotaosaudaihoc/Pages/tin-tuc-dao-tao.aspx?Date=&Page=',16),
(25,N'Tin Hành chính - Tổ chức - Viện Hàn lâm Khoa học Xã hội Việt Nam',114,'https://vass.gov.vn/tin-hanh-chinh-to-chuc-1.0.46',46),

(26,N'Tin tức sự kiện - Ủy ban quản lý vốn nhà nước tại doanh nghiệp',58,'http://cmsc.gov.vn/tin-tuc-su-kien?p_p_id=dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=_118_INSTANCE_EWtJ5M5YE6wZ__column-1&p_p_col_count=1&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_delta=25&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_keywords=&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_advancedSearch=false&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_andOperator=true&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_resetCur=false&_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_cur=',51)

go
select * from category_info;

go
insert into ministry_category_configuration(ministry_id,article_url_xpath,article_thumbnail_xpath,schedule_minute) values
	--phân loại tin tức bộ công thương
	(1,
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[2]/a/@href',	
	'//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div/article/div[1]/a/img/@src',12),
	--phân loại tin tức bộ công an
	(2,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div/div/div/a/img/@src',12),
	--thông cáo báo chí - tin tổng hợp bộ giáo dục
	(3,
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_23a2051e_3a08_46a4_9f3f_d0ee1b5fb62b"]/div/div/div/ul/li/a/img/@src',12),
	--thông báo bộ giáo dục
	(4,
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div/div/ul/li/div/h2/a/@href',	
	'//*[@id="ctl00_ctl24_g_6da89d83_0a02_4a66_8493_6a1e08bf2cba"]/div/div[2]/div/ul/li/a/img/@src',12),
	--tin video bộ giáo dục
	(6,
	'//*[@id="ctl00_ctl24_g_92a2c5f4_d49d_478b_9f6f_b3920bf66eb9"]/div/div/div/div/ul/li/div/div/div/p/a/@href',	
	'//*[@id="ctl00_ctl24_g_92a2c5f4_d49d_478b_9f6f_b3920bf66eb9"]/div/div/div/div/ul/li/div/div/div/a/img/@src',12),
	--tin audio bộ giáo dục
	(7,
	'//*[@id="ctl00_ctl24_g_fcf11fda_52ab_4c10_b110_b18f8d5a6e0a"]/div/div/div/div/ul/li/div/div/div/p/a/@href',	
	'//*[@id="ctl00_ctl24_g_fcf11fda_52ab_4c10_b110_b18f8d5a6e0a"]/div/div/div/div/ul/li/div/div/div/a/img/@src',12),
	--phân loại bộ gtvt
	(8,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/div/a/img/@src',12),
	--công trình giao thông bộ gtvt
	(9,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_rptNhomTinTuc_ctl00_pnlShowNhomTin"]/div/div/ul/li/a/@href',	
	' ',12),--không có ảnh
	--phân loại bộ khoa học và công nghệ
	(10,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/div/a/img/@src',12),
	--phân loại bộ lao động thương binh và xã hội
	(11,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',12),
	--người có công bộ lao động thương binh và xã hội
	(12,
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/h2/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/a/img/@src',12),
	--tin tức-sự kiện bộ nội vụ
	(13,
	'//*[@id="list_news"]/div[1]/div/div/ul/li/p/a/@href',	
	'//*[@id="list_news"]/div/div/div/ul/li/a/img/@src',12),
	--tin tức-sự kiện bộ quốc phòng
	(14,
	'//*[@id="listArticle"]/div/div/h1/a/@href',	
	'//*[@id="listArticle"]/div/div[1]/a/img/@src',12),
	--tin tức-sự kiện bộ tài chính
	(15,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',12),
	--tin địa phương bộ ''
	(16,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',12),
	--tin video bộ ''
	(17,
	'//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_pnListNews"]/div/h3/a/@href',	
	'//*[@id="ctl00_ctl50_g_6a4a1e4e_6f66_405a_92c1_d219946bfcba"]/div/div/div/div/a/img/@src',12),
	--phân loại tin tức bộ thông tin vè truyền thông
	(18,
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/h3/a/@href',	
	'//*[@id="ctl00_ctl46_g_915af12b_590b_4148_9fd5_0e542a5d896f"]/div/div/a/img/@src',12),
	--chỉ đạo điều hành bộ tư pháp
	(19,
	'//*[@id="ctl00_ctl35_g_7165e992_2505_4b19_ad5f_44b0d061a060"]/div/div/div/div/div/p/a/@href',	
	'//*[@id="ctl00_ctl35_g_7165e992_2505_4b19_ad5f_44b0d061a060"]/div/div/div/div/div/a/img/@src',12),
	--văn bản chính sách mới bộ tư pháp
	(20,
	'//*[@id="ctl00_ctl35_g_ab713570_0c3c_4d90_9ca3_2ddd2b5fc497"]/div/div/div/div/div/p/a/@href',	
	'',12),
	--nghiên cứu trao đổi bộ tư pháp
	(21,
	'//*[@id="ctl00_ctl35_g_6eb44992_0f6f_427c_9748_86a2197f142d"]/div/div/div/div/div/p/a/@href',	
	'//*[@id="ctl00_ctl35_g_6eb44992_0f6f_427c_9748_86a2197f142d"]/div/div/div/div/div/a/img/@src',12),
	--thông tin khác bộ tư pháp
	(22,
	'//*[@id="ctl00_ctl35_g_e985fffc_da66_42b2_bf39_3a39075bc039"]/div/div/div/div/div/p/a/@href',	
	'//*[@id="ctl00_ctl35_g_e985fffc_da66_42b2_bf39_3a39075bc039"]/div/div/div/div/div/a/img/@src',12),
	--phân loại bộ vhttdl
	(23,
	'//*[@id="mainHtml"]/body/div/div/div/div/div/div/div/a/@href',	
	'//*[@id="mainHtml"]/body/div/div/div/div/div/div/div/a/img/@src',12),
	--phân loại bộ xây dựng
	(24,
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/@href',	
	'//*[@id="ctl00_SPWebPartManager1_g_de91b401_0988_4be6_a806_fd5b21858b5f_ctl00_pnListNews"]/div/ul/li/div/a/img/@src',12),
	--hoạt động lãnh đạo bộ y tế
	(25,
	'//*[@id="p_p_id_101_INSTANCE_TW6LTp1ZtwaN_"]/div/div/div/div/div/div/div/h3/a/@href',	
	'//*[@id="p_p_id_101_INSTANCE_TW6LTp1ZtwaN_"]/div/div/div/div/div/div/div/a/img/@src',12),
	--tin tổng hợp bộ y tế
	(26,
	'//*[@id="p_p_id_101_INSTANCE_k206Q9qkZOqn_"]/div/div/div/div/div/div/div/h3/a/@href',	
	'//*[@id="p_p_id_101_INSTANCE_k206Q9qkZOqn_"]/div/div/div/div/div/div/div/a/img/@src',12),
	--thông tin chỉ đạo điều hành bộ y tế
	(27,
	'//*[@id="p_p_id_101_INSTANCE_DOHhlnDN87WZ_"]/div/div/div/div/div/div/div/h3/a/@href',	
	'//*[@id="p_p_id_101_INSTANCE_DOHhlnDN87WZ_"]/div/div/div/div/div/div/div/a/img/@src',12),
	--hoạt động của địa phương bộ y tế
	(28,
	'//*[@id="p_p_id_101_INSTANCE_gHbla8vOQDuS_"]/div/div/div/div/div/div/div/h3/a/@href',	
	'//*[@id="p_p_id_101_INSTANCE_gHbla8vOQDuS_"]/div/div/div/div/div/div/div/a/img/@src',12),
	--điểm tin y tế bộ y tế
	(29,
	'//*[@id="p_p_id_101_INSTANCE_sqTagDPp4aRX_"]/div/div/div/div/div/div/div/h3/a/@href',	
	'//*[@id="p_p_id_101_INSTANCE_sqTagDPp4aRX_"]/div/div/div/div/div/div/div/a/img/@src',12),
	--chính phủ 
	(30,
	'//*[@id="tinkhac"]/table/tbody/tr/td/a/@href',	
	'//*[@id="tinkhac"]/table/tbody/tr/td/img/@src',12),
	--viện hàn lâm khoa học công nghệ
	(31,
	'//*[@id="ContArticleDiv"]/div/div/a/@href',	
	'//*[@id="ContArticleDiv"]/div/a/img/@src',12),
	--tin hợp tác quốc tế viện hàn lâm khoa học xã hội
	(32,
	'//*[@id="ctl00_m_g_e0136335_967d_4b76_983c_c60f79107a7f"]/div/div/div/div/p/a/@href',	
	'//*[@id="ctl00_m_g_e0136335_967d_4b76_983c_c60f79107a7f"]/div/div[2]/div/div/a/img',12),
	--tin đào tạo viện hàn lâm khoa học xã hội
	(33,
	'//*[@id="ctl00_m_g_43975694_b6c8_49c4_b36e_4eedbb2bce01"]/div/div/div/div/p/a/@href',	
	'//*[@id="ctl00_m_g_43975694_b6c8_49c4_b36e_4eedbb2bce01"]/div/div[2]/div/div/a/img',12),
	--tin hành chính tổ chức viện hàn lâm khoa học xã hội
	(34,
	'//*[@id="ctl00_m_g_7145028f_cb69_4dea_9572_d2a1e41740e8"]/div/div/div/div/p/a/@href',	
	'//*[@id="ctl00_m_g_7145028f_cb69_4dea_9572_d2a1e41740e8"]/div/div[2]/div/div/a/img',12),
	--phân loại ủy ban quản lý vốn nhà nước
	(35,
	'//*[@id="p_p_id_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_"]/div/div/div/h2/a/@href',	
	'//*[@id="p_p_id_dsnews_WAR_vnpteportalnewsportlet_INSTANCE_673PJRYyOK4a_"]/div/div/div/a/img/@src',12)

go
select * from ministry_category_configuration

go
select* from category_info

go 
insert into ministry_articles_configuration(ministry_id,article_title_xpath,article_description_xpath,article_time_xpath,
											article_author_xpath,article_content_xpath) values
	(1,
	'//div[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/h1/text()',
	'//p[@id="change_font_size"]/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/p[1]/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/div[2]/div[2]/text()',
	'//*[@id="contentnews"]/p/text()'
	),
	(2,
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/h1/text()',
	'//*[@id="change_font_size"]/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/p[1]/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/div[2]/div[2]/text()',
	'//*[@id="contentnews"]/p/text()'
	),
	(3,
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/h1/text()',
	'//*[@id="change_font_size"]/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/p[1]/text()',
	'',
	'//*[@id="contentnews"]/text()'
	),
	(4,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/h1/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[1]/div[1]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[2]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[5]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[4]/div/text()'
	),
	(5,
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/h1/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[2]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[1]/div[1]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[1]/div[1]/text()',
	'//*[@id="contentnews"]/p/text()'
	),
	(6,
	'//div[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/h1/text()',
	'//p[@id="change_font_size"]/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/p[1]/text()',
	'//*[@id="p_p_id_CmsViewChiTietBaiViet_WAR_CmsViewEcoITportlet_"]/div/div/div/section[1]/article/div[2]/div[2]/text()',
	'//*[@id="ctl00_ctl30_g_a823d20f_9452_45d0_bad1_428f6d2d36fe"]/div/div[2]/div[4]/div/text()'
	)

go
select * from ministry_articles_configuration

go
use master
drop database WebDB

