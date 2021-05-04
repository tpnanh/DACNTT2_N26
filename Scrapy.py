import pyodbc
import scrapy
from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

class MySpider(scrapy.Spider):
    
    name = "crawl_news" 
        
    
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')

    cursor = conn.cursor()
    cursor.execute('SELECT * FROM NEWSINFO')
    
    for row in cursor:
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
            for i in range(0, count):
                print(response.xpath(row[1]+'/text()').extract()[i].strip())

c = CrawlerProcess(get_project_settings())
c.crawl(MySpider)
c.start()