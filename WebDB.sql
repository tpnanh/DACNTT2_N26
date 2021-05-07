use master
create database WebDB

go
use WebDB

go
create table article_info(
	article_id varchar(20) PRIMARY KEY,
	category_id varchar(20),
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
	article_img_id varchar(20),
	article_id varchar(20) unique, 
	article_img_link varchar(500)
)

go
create table legislation_info(
	legislation_id varchar (20) PRIMARY KEY,
	ministry_id varchar(20),
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
	legislation_id varchar(20) PRIMARY KEY,
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
	ministry_id varchar(20) PRIMARY KEY,
	ministry_name nvarchar(100)
)

go
create table ministry_articles_configuration (
	ministry_id varchar(20) PRIMARY KEY,
	article_title_xpath varchar(200),
	article_description_xpath varchar(200),
	article_time_xpath varchar(200),
	article_author_xpath varchar(200),
	article_content_xpath varchar(200),
	article_tag_xpath varchar(200),
	article_thumbnail_xpath varchar(200)
)

go
create table ministry_category_configuration (
	ministry_id varchar(20) PRIMARY KEY,		
	article_url_xpath varchar(200),
	article_title_xpath varchar(200),
	article_time_xpath varchar(200),
	article_description_xpath varchar(200),
	article_thumbnail_xpath varchar(200),
	page_rule int,
	schedule_minute time
)

go
create table category_info(
	category_id varchar(20) PRIMARY KEY,
	ministry_id varchar(20),
	category_name nvarchar (200),
	category_type_id varchar (20),
	category_link_root varchar(1000),
	page_param int
	
)

go
create table category_type(
	category_type_id varchar (20) PRIMARY KEY,
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
insert into article_link(article_url, mabo, link_root,loai_link,ten_link,page_param,page_rule,schedule_minute) values
	('http://www.moit.gov.vn/web/guest/thoi-su','G02','/web/guest/thoi-su','internal','bo cong thuong muc thoi su',2,1, getdate()),
	('http://bocongan.gov.vn/tin-tuc-su-kien/chi-dao-dieu-hanh-24.html','G01','/tin-tuc-su-kien/chi-dao-dieu-hanh-24.html','internal','bo con an muc chi dao dieu hanh',2,1, getdate()),
	('https://moet.gov.vn/tintuc/Pages/thong-cao-bao-chi.aspx','G03','/tintuc/Pages/thong-cao-bao-chi.aspx','internal','bo giao duc va dao tao muc thong cao bao chi',2,1, getdate()),
	('https://www.mt.gov.vn/vn/Pages/Tintuc.aspx','G04','/vn/Pages/Tintuc.aspx','internal','bo giao duc va dao tao muc tin tuc',2,1, getdate()),
	('http://www.mpi.gov.vn/Pages/ttptktxh.aspx','G05','/Pages/ttptktxh.asp','internal','bo ke hoach va dau tu muc thong tin phat trien kinh te xa hoi',2,1, getdate())

go
select * from article_link
go
INSERT INTO bonganh
    (mabo, tenbo, gioithieuchung, chucnang)
VALUES
    ('G01', N'Bộ Công an',N'Công an nhân dân là lực lượng vũ trang nhân dân làm nòng cốt trong thực hiện nhiệm vụ bảo vệ an ninh quốc gia, bảo đảm trật tự, an toàn xã hội, đấu tranh phòng, chống tội phạm và vi phạm pháp luật về an ninh quốc gia, trật tự, an toàn xã hội.',N'Công an nhân dân có chức năng tham mưu với Đảng, Nhà nước về bảo vệ an ninh quốc gia, bảo đảm trật tự, an toàn xã hội, đấu tranh phòng, chống tội phạm và vi phạm pháp luật về an ninh quốc gia, trật tự, an toàn xã hội; thực hiện quản lý nhà nước về bảo vệ an ninh quốc gia, bảo đảm trật tự, an toàn xã hội, đấu tranh phòng, chống tội phạm và vi phạm pháp luật về an ninh quốc gia, trật tự, an toàn xã hội; đấu tranh phòng, chống âm mưu, hoạt động của các thế lực thù địch, các loại tội phạm và vi phạm pháp luật về an ninh quốc gia, trật tự, an toàn xã hội.' ),
	('G02', N'Bộ Công Thương',N'Bộ Công Thương là cơ quan của Chính phủ, thực hiện chức năng quản lý nhà nước về công nghiệp và thương mại',N'Điện, than, dầu khí, năng lượng mới, năng lượng tái tạo, hóa chất, vật liệu nổ công nghiệp, công nghiệp cơ khí, luyện kim, công nghiệp khai thác mỏ và chế biến khoáng sản, công nghiệp tiêu dùng, công nghiệp thực phẩm, công nghiệp hỗ trợ, công nghiệp môi trường, công nghiệp công nghệ cao; cụm công nghiệp, tiểu thủ công nghiệp, khuyến công; thương mại trong nước; xuất nhập khẩu, thương mại biên giới; phát triển thị trường ngoài nước; quản lý thị trường; xúc tiến thương mại; thương mại điện tử; dịch vụ thương mại; hội nhập kinh tế quốc tế; cạnh tranh, bảo vệ quyền lợi người tiêu dùng, phòng vệ thương mại; các dịch vụ công trong các ngành, lĩnh vực thuộc phạm vi quản lý nhà nước của bộ.' ),
	('G03', N'Bộ Giáo dục và Đào tạo',N'Bộ Giáo dục và Đào tạo là cơ quan của Chính phủ, thực hiện chức năng quản lý nhà nước đối với giáo dục mầm non, giáo dục phổ thông, trung cấp sư phạm, cao đẳng sư phạm, giáo dục đại học và các cơ sở giáo dục khác',N'quản lý nhà nước đối với giáo dục mầm non, giáo dục phổ thông, trung cấp sư phạm, cao đẳng sư phạm, giáo dục đại học và các cơ sở giáo dục khác về: Mục tiêu, chương trình, nội dung giáo dục; quy chế thi, tuyển sinh và văn bằng, chứng chỉ; phát triển đội ngũ nhà giáo và cán bộ quản lý giáo dục; cơ sở vật chất và thiết bị trường học; bảo đảm chất lượng, kiểm định chất lượng giáo dục; quản lý nhà nước các dịch vụ sự nghiệp công thuộc phạm vi quản lý nhà nước của bộ.' ),
	('G04', N'Bộ Giao thông vận tải',N'Bộ Giao thông vận tải là cơ quan của Chính phủ, thực hiện chức năng quản lý nhà nước về giao thông vận tải đường bộ',N'quản lý nhà nước về giao thông vận tải đường bộ, đường sắt, đường thủy nội địa, hàng hải, hàng không trong phạm vi cả nước; quản lý nhà nước các dịch vụ công theo quy định của pháp luật.' ),
	('G05', N'Bộ Kế hoạch và Đầu tư',N'Bộ Kế hoạch và Đầu tư là cơ quan của Chính phủ, thực hiện chức năng quản lý nhà nước về kế hoạch, đầu tư phát triển và thống kê',N'quản lý nhà nước về kế hoạch, đầu tư phát triển và thống kê, bao gồm: Tham mưu tổng hợp về chiến lược, quy hoạch, kế hoạch phát triển kinh tế - xã hội, kế hoạch đầu tư công của quốc gia; cơ chế, chính sách quản lý kinh tế; đầu tư trong nước, đầu tư của nước ngoài vào Việt Nam và đầu tư của Việt Nam ra nước ngoài; khu kinh tế; nguồn hỗ trợ phát triển chính thức (ODA), vốn vay ưu đãi và viện trợ phi chính phủ nước ngoài; đấu thầu; phát triển doanh nghiệp, kinh tế tập thể, hợp tác xã; thống kê; quản lý nhà nước các dịch vụ công trong các ngành, lĩnh vực thuộc phạm vi quản lý nhà nước của Bộ theo quy định của pháp luật.' )
go
select * from bonganh 

go
use master
drop database WebDB

