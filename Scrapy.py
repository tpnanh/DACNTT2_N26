import pyodbc
import scrapy
import requests
from lxml import html 
import datetime
import requests
import lxml
from io import StringIO, BytesIO
from lxml import html, etree
from selenium import webdriver
from selenium.webdriver import Chrome
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
import time
from requests_html import HTML
from requests.exceptions import RequestException

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
    
    
    def getArticleUrl(self):
        category_page_info = self.connectDB().execute('select ministry_id,category_link_root, category_id from category_info where ministry_id = 12')
        for row in category_page_info:   
            page_param_info = self.connectDB().execute('select page_rule,article_param_xpath,article_url_xpath from ministry_category_configuration where ministry_id = $'+str(row[0])+' and category_id = $'+str(row[2]) )        
            for page_info in page_param_info:   
                #if there's no get param link
                if (page_info[1]==""):
                    try:
                        list_baiviet = self.crawlBySelenium(row[1],page_info[2], row[0])
                    except RequestException as e:
                        print(e)
                        
                    try:
                        for baiviet in list_baiviet:
                            self.parseArticleResponse(baiviet, row[0])
                    except RequestException as e:
                        print(e)
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
                    for i in range (1,1+2): 
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

    
    def parseArticleCategoryResponse(self, response, ministryId): 
        category_detail = self.connectDB().execute(' select ministry_id,article_url_xpath,article_thumbnail_xpath from ministry_category_configuration where ministry_id = $'+str(ministryId))
        for row in category_detail:            
            for i in range (len(row)):
                ## i = 1 for article url xpath to query the article url               
                if (i == 1):              
                    ## response is category url
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
                            article_url_xpaths[url_index] = "http://www.mod.gov.vn/wps/portal/!ut/p/b1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLdHP2CLJwMHQ38zT0sDDyNnZ1NjcOMDQ2CzIEKIoEKDHAARwNC-sP1o8BKnN0dPUzMfQwMLHzcTQ08HT1CgywDjY0NHI2hCvBY4eeRn5uqX5AbYZBl4qgIANgfRb4!/dl4/d5/L2dBISEvZ0FBIS9nQSEh/"+str(article_url_xpaths[url_index])
                        ##bo 
                        elif (ministryId == 12):                            
                            article_url_xpaths[url_index] = "https://www.mof.gov.vn"+str(article_url_xpaths[url_index])
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

                        ##article_url_xpaths[url_index] is detail article url
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
            article_author = ""
            article_content = ""
            if (article_response.xpath(row[0]) == [] or article_response.xpath(row[4]) == []):
                break
            else:
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
                            article_author =  article_response.xpath(row[i])
                            print("Author: "+str(article_author))
                        elif (i == 4):
                            article_content = self.clearSpace(article_response.xpath(row[i]))
                            if (ministryId==11):
                                article_content = article_content[2:]
                            print("Content: "+str(article_content))
            # self.saveArticleToDB(ministryId,article_url, article_title,article_description,article_time,article_author,article_content)
            print("\n -----------------")
            # self.select()
            # print("\n -----------------")
    
    
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
    
    
    def saveArticleToDB(self, ministry_id, article_url, article_title,article_description,article_time,article_author, article_content):   
        try:
            conn = pyodbc.connect('Driver={SQL Server};'
                              'Server=ANISE-TR\SQLEXPRESS;'
                              'Database=WebDB;'
                              'Trusted_Connection=yes;')  
            value =  [(ministry_id, article_url, article_title[0],article_description[0],article_time[0],article_author[0], "")]
            print ("hu: "+str(value[0]))
            conn.cursor().execute("""                                  
                                  INSERT INTO WebDB.dbo.article_info 
                                  (ministry_id, article_url , article_title,article_description,article_time,article_author, article_content) 
                                  VALUES (?, ?, ?, ?, ?, ?, ?)""", value[0])
            conn.commit()

        except Exception as e:
            print(e)        
        finally:
            conn.cursor().close()
            conn.close()
        
    def select(self):
        article = self.connectDB().execute('select * from article_info')
        for row in article:
            print("Row: "+str(row))
            
            
    def read_config(self):
    	chrome_options = webdriver.ChromeOptions()
    	chrome_options.add_argument('--no-sandbox')
    	chrome_options.add_argument('--headless')
    	driver = webdriver.Chrome('chromedriver', options=chrome_options)
    	return driver
            
    def crawlBySelenium(self, categoryUrl, detailUrlXpath, ministryId):
        driver = self.read_config()
        driver.get(categoryUrl)#link tin chứa tức
        WebDriverWait(driver,5)
        
        list_baiviet = []#danh sách bài viết
        count = 1
        html = HTML(html=driver.page_source)
        list_baiviet = html.xpath(detailUrlXpath)#crawl đầu tiên
        # print("ur: "+str(list_baiviet))

        while True:
            try:
                try:                    
                    nextBtnXpath = ""
                    if (ministryId == 3):
                        nextBtnXpath = '/html/body/form/div[3]/main/div/div/div/div[1]/div[2]/div[2]/div/div/div/div[2]/div/ul/li[3]'
                    if (ministryId == 5):    
                        nextBtnXpath = '//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_lkNext2"]'
                    if (ministryId == 6):
                        nextBtnXpath = '/html/body/form/div[8]/div/div[3]/div[2]/div[2]/div/div/div[2]/div[2]/div[1]/div/table/tbody/tr/td/table/tbody/tr/td/div/div/div/table/tbody/tr/td[1]/div/div/span[2]/a[1]'    
                    if (ministryId == 7):
                        nextBtnXpath = '//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_lkNext2"]'
                    if (ministryId == 11):    
                        nextBtnXpath = '//*[@class="page"]/a[6]'                        
                    if (ministryId == 12):
                        nextBtnXpath = '//*[@id="T:oc_1601563139region1:listTmplt:pbl16"]'
                    if (ministryId == 16):
                        nextBtnXpath = '//*[@id="p_p_id_101_INSTANCE_TW6LTp1ZtwaN_"]/div/div/div[22]/ul/li[5]/a'
                    if (ministryId == 18):
                        nextBtnXpath = '//*[@id="p_p_id_101_INSTANCE_k206Q9qkZOqn_"]/div/div/div[23]/ul/li[4]'
                    if (ministryId == 19):
                        nextBtnXpath = '//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_lkNext2"]'
                    if (ministryId == 20):
                        nextBtnXpath = '//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[3]/div[3]/ul/li[6]/a'
                    if (ministryId == 21):
                        nextBtnXpath = '//*[@class="x29y"]'
                    if (ministryId == 23):
                        nextBtnXpath = '//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_lkNext2"]'
                        
                    

                    element = driver.find_element_by_xpath(nextBtnXpath)#tìm nút next                    
                    element.click()# thực hiện click để chuyển trang
                    time.sleep(2)# ngủ 2s để load bài mới
                except Exception as e:#nếu crawl hết dừng
                    print(e)
                    break
                count += 1
                if count == 3:#crawl 2 lần, tắt đi để crawl hết
                    break
                
                html = HTML(html=driver.page_source)#page thành HTML để xpath
                
                tmp = html.xpath(detailUrlXpath)#lấy bài mới
                
                for url in tmp:                    
                    if (ministryId==11):                        
                        url = "http://www.mod.gov.vn/wps/portal/!ut/p/b1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLdHP2CLJwMHQ38zT0sDDyNnZ1NjcOMDQ2CzIEKIoEKDHAARwNC-sP1o8BKnN0dPUzMfQwMLHzcTQ08HT1CgywDjY0NHI2hCvBY4eeRn5uqX5AbYZBl4qgIANgfRb4!/dl4/d5/L2dBISEvZ0FBIS9nQSEh/"+str(url)
                    elif (ministryId == 12):                            
                        url = "https://www.mof.gov.vn"+str(url)
                        print("ur2: "+str(url))
                    elif (ministryId == 16):
                        url = "https://bvhttdl.gov.vn"+str(url)
                    elif (ministryId == 20):
                        url = "http://cema.gov.vn"+str(url)
                    elif (ministryId == 21):
                        url = "https://www.sbv.gov.vn"+str(url)
                        print("ur: "+str(url))
                    elif (ministryId == 23):
                        url = "https://www.sbv.gov.vn"+str(url)

                    self.parseArticleResponse(url, ministryId)                
                
                list_baiviet.extend(tmp)#thêm vào tập link 
            except Exception as e:#gặp sự cố dừng
                print(e)
                break            
        return list_baiviet                
        

p = MySpider()
p.getArticleUrl()