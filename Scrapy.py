import pyodbc
import scrapy
import requests
from lxml import html 
import datetime

class MySpider(scrapy.Spider):    
    name = "crawl_news"         
    
    def connectDB(self):    
        conn = pyodbc.connect('Driver={SQL Server};'
                          'Server=ANISE-TR\SQLEXPRESS;'
                          'Database=WebDB;'
                          'Trusted_Connection=yes;')    
        cursor = conn.cursor()
        return cursor
    
    
    def covertStringToResponse(self,url):
        response = requests.get(url)            
        doc = html.fromstring(response.text)
        return doc
    
    
    def getUrl(self):
        category_page_info = self.connectDB().execute('select ministry_id,category_link_root, category_id from category_info where ministry_id = 8')        
        for row in category_page_info:   
            page_param_info = self.connectDB().execute('select page_rule,article_param_xpath,ministry_id from ministry_category_configuration where ministry_id = $'+str(row[0])+" and category_id = $"+str(row[2])) 
            print("in no ra2: "+str(row[2]))
            
            gotParam = False
            for page_info in page_param_info:                   
                if (gotParam == False):
                    url = self.covertStringToResponse(row[1]).xpath(page_info[1])
                    print("in no ra: "+str(url))
                    
                    if (row[0]!=7):    
                        param = self.getParam(str(url[len(url)-1]))
                    else:                   
                        param = int(url[len(url)-1])
                    gotParam = True  
                for i in range (1,param):                    
                    self.parseCategoryResponse(self.covertStringToResponse(row[1]+str(i)), row[0])                    
                    i += page_info[0]

    
    def parseCategoryResponse(self, response, ministryId): 
        category_detail = self.connectDB().execute(' select ministry_id,article_url_xpath,article_thumbnail_xpath from ministry_category_configuration where ministry_id = $'+str(ministryId))
        for row in category_detail:
            for i in range (len(row)):
                ## i = 1 for article url to save article to DB                
                if (i == 1):                    
                    article_url_xpaths = response.xpath(row[i])
                    for url_index in range (len(article_url_xpaths)):
                        ##bo cong an
                        if (ministryId == 1):
                            article_url_xpaths[url_index] = "http://bocongan.gov.vn"+str(article_url_xpaths[url_index])
                        ##bo gddt
                        elif (ministryId == 4):
                            article_url_xpaths[url_index] = "https://moet.gov.vn/tintuc/Pages/Thongbao.aspx"+str(article_url_xpaths[url_index])
                        ##bo tu phap
                        elif (ministryId == 15):
                            article_url_xpaths[url_index] = "https://moj.gov.vn"+str(article_url_xpaths[url_index])
                        print("Url: "+str(article_url_xpaths[url_index]))
                        self.parseArticleResponse(article_url_xpaths[url_index], ministryId)
                ## i = 2 for article thumbnail       
                elif (i == 2 and row[i] and not row[i].isspace()):
                    article_thumbnail_xpath = response.xpath(row[i])
                    
                        
                        
    def parseArticleResponse(self, article_url, ministryId): 
        article_response = self.covertStringToResponse(article_url)
        article_detail = self.connectDB().execute('select article_title_xpath,article_description_xpath,article_time_xpath,article_author_xpath,article_content_xpath from ministry_articles_configuration where ministry_id = $'+str(ministryId))
        for row in article_detail:
            article_title = ""
            article_description = ""
            article_time = ""
            article_author_xpath = ""
            article_content = ""
            for i in range (len(row)):
                if row[i] and not row[i].isspace():
                    if (i == 0):
                        article_title = article_response.xpath(row[i])
                        print("Title: "+str(article_title))
                    elif (i == 1):
                        article_description = article_response.xpath(row[i])
                        print("Des: "+str(article_description))
                    elif (i == 2):
                        article_time = article_response.xpath(row[i])
                        print("Time: "+str(article_time))
                    elif (i == 3):                        
                        article_author_xpath =  article_response.xpath(row[i])
                        print("Author: "+str(article_author_xpath))
                    elif (i == 4):
                        article_content = self.clearSpace(article_response.xpath(row[i]))
                        print("Content: "+str(article_content))
            print("\n")
    
    
    def getParam(self, param_url):
        param = ""
        for i in range(len(param_url),0,-1):
            if (param_url[i-1] != "="):
                param += param_url[i-1]
            else:
                return int(param[::-1])
                
            
    def clearSpace(self, listString):
        return [string for string in listString if string != ' ']
                
                    
    def covertStringFromArticleToSqlFormat (self, dateString):
        #from 28/02/2021 to 2021/02/28
        dt = datetime.datetime.strptime(dateString, '%d/%m/%Y')
        return '{2}/{1:02}/{0:02}'.format(dt.day, dt.month, dt.year)
        

    def covertStringFromSqlToArticleFormat (self, dateString):
        #from 2021/02/28 to 28/02/2021
        dt = datetime.datetime.strptime(dateString, '%Y/%m/%d')
        return '{0:02}/{1:02}/{2}'.format(dt.day, dt.month, dt.year)
    
    
    def saveArticleToDB(self):
        conn = pyodbc.connect('Driver={SQL Server};'
                          'Server=ANISE-TR\SQLEXPRESS;'
                          'Database=WebDB;'
                          'Trusted_Connection=yes;')    
        cursor = conn.cursor()        
        cursor.execute('''
                INSERT INTO WebDB.dbo.article_info (Name, Age, City)
                VALUES
                ('Bob',55,'Montreal'),
                ('Jenny',66,'Boston')
                ''')
        conn.commit()
                
        

p = MySpider()
p.getUrl()