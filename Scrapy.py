import pyodbc
import scrapy
from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

class MySpider(scrapy.Spider):
    
    name = "crawl_news" 
        
    
    # conn = pyodbc.connect('Driver={SQL Server};'
    #                   'Server=ANISE-TR\SQLEXPRESS;'
    #                   'Database=WebDB;'
    #                   'Trusted_Connection=yes;')

    # cursor = conn.cursor()
    # cursor.execute('SELECT * FROM NEWSINFO')

    start_urls = ['http://www.moit.gov.vn/web/guest/thoi-su']

    def parse(self, response): 
        url = '//div[@id="p_p_id_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_"]/div/div/div/section/div'
        count = len(response.xpath(url))
        print("Content: " + str(count))
        for i in range(1, count):
            print(response.xpath(url+'['+str(i)+']/article/div[2]/p[1]/text()').extract())
                  # .extract()[i].strip())

c = CrawlerProcess(get_project_settings())
c.crawl(MySpider)
c.start()