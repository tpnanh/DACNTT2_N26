use master
create database WebDB

go
use WebDB

go
create table article_info(
	article_url varchar(500) PRIMARY KEY, 
	title nvarchar(100),
	date_time datetime,
	author nvarchar(50),
	content nvarchar(4000),
	tag nvarchar(100),
	imglink varchar(200),
	title_html varchar(150),
	date_time_html varchar(100),
	author_html varchar(100),
	content_html varchar(8000),
	tag_html varchar(100),
	article_html varchar(8000)
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
create table article_link(
	article_url varchar(500) PRIMARY KEY,
	ministry nvarchar(100),
	ministry_webpage varchar(100)
)

go
alter table article_configuration add constraint ai_url_ac foreign key (article_url) references article_info(article_url)
go
alter table article_link add constraint ai_url_al foreign key (article_url) references article_info(article_url)

/*go
alter table article_link
drop column ministry
add category nvarchar(50)
*/

go
use master
drop database WebDB

