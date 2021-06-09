import pyodbc
import scrapy
import requests
from lxml import html 
import datetime

class MySpider(scrapy.Spider):    
    name = "crawl_news"         
    
    def connectDB(self):    
        conn = pyodbc.connect('Driver={SQL Server}; Server=DESKTOP-66ME5GV; Database=WebDB; Trusted_Connection=yes;')    
        cursor = conn.cursor()
        return cursor
    
    
    def covertStringToResponse(self,url):
        response = requests.get(url)            
        doc = html.fromstring(response.text)
        return doc
    
    
    def getUrl(self):
        legislation_page_info = self.connectDB().execute('select ministry_id,legislation_link_root, legislation_id from legislationinfo where ministry_id = 7')        
        
        for row in legislation_page_info:   
            page_param_info = self.connectDB().execute('select page_rule, legislation_param_xpath,ministry_id from ministry_legislation_configuration where ministry_id = $'+str(row[0])+" and legislation_id = $"+str(row[2])) 
            #print(row[0])
            #print(row[1])
            #print(row[2])
            
            gotParam = False
            
            for page_info in page_param_info:
                print(page_info[1])
                if (gotParam == False):
                    url = self.covertStringToResponse(row[1]).xpath(page_info[1])
                    print(url)
                    gotParam = True        
                param = self.getParam(str(url[len(url)-1]))
                for i in range (1,2):                    
                    self.parseCategoryResponse(self.covertStringToResponse(row[1]+str(i)), row[0])                    
                    i += page_info[0]
    
    
    def parseCategoryResponse(self, response, ministryId): 
        legislation_detail = self.connectDB().execute('select legislation_url_xpath from ministry_legislation_configuration where ministry_id = $'+str(ministryId))
        for row in legislation_detail:
            for i in range (len(row)):
                ## i = 1 for legislation url to save legislation to DB                
                legislation_url_xpaths = response.xpath(row[i])
                for url_index in range (len(legislation_url_xpaths)):
                ##bo cong an
                    if (ministryId == 1):
                        legislation_url_xpaths[url_index] = "http://bocongan.gov.vn/van-ban/van-ban-quy-pham.html"+str(legislation_url_xpaths[url_index])
                ##bo gddt
                    elif (ministryId == 4):
                        legislation_url_xpaths[url_index] = "https://moet.gov.vn/van-ban/vanban/Pages/default.aspx"+str(legislation_url_xpaths[url_index])
                ##bo tu phap
                    elif (ministryId == 7):
                        legislation_url_xpaths[url_index] = "http://www.most.gov.vn/vn/Pages/Vanbanphapluat.aspx"+str(legislation_url_xpaths[url_index])
                        print("Url: "+str(legislation_url_xpaths[url_index]))
                        self.parseArticleResponse(legislation_url_xpaths[url_index], ministryId)
                    
                        
                        
    def parseArticleResponse(self, legislation_url, ministryId): 
        legislation_response = self.covertStringToResponse(legislation_url)
        legislation_detail = self.connectDB().execute('select legislation_name_xpath, legislation_so_hieu_van_ban, legislation_ngay_ban_hanh, legislation_ngay_hieu_luc, legislation_ngay_ky, legislation_trich_yeu, legislation_co_quan_ban_hanh, legislation_nguoi_ky, legislation_loai_van_ban, legislation_tinh_trang from legislation_configuration where ministry_id = $'+str(ministryId))
        for row in legislation_detail:
            legislation_name = ""
            legislation_sohieu = ""
            legislation_ngaybanhanh = ""
            legislation_ngayhieuluc = ""
            legislation_ngayky = ""
            legislation_trichyeu = ""
            legislation_coquanbanhanh = ""
            legislation_nguoiky = ""
            legislation_loaivanban = ""
            legislation_tinhtrang = ""
            legislation_link = ""
            for i in range (len(row)):
                if row[i] and not row[i].isspace():
                    if (i == 0):
                        legislation_name = legislation_response.xpath(row[i])
                        print("Name: "+str(legislation_name))
                    elif (i == 1):
                        legislation_sohieu = legislation_response.xpath(row[i])
                        print("Des: "+str(legislation_sohieu))
                    elif (i == 2):
                        legislation_ngaybanhanh = legislation_response.xpath(row[i])
                        print("Time: "+str(legislation_ngaybanhanh))
                    elif (i == 3):                        
                        legislation_ngayhieuluc =  legislation_response.xpath(row[i])
                        print("Author: "+str(legislation_ngayhieuluc))
                    elif (i == 4):
                        legislation_ngayky = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Content: "+str(legislation_ngayky))
                    elif (i == 5):
                        legislation_trichyeu = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Content: "+str(legislation_trichyeu))
                    elif (i == 6):
                        legislation_coquanbanhanh = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Content: "+str(legislation_coquanbanhanh))
                    elif (i == 7):
                        legislation_nguoiky = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Content: "+str(legislation_nguoiky))
                    elif (i == 8):
                        legislation_loaivanban = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Content: "+str(legislation_loaivanban))
                    elif (i == 9):
                        legislation_tinhtrang = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Content: "+str(legislation_tinhtrang))
                    elif (i == 10):
                        legislation_link = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Content: "+str(legislation_link))
            print("\n")
    
    
    def getParam(self, param_url):
        param = ""
        if (param_url == ''):
            param = int('0')
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
        conn = pyodbc.connect('Driver={SQL Server}; Server=DESKTOP-66ME5GV; Database=WebDB; Trusted_Connection=yes;')
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