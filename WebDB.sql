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
	category_type_name nvarchar(50)
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
	
	(N'Thông cáo báo chí'),
	(N'Thông báo'),
	(N'Tin tổng hợp'),
	(N'Tin video'),
	(N'Tin audio'),
	
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
	
	(N'Tin tổng hợp'),
	(N'Điểm báo KH&CN'),
	
	(N'Lao động'),
	(N'Người có công'),
	(N'Xã hội'),
	(N'Địa phương - Cơ sở'),
	(N'Đảng - Đoàn thể'),
	(N'Các vấn đề khác'),

	(N'Tin tức sự kiện'),

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

	(N'Bản tin chính phủ tuần qua'),

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
	(N'Quốc tế'),
	(N'Gương điển hình tiên tiến'),
	(N'Thông tin thị trường giá cả'),

	(N'Tin tức hoạt động của Viện hàn lâm KHCNVN'),
	(N'Tin khoa học - Công nghệ trong nước'),
	(N'Nghiên cứu cơ bản'),
	(N'Nghiên cứu và Phát triển công nghệ'),
	(N'Điều tra cơ bản'),
	(N'Tin Khoa học - Công nghệ quốc tế'),

	(N'Tin tức')

go
select * from category_type

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
	--tin tức-sự kiện	bộ tài chính
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

