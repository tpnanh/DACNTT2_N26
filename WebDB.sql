use master
create database WebDB

go
use WebDB

go
create table article_info(
	article_url varchar(500) PRIMARY KEY, 
	title nvarchar(200),
	date_time date,
	author nvarchar(50),
	content text,
	tag nvarchar(100),
	imglink varchar(200),
	summary nvarchar(200),
	title_html varchar(150),
	date_time_html varchar(100),
	author_html varchar(100),
	content_html varchar(100),
	tag_html varchar(100),
	article_html varchar(1000),
	summary_html varchar(100)
)

go
create table article_configuration (
	article_url varchar(500) PRIMARY KEY,
	title_xpath varchar(40),
	date_time_xpath varchar(40),
	author_xpath varchar(40),
	content_xpath varchar(40),
	tag_xpath varchar(40),
	img_xpath varchar(40)
)


go
create table vanbanphapluat(
	article_url varchar(500) PRIMARY KEY,
	mabo varchar(20),
	sohieuvanban varchar(20),
	ngaybanhanh date,
	ngayhieuluc date,
	ngayky datetime,
	trichyeu nvarchar(100),
	coquanbanhanh nvarchar(100),
	nguoiky nvarchar(50),
	theloai nvarchar(50),
	tinhtrang nvarchar(50),
	download_link varchar(100)
)

go
create table bonganh(
	mabo varchar(20) PRIMARY KEY,
	tenbo nvarchar(50),
	gioithieuchung nvarchar(500),
	chucnang nvarchar(1000)
)
go
create table article_link(
	article_url varchar(500) PRIMARY KEY,
	mabo varchar(20),
	link_root varchar(100),
	loai_link varchar(20),
	ten_link varchar(100),
	page_param int,
	page_rule int,
	schedule_minute date
)

go
alter table article_configuration add constraint al_url_ac foreign key (article_url) references article_link(article_url)
go
alter table article_info add constraint al_url_ai foreign key (article_url) references article_link(article_url)
go
alter table vanbanphapluat add constraint al_url_vbpl foreign key (article_url) references article_link(article_url)
go
alter table vanbanphapluat add constraint bn_url_vbpl foreign key (mabo) references bonganh(mabo)


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

