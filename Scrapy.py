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
        category_page_info = self.connectDB().execute('select ministry_id,category_link_root, category_id from category_info where ministry_id = 1 ')
        for row in category_page_info:   
            page_param_info = self.connectDB().execute('select page_rule,article_param_xpath,ministry_id from ministry_category_configuration where ministry_id = $'+str(row[0])+' and category_id = $'+str(row[2]) )        
            for page_info in page_param_info:    
                print("urk2: "+str(row))
                #if there's no get param link
                if (page_info[1]==""):
                    print
                else: 
                    #get url with param  
                    url = self.covertStringToResponse(row[1]).xpath(page_info[1])
                                     
                    if (row[0]==7):    
                        param = int(url[len(url)-1])
                    elif (row[0]==14):
                        param = self.getMicParam(str(url[len(url)-1]))  
                    elif (row[0]==24):
                        param = self.getVassParam(str(url[len(url)-1]))  
                    else:
                        param = self.getParam(str(url[len(url)-1]))
                for i in range (1,1+1): 
                    ##ministry 6, 11 doesn't use param
                    if (row[0]==6 or row[0]==11 or row[0]==16 or row[0]==19 or row[0] == 21):
                        articleUrl = row[1]                        
                    else:
                        ##ministry 8, 14 need to be removed default last param before crawl by param
                        if (row[0]==8 or row[0]==24):
                            row[1] = row[1][:-1]                            
                        if (row[0]==14):
                            startPoint = self.getMicStartpoint(str(url))
                            endPoint = self.getMicEndpoint(str(url))
                            articleUrl = startPoint + str(i) + endPoint
                            articleUrl = "https://www.mic.gov.vn"+articleUrl[2:-2]       
                        else: 
                            articleUrl = row[1]+str(i) 
                    self.parseCategoryResponse(self.covertStringToResponse(articleUrl), row[0])                    
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
                        ##bo ldtbxh
                        elif (ministryId == 6):                            
                            article_url_xpaths[url_index] = "http://www.mpi.gov.vn/Pages/"+str(article_url_xpaths[url_index])
                        ##bo ldtbxh
                        elif (ministryId == 8):                            
                            article_url_xpaths[url_index] = "http://www.molisa.gov.vn"+str(article_url_xpaths[url_index])
                        ##bo nong nghiep
                        elif (ministryId == 10):                            
                            article_url_xpaths[url_index] = "http://www.mard.gov.vn"+str(article_url_xpaths[url_index])
                        ##bo quoc phong
                        elif (ministryId == 11):                            
                            article_url_xpaths[url_index] = "http://www.mod.gov.vn/wps/portal/!ut/p/b1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLdHP2CLJwMHQ38zT0sDDyNnZ1NjcOMDQ2CzIEKIoEKDHAARwPi9Du7O3qYmPsYGFj4uJsaeDp6hAZZBhobGzgaE9Ifrh8FVoLPBLACPE7088jPTdUvyA2NMMgyUQQAfwOf3g!!/dl4/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_FANR8B1A081F00I32T4LDI2064/ren/p=WCM_PI=1/p=ns_Z7_FANR8B1A081F00I32T4LDI2064_WCM_PreviousPageSize.4e92abb3-6db2-476b-85b7-8c31f62282a0=10/p=ns_Z7_FANR8B1A081F00I32T4LDI2064_WCM_Page.4e92abb3-6db2-476b-85b7-8c31f62282a0=/p=CTX=QCPmodQCPsa-mod-siteQCPsa-ttsk/-/"+str(article_url_xpaths[url_index])
                        ##bo 
                        elif (ministryId == 12):                            
                            article_url_xpaths[url_index] = "ttps://www.mof.gov.vn"+str(article_url_xpaths[url_index])
                        ##bo thong tin truyen thong
                        elif (ministryId == 14):
                            article_url_xpaths[url_index] = "https://www.mic.gov.vn"+str(article_url_xpaths[url_index])
                        ##bo tu phap
                        elif (ministryId == 15):
                            article_url_xpaths[url_index] = "https://moj.gov.vn"+str(article_url_xpaths[url_index])
                        ##bo vh, tt & dl
                        elif (ministryId == 16):
                            article_url_xpaths[url_index] = "https://bvhttdl.gov.vn"+str(article_url_xpaths[url_index])
                        ##uy ban dan toc
                        elif (ministryId == 20):
                            article_url_xpaths[url_index] = "http://cema.gov.vn"+str(article_url_xpaths[url_index])
                        ##ngan hang nnvn
                        elif (ministryId == 21):
                            article_url_xpaths[url_index] = "https://www.sbv.gov.vn"+str(article_url_xpaths[url_index])
                        ##bo y te
                        elif (ministryId == 22):
                            article_url_xpaths[url_index] = "https://baohiemxahoi.gov.vn/tintuc/Pages/linh-vuc-bao-hiem-y-te.aspx"+str(article_url_xpaths[url_index])
                        ##vien han lam khcn
                        elif (ministryId == 23):
                            article_url_xpaths[url_index] = "https://vast.gov.vn"+str(article_url_xpaths[url_index])

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
                        if (ministryId==11):
                            article_content = article_content[2:]
                        print("Content: "+str(article_content))
            self.saveArticleToDB(ministryId,article_title,article_description,article_time,article_author_xpath,article_content)
            print("\n")
    
    
    def getParam(self, param_url):
        param = ""
        for i in range(len(param_url),0,-1):
            if (param_url[i-1] != "="):
                param += param_url[i-1]
            else:
                return int(param[::-1])
            
    def getMicParam(self, param_url):
        param = ""
        checkFirstDash = False
        for i in range(len(param_url),0,-1):
            if (param_url[i-1] != "/"):
                param += param_url[i-1]                
            else:
                if (checkFirstDash == False):
                    checkFirstDash = True
                    param = ""
                else:                    
                    return param[::-1]
                
    def getMicEndpoint(self, param_url):
        param = ""
        for i in range(len(param_url),0,-1):
            if (param_url[i-1] != "/"):
                param += param_url[i-1]
            else:
                return '/'+str(param[::-1])
    
    def getMicStartpoint(self, param_url):
        param = ""
        count = 0
        for i in range(len(param_url),0,-1):
            if (param_url[i-1] != "/"):
                if (count == 2):
                    param = str(param_url[:i+1])
                    return param
            else: 
                count += 1 
                
    def getVassParam(self, param_url):
        param = ""
        for i in range(len(param_url),0,-1):
            if (param_url[i-1] != "."):
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
    
    
    def saveArticleToDB(self, ministry_id,article_url,article_title,article_description,article_time,article_author, article_content):        
        self.connectDB().execute('''
                INSERT INTO WebDB.dbo.article_info (ministry_id,article_url,article_title,article_description,article_time,
                                                    article_author, article_content)
                VALUES
                (ministry_id,article_url,article_title,article_description,article_time, article_author, article_content)
                ''')
        self.connectDB().commit()
                
        

p = MySpider()
p.getUrl()