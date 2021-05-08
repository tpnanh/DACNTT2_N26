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
    
    
    def covertToResponse(self,url):
        response = requests.get(url)            
        doc = html.fromstring(response.text)
        return doc
    
    
    def getUrl(self):
        category_page = self.connectDB().execute('select category_link_root from category_info')
        for row in category_page:   
            print("Here: "+str(row[0]))
            self.parseCategoryResponse(self.covertToResponse(row[0]))
    
    
    def parseCategoryResponse(self, response): 
        category_detail = self.connectDB().execute('select article_url_xpath,article_thumbnail_xpath,category_param_xpath from ministry_category_configuration')
        for row in category_detail:
            for i in range (len(row)):
                # print("Content: "+str(row[i]))
                ## i = 0 for article url to save article to DB
                if (i == 0):                    
                    article_url_xpath = response.xpath(row[i])
                    for url_index in range (len(article_url_xpath)):
                        print("Url: "+str(article_url_xpath[url_index]))
                        self.parseArticleResponse(article_url_xpath[url_index])
                ## i = 1 for article thumbnail       
                elif (i == 1):
                    article_thumbnail_xpath = response.xpath(row[i])
                    print("Thumb: "+str(article_thumbnail_xpath))
                # else:
                #     category_param_xpath = response.xpath(row[i])[0]
                #     self.getParam(category_param_xpath)
                    
                        
                        
    def parseArticleResponse(self, article_url): 
        article_response = self.covertToResponse(article_url)
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
            
            
    # def parseCategoryResponse(self, article_thumbnail): 
    #     article_response = self.covertToResponse(article_thumbnail)
    
    # def getParam(self, param_url):
    #     print("Param url: "+str(param_url))
    #     for i in reversed(len(param_url)):
    #         count = 0
    #         print("Param: "+str(count))
            # if (param_url[i] != "="):
            #     count +=1
            #     print("Param: "+str(count))
            # else:
            #     print("Param: "+str(count))
                # return count
                
        # print("Param: "+param)
        # return param        
                    
            
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