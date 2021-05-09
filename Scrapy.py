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
        category_page_info = self.connectDB().execute('select ministry_id,category_link_root from category_info order by ministry_id asc')
        page_param = self.connectDB().execute('select page_rule from ministry_category_configuration')
        for row in category_page_info:   
            print("Here2: "+str(row[0]))
            print("Here: "+str(row[1]))
            param = self.getParam('http://www.moit.gov.vn/web/guest/thoi-su?p_p_id=CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_delta=10&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_keywords=&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_advancedSearch=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_andOperator=true&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_resetCur=false&_CmsViewTinTrangChuyenMuc_WAR_CmsViewEcoITportlet_INSTANCE_8sMB0Z1SkloP_cur=587')
            for i in range (1, int(param)):
                self.parseCategoryResponse(self.covertStringToResponse(row[1]+str(i)), row[0])
                for page_rule in page_param:
                    i += page_rule[0]
    
    
    def parseCategoryResponse(self, response, ministryId): 
        category_detail = self.connectDB().execute('select article_url_xpath,article_thumbnail_xpath from ministry_category_configuration where ministry_id = $'+ str(ministryId))
        for row in category_detail:
            for i in range (len(row)):
                ## i = 0 for article url to save article to DB
                if (i == 0):                    
                    article_url_xpath = response.xpath(row[i])
                    for url_index in range (len(article_url_xpath)):
                        print("Url: "+str(article_url_xpath[url_index]))
                        self.parseArticleResponse(article_url_xpath[url_index])
                ## i = 1 for article thumbnail       
                else:
                    article_thumbnail_xpath = response.xpath(row[i])
                    print("Thumb: "+str(article_thumbnail_xpath))
                    
                        
                        
    def parseArticleResponse(self, article_url): 
        article_response = self.covertStringToResponse(article_url)
        article_detail = self.connectDB().execute('select article_title_xpath,article_description_xpath,article_time_xpath,article_author_xpath,article_content_xpath from ministry_articles_configuration')
        for row in article_detail:
            article_title = ""
            article_description = ""
            article_time = ""
            article_author_xpath = ""
            article_content = ""
            for i in range (len(row)):
                if (i == 0):
                    article_title = article_response.xpath(row[i])[0]
                    print("Title: "+article_title)
                elif (i == 1):
                    article_description = article_response.xpath(row[i])[1]
                    print("Des: "+article_description)
                elif (i == 2):
                    article_time = article_response.xpath(row[i])[0]
                    print("Time: "+article_time)
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
                return param[::-1]
                
            
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