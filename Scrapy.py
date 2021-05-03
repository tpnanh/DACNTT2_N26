import pyodbc
import scrapy
from scrapy.crawler import CrawlerProcess

class MySpider(scrapy.Spider):
    
    name = "crawl_bo_cong_an" 
    
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')

    cursor = conn.cursor()
    cursor.execute('SELECT * FROM NEWSINFO')
    
    for row in cursor:
        print(row[0])
        start_urls = [row[0]]          

    def parse(self, response):
        conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')

        cursor = conn.cursor()
        cursor.execute('SELECT * FROM NEWSINFO')
        for row in cursor:
            count = len(response.xpath(row[1]))
            print("Content: ")
            for i in range(0, count-4):
                print(response.xpath(row[1]+'/text()').extract()[i].strip())


#'http://bocongan.gov.vn/tin-tuc-su-kien/xay-dung-luc-luong-cong-an-hai-duong-dap-ung-yeu-cau-nhiem-vu-duoc-giao-t29741.html'
c = CrawlerProcess({
    'USER_AGENT': 'Mozilla/5.0',
    'FEED_FORMAT': 'csv',
    'FEED_URI': 'output.csv',
})
c.crawl(MySpider)
c.start()