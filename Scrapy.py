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

    # start_urls = ['http://www.moit.gov.vn/web/guest/thoi-su']
    start_urls = ['http://www.moit.gov.vn/web/guest/tin-chi-tiet/-/chi-tiet/co-hoi-quang-ba-hang-viet-nam-xuat-khau-vao-thi-truong-a-rap-xe-ut-khoi-thi-truong-a-rap-22024-22.html']

    def parse(self, response): 
        url = '//*[@id="contentnews"]/p/text()'
        stri = response.xpath(url).extract()
        print(stri)
        print("Size: "+str(len(stri)))
        # for (i in range(stri.size)):
            
                  # .extract()[i].strip())

c = CrawlerProcess(get_project_settings())
c.crawl(MySpider)
c.start()