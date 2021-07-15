import pyodbc
import scrapy
import requests
from lxml import html 
import datetime
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from time import sleep
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
        category_page_info = self.connectDB().execute('select ministry_id,category_link_root, article_category_type_id from article_category_info where ministry_id = 25')
        for row in category_page_info:  
            print(row[1])
            page_param_info = self.connectDB().execute('select page_rule,article_param_xpath,article_url_xpath, article_thumbnail_xpath from ministry_article_category_configuration where ministry_id = $' + str(row[0]) + 'and article_category_type_id = $' + str(row[2]))        
            for page_info in page_param_info:   
                #if there's no get param link
                if (page_info[1]==""):
                    try:
                        list_baiviet = self.crawlBySelenium(row[1],page_info[2], row[0], page_info[3])
                    except RequestException as e:
                        print(e)
                    
                    try:
                        for baiviet in list_baiviet:
                            self.parseArticleResponse(baiviet,page_info[3], row[0],self.covertStringToResponse(row[1]))
                    except RequestException as e:
                        print(e)
                else: 
                    #get url with param  
                    url = self.covertStringToResponse(row[1]).xpath(page_info[1])
                                     
                    if (row[0]==7):    
                        param = int(url[len(url)-1])
                    elif (row[0]==14):
                        try:
                            param = self.getMicParam(str(url[len(url)-1]))  
                        except:
                            continue
                    elif (row[0]==24):
                        param = self.getVassParam(str(url[len(url)-1]))  
                    else:
                        try:
                            param = self.getParam(str(url[len(url)-1]))
                        except:
                            continue
                    param = int(param)
                    for i in range (1,param):
                        tempRow = row[1]                        
                        if i > 3:                     
                            break
                        ##ministry doesn't use param
                        if (row[0]==6 or row[0]==11 or row[0]==16 or row[0]==19 or row[0] == 21):                            
                            articleUrl = row[1]                        
                        else:                            
                            ##ministry 8, 14 need to be removed default last param before crawl by param
                            if (row[0] == 8 or row[0] == 15 or row[0]==24):
                                row[1] = row[1][:-1]
                                articleUrl = row[1]+str(i)                                 
                                # break
                            if (row[0]==14):
                                startPoint = self.getMicStartpoint(str(url))
                                endPoint = self.getMicEndpoint(str(url))
                                articleUrl = startPoint + str(i) + endPoint
                                articleUrl = "https://www.mic.gov.vn"+articleUrl[2:-2]       
                            else: 
                                articleUrl = row[1]+str(i)    
                        row[1] = tempRow
                        try:  
                            self.parseArticleCategoryResponse(self.covertStringToResponse(articleUrl), row[0], page_info[2], page_info[3])                    
                        except:
                            continue
    
    def parseArticleCategoryResponse(self, response, ministryId, article_url_xpath, article_thumbnail_xpath):         
        article_url_xpaths = response.xpath(article_url_xpath)
        article_thumbnail_url = response.xpath(article_thumbnail_xpath)

        startPoint = ""
        
        for url_index in range (len(article_url_xpaths)):                        
            ##bo cong an
            if (ministryId == 1):
                startPoint = "http://bocongan.gov.vn"
            ##bo gddt
            elif (ministryId == 4):
               startPoint = "https://moet.gov.vn/tintuc/Pages/Thongbao.aspx"
            ##bo ldtbxh
            elif (ministryId == 8):                            
                startPoint = "http://www.molisa.gov.vn"
            ##bo quoc phong
            elif (ministryId == 11):                            
                startPoint = "http://www.mod.gov.vn/wps/portal/!ut/p/b1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLdHP2CLJwMHQ38zT0sDDyNnZ1NjcOMDQ2CzIEKIoEKDHAARwNC-sP1o8BKnN0dPUzMfQwMLHzcTQ08HT1CgywDjY0NHI2hCvBY4eeRn5uqX5AbYZBl4qgIANgfRb4!/dl4/d5/L2dBISEvZ0FBIS9nQSEh/"
            ##bo thong tin truyen thong
            elif (ministryId == 14):
                startPoint = "https://www.mic.gov.vn"
            ##bo tu phap
            elif (ministryId == 15):
                startPoint = "https://moj.gov.vn"
            ##bo vh, tt & dl
            elif (ministryId == 16):
                startPoint = "https://bvhttdl.gov.vn"
            ##uy ban dan toc
            elif (ministryId == 20):
                startPoint = "http://cema.gov.vn"
            ##bo y te
            elif (ministryId == 22):
                startPoint = "https://baohiemxahoi.gov.vn/tintuc/Pages/linh-vuc-bao-hiem-y-te.aspx"
                
            if (ministryId == 15 and str(article_url_xpaths[url_index]).startswith("http")):
                article_url_xpaths[url_index] 
                article_thumbnail_url[url_index]
            else:
                article_url_xpaths[url_index] = startPoint + str(article_url_xpaths[url_index])   
                article_thumbnail_url[url_index] = startPoint + str(article_thumbnail_url[url_index])

            ##article_url_xpaths[url_index] is detail article url
            self.parseArticleResponse(article_url_xpaths[url_index], article_thumbnail_url[url_index], ministryId, response)                    
                        
                        
    def parseArticleResponse(self, article_url, article_thumbnail, ministryId, response): 
        article_response = self.covertStringToResponse(article_url)
        article_detail = self.connectDB().execute('select article_title_xpath,article_description_xpath,article_time_xpath,article_author_xpath,article_content_xpath from ministry_article_detail_configuration where ministry_id = $'+str(ministryId))
        
        for row in article_detail:            
            article_title_xpath = row[0]
            article_description_xpath = row[1]
            article_time_xpath = row[2]
            article_author_xpath = row[3]
            article_content_xpath = row[4]
            
        try:
            article_title = article_response.xpath(article_title_xpath)
        except: 
            article_title = ['']
            
        try:
            article_description = article_response.xpath(article_description_xpath)
        except:
            article_description = ['']
        
        try:
            article_time = article_response.xpath(article_time_xpath)
        except:
            article_time = ['']
        
        try: 
            article_author = article_response.xpath(article_author_xpath)
        except:
             article_author = ['']
             
        article_content = article_response.xpath(article_content_xpath)
        
        content = ""   
                
        if (ministryId == 5):
            article_thumbnail = "https://mt.gov.vn"+str(response.xpath(article_thumbnail)[0])
        if (ministryId == 7):
            try:
                article_thumbnail = "https://www.most.gov.vn"+str(response.xpath(article_thumbnail)[0])
            except:
                article_thumbnail = ""
        if (ministryId == 11):
            article_thumbnail = "http://www.mod.gov.vn"+str(response.xpath(article_thumbnail)[0])        
        if (ministryId == 17):
            article_thumbnail = "https://moc.gov.vn/"+str(response.xpath(article_thumbnail)[0])   
        if (ministryId == 18):
            article_thumbnail = "https://moh.gov.vn"+str(response.xpath(article_thumbnail)[0])
        if (ministryId == 25):
            article_thumbnail = "http://cmsc.gov.vn"+str(article_thumbnail)
        if (ministryId == 16 or ministryId == 19 or ministryId == 20):
            article_thumbnail = str(response.xpath(article_thumbnail)[0])
        
        for i in article_content:
            if ("\t" not in i or "\0" not in i or "\xa0" not in i):
                content = content + i

        content = content.strip()
        
        if (article_title != [''] and len(content) > 10):           
            content = content.replace("  ", "\n")
            self.saveArticleToDb(ministryId,article_url, article_title,article_description,article_time,article_author,content, article_thumbnail)
        
        print("\n -----------------")        
        
    
    def getLegislationUrl(self):
        legislation_page_info = self.connectDB().execute('select ministry_id,legislation_link_root, legislation_category_type_id from legislation_category_info') 
        
        for row in legislation_page_info:
            page_param_info = self.connectDB().execute('select page_rule, legislation_param_xpath,ministry_id, legislation_url_xpath from ministry_legislation_category_configuration where ministry_id = $'+str(row[0]) + ' and legislation_category_type_id = $' + str(row[2]))            
            for page_info in page_param_info:  
                #if there's no get param link
                if (page_info[1]==""):
                    print
                    # try:
                    #     list_baiviet = self.crawlBySelenium(row[1],page_info[3], row[0], '')
                    # except RequestException as e:
                    #     print(e)
                else:
                    #get url with param
                    url = self.covertStringToResponse(row[1]).xpath(page_info[3])
                    if (row[0]==11 or row[0]==14 or row[0]==22):
                        param = 0
                    else:
                        try:
                            param = self.getParam(str(url[len(url)-1]))                        
                        except:
                            continue
                for i in range (1,param):
                    if (i > 3):
                        break
                    ##ministries don't use param
                    if (row[0]==5 or row[0]==17 or row[0]==11 or row[0]==8 or row[0]==7 or row[0]==4 or row[0]==14 or row[0]==16 or row[0]==22):
                        legislationUrl = row[1]                        
                        sleep(2)
                        self.parseLegislationCategoryResponse(self.covertStringToResponse(legislationUrl), row[0], page_info[3])                       
                    else:                         
                        legislationUrl = row[1]+str(i) 
                
                    self.parseLegislationCategoryResponse(self.covertStringToResponse(legislationUrl), row[0], page_info[3])                    
    
    
    def parseLegislationCategoryResponse(self, response, ministryId, legislation_url_xpath): 
        legislation_url_xpaths = response.xpath(legislation_url_xpath)  

        for url_index in range (len(legislation_url_xpaths)):                        
            ##bo cong an
            if (ministryId == 1):
                #print(legislation_url_xpaths[url_index])
                legislation_url_xpaths[url_index] = "http://bocongan.gov.vn/van-ban/van-ban-quy-pham.html"+str(legislation_url_xpaths[url_index]) #done
            ##bo gddt
            elif (ministryId == 4):
                legislation_url_xpaths[url_index] = "https://moet.gov.vn"+str(legislation_url_xpaths[url_index]) #done
            ##bo noivu
            elif (ministryId == 3):
                url_noivu = str(legislation_url_xpaths[url_index])
                legislation_url_xpaths[url_index] = "https://doc.moha.gov.vn/"+ url_noivu[:-7] + "thuoctinh" #done
           ##bo gtvt
            elif (ministryId == 5):
                legislation_url_xpaths[url_index] = "https://mt.gov.vn/vn/Pages/"+str(legislation_url_xpaths[url_index]) #Failed to establish a new connection: [Errno 11001] getaddrinfo failed
            #bo khcn
            elif (ministryId == 7):                            
                legislation_url_xpaths[url_index] = "http://www.most.gov.vn/vn/Pages/"+str(legislation_url_xpaths[url_index]) #Failed to establish a new connection: [Errno 11001] getaddrinfo failed
            ##bo ldtbxh
            elif (ministryId == 8):                            
                legislation_url_xpaths[url_index] = "http://www.molisa.gov.vn"+str(legislation_url_xpaths[url_index]) #done                        
            ##bo quoc phong
            elif (ministryId == 11):
                url_quocphong = str(legislation_url_xpaths[url_index])                            
                legislation_url_xpaths[url_index] = "http://www.mod.gov.vn"+ url_quocphong[:-32] + str(legislation_url_xpaths[url_index]) #crawl được xíu thì Failed to establish a new connection: [Errno 11001] getaddrinfo failed'))
           ##bo thong tin truyen thong
            elif (ministryId == 14):
                url_tttt = str(legislation_url_xpaths[url_index])
                url_tttt = url_tttt[:-5]
                url_tttt = url_tttt[10:]
                legislation_url_xpaths[url_index] = "https://www.mic.gov.vn/" + url_tttt #done
            ##bo tu phap
            elif (ministryId == 15):
                url_tuphap = str(legislation_url_xpaths[url_index])
                legislation_url_xpaths[url_index] = "https://moj.gov.vn"+url_tuphap #Failed to establish a new connection: [Errno 11001] getaddrinfo failed'))
            ##bo vh, tt & dl
            elif (ministryId == 16):
                legislation_url_xpaths[url_index] = "https://bvhttdl.gov.vn"+str(legislation_url_xpaths[url_index]) #done
            ##bo vh, tt & dl
            elif (ministryId == 17):
                legislation_url_xpaths[url_index] = "https://moc.gov.vn/vn/Pages/"+str(legislation_url_xpaths[url_index]) #done
            ##uy ban dan toc
            elif (ministryId == 20):
                legislation_url_xpaths[url_index] = "http://csdl.ubdt.gov.vn"+str(legislation_url_xpaths[url_index]) #done
            ##bo
            elif (ministryId == 22):
                legislation_url_xpaths[url_index] = "https://baohiemxahoi.gov.vn"+str(legislation_url_xpaths[url_index])
            ##uy ban quan ly von dau tu
            elif (ministryId == 25):
                if (str(legislation_url_xpaths[url_index]).startswith("/doc")):
                    continue
                legislation_url_xpaths[url_index] = str(legislation_url_xpaths[url_index])  #done - cannot get xpath of link download yet

            self.parseLegislationResponse(legislation_url_xpaths[url_index], ministryId)                    
                        
                        
    def parseLegislationResponse(self, legislation_url, ministryId): 
        legislation_response = self.covertStringToResponse(legislation_url)
        legislation_detail = self.connectDB().execute('select legislation_name_xpath, legislation_so_hieu_van_ban_xpath, legislation_ngay_ban_hanh_xpath, legislation_ngay_hieu_luc_xpath, legislation_trich_yeu_xpath, legislation_co_quan_ban_hanh_xpath, legislation_nguoi_ky_xpath, legislation_loai_van_ban_xpath, legislation_tinh_trang_xpath, legislation_link_download_xpath from ministry_legislation_detail_configuration where ministry_id = $'+str(ministryId))
        for row in legislation_detail:                      
            legislation_name_xpath = row[0]
            legislation_sohieu_xpath = row[1]
            legislation_ngaybanhanh_xpath = row[2]
            legislation_ngayhieuluc_xpath = row[3]
            legislation_trichyeu_xpath = row[4]
            legislation_coquanbanhanh_xpath = row[5]
            legislation_nguoiky_xpath = row[6]
            legislation_loaivanban_xpath = row[7]
            legislation_tinhtrang_xpath = row[8]
            legislation_link_xpath = row[9]
            
        try:
            legislation_name = legislation_response.xpath(legislation_name_xpath)
        except:
            legislation_name = ['']
            
        try:
            legislation_sohieu = legislation_response.xpath(legislation_sohieu_xpath)
        except: 
            legislation_sohieu = ['']
            
        try:
            legislation_ngaybanhanh = legislation_response.xpath(legislation_ngaybanhanh_xpath)
        except:
            legislation_ngaybanhanh = ['']
            
        try:
            legislation_ngayhieuluc = legislation_response.xpath(legislation_ngayhieuluc_xpath)
        except:
            legislation_ngayhieuluc = ['']
            
        try:
            legislation_trichyeu = legislation_response.xpath(legislation_trichyeu_xpath)
        except:
            legislation_trichyeu = ['']
        
        try:   
            legislation_coquanbanhanh = legislation_response.xpath(legislation_coquanbanhanh_xpath)
        except:
            legislation_coquanbanhanh = ['']
            
        try:
            legislation_nguoiky = legislation_response.xpath(legislation_nguoiky_xpath)
        except:
            legislation_nguoiky = ['']
            
        try:
            legislation_loaivanban = legislation_response.xpath(legislation_loaivanban_xpath)       
        except:
            legislation_loaivanban = ['']
            
        try:
            legislation_tinhtrang = legislation_response.xpath(legislation_tinhtrang_xpath)
            
        except:
            legislation_tinhtrang = ['']           
            
        try:
            legislation_link = legislation_response.xpath(legislation_link_xpath)
        except:
            legislation_link = ['']
            
        if (ministryId == 1 or ministryId == 17 or ministryId == 20):
            legislation_loaivanban = ['']     
        
        self.saveLegislationToDb(ministryId, legislation_url, legislation_name, legislation_sohieu,legislation_ngaybanhanh,legislation_ngayhieuluc, legislation_trichyeu, legislation_coquanbanhanh, legislation_nguoiky, legislation_loaivanban, legislation_tinhtrang, legislation_link)
        print("\n -----------------")          
    
    
    def getParam(self, param_url):
        param = ""
        for i in range(len(param_url),0,-1):
            if (param_url[i-1] != "="):
                param += param_url[i-1]
            else:
                try:
                    return int(param[::-1])
                except:
                    break
            
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
                
                    
    def covertStringFromArticleToSqlFormat (self, dateString, ministryId):
        #from 28/02/2021 to 2021/02/28
        try:
            dt = datetime.datetime.strptime(str(dateString), '%d/%m/%Y')
            newDate = '{2}/{1:02}/{0:02}'.format(dt.day, dt.month, dt.year)         
            return newDate            
        except Exception as e:
            print(e)
            print(ministryId)
            if (ministryId == 3):
                dateString = dateString.split(' ')
                date = str(dateString[1].strip())
            if (ministryId == 5):
                dateString = dateString.split(' ')
                try:
                    date = str(dateString[1][5:].strip())  
                except Exception as e:
                    print(e)                    
                    date = str(dateString[1][4:].strip())
            if (ministryId == 11):
                dateString = dateString.split(' | ')
                date = str(dateString[1].strip())
            if (ministryId == 14 or ministryId == 22):
                dateString = dateString.split(' ')
                date = str(dateString[0])
            if (ministryId == 16 or ministryId == 18):
                dateString = dateString.split(' | ')
                date = str(dateString[0].strip())
            if (ministryId == 17 or ministryId == 7):
                 dateString = dateString.split(',')
                 date = str(dateString[1][1:11].strip())
            if (ministryId == 19):
                dateString = dateString.split(',')
                date = str(dateString[1].strip())
            if (ministryId == 20):
                dateString = dateString.split(' ')
                date = str(dateString[2].strip())
            dt = datetime.datetime.strptime(date, '%d/%m/%Y')
            newDate = '{2}/{1:02}/{0:02}'.format(dt.day, dt.month, dt.year)      
            return newDate
        

    def covertStringFromSqlToArticleFormat (self, dateString):
        #from 2021/02/28 to 28/02/2021
        dt = datetime.datetime.strptime(dateString, '%Y/%m/%d')
        return '{0:02}/{1:02}/{2}'.format(dt.day, dt.month, dt.year)
    
    
    def saveArticleToDb(self, ministry_id, article_url, article_title,article_description,article_time,article_author, article_content, article_thumbnail):   
        try:
            conn = pyodbc.connect('Driver={SQL Server};'
                              'Server=ANISE-TR\SQLEXPRESS;'
                              'Database=WebDB;'
                              'Trusted_Connection=yes;')  
            if (ministry_id == 3 or ministry_id == 8 or ministry_id == 18 or ministry_id == 19 or ministry_id == 20):
                article_author = [""]
            if (ministry_id == 11):    
                article_description = ["".join(article_description)]
            if (ministry_id == 25):
                article_time = [article_time[1]]   
            
            value =  [(ministry_id, article_url, article_title[0].strip(),article_description[0],str(self.covertStringFromArticleToSqlFormat(article_time[0].strip(), ministry_id)),article_author[0], article_content, article_thumbnail)]
            # print(value[0])
            conn.cursor().execute("""                                  
                                  INSERT INTO WebDB.dbo.article_info 
                                  (ministry_id, article_url , article_title,article_description,article_time,article_author, article_content, article_thumbnail) 
                                  VALUES (?, ?, ?, ?, ?, ?, ?, ?)""", value[0])
            conn.commit()

        except Exception as e:
            print(e)        
        finally:
            conn.cursor().close()
            conn.close()                       
            
    def saveLegislationToDb(self, ministry_id, legislation_url, legislation_name, so_hieu_van_ban,ngay_ban_hanh,ngay_hieu_luc, trich_yeu, co_quan_ban_hanh, nguoi_ky, loai_van_ban, tinh_trang, link_download):   
        try:
            conn = pyodbc.connect('Driver={SQL Server};'
                              'Server=ANISE-TR\SQLEXPRESS;'
                              'Database=WebDB;'
                              'Trusted_Connection=yes;')  
            
            value =  [(ministry_id, legislation_url, legislation_name[0].replace("\r\n","").strip().capitalize(),so_hieu_van_ban[0].replace("\r\n","").strip(),ngay_ban_hanh[0].replace("\r\n","").strip(),self.returnNullData(ngay_hieu_luc).replace("\r\n","").strip(),self.returnNullData(trich_yeu).replace("\r\n","").strip(), co_quan_ban_hanh[0].replace("\r\n","").strip(), nguoi_ky[0].replace("\r\n","").strip(), loai_van_ban[0].replace("\r\n","").strip(), self.returnNullData(tinh_trang), self.returnNullLink(link_download, ministry_id))]
            
            # print(value[0])
            conn.cursor().execute("""                                  
                                  INSERT INTO WebDB.dbo.legislation_info 
                                  (ministry_id, legislation_url, legislation_name, so_hieu_van_ban,ngay_ban_hanh,ngay_hieu_luc, trich_yeu, co_quan_ban_hanh, nguoi_ky, loai_van_ban, tinh_trang, link_download) 
                                  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)""", value[0])
            conn.commit()
        except Exception as e:
            print(e)        
        finally:
            conn.cursor().close()
            conn.close()
            
    def returnNullData(self, data):        
        if (data == []):
            return ""
        else:
            return data[0] 
            
    def returnNullLink(self, data,ministryId):        
        if (data == []):
            return ""
        else:
            if (ministryId == 5):
                data[0]  = "https://mt.gov.vn/" +str(data[0]) 
            if (ministryId == 7):
                data[0]  = "http://www.most.gov.vn" +str(data[0])
            if (ministryId == 8):
                data[0]  = "http://www.molisa.gov.vn" +str(data[0])
            if (ministryId == 17):
                data[0]  = "https://moc.gov.vn/vn" +str(data[0])   
            if (ministryId == 25):
                data[0]  = "http://cmsc.gov.vn" +str(data[0])   
            return data[0] 
            
    def read_config(self):
    	chrome_options = webdriver.ChromeOptions()
    	chrome_options.add_argument('--no-sandbox')
    	chrome_options.add_argument('--headless')
    	driver = webdriver.Chrome('E:\STUDY\DACNTT2_N26\DA-26_Web\Scripts\mysite\chromedriver', options=chrome_options)
    	return driver
            
    def crawlBySelenium(self, categoryUrl, detailUrlXpath, ministryId, thumbnailUrl):
        response = self.covertStringToResponse(categoryUrl)
        driver = self.read_config()
        driver.get(categoryUrl)#link tin chứa tức
        WebDriverWait(driver,5)
        
        list_baiviet = []#danh sách bài viết
        count = 1
        html = HTML(html=driver.page_source)
        list_baiviet = html.xpath(detailUrlXpath)#crawl đầu tiên

        while True:
            try:
                try:                    
                    nextBtnXpath = ""
                    if (ministryId == 3):
                        nextBtnXpath = '/html/body/form/div[3]/main/div/div/div/div[1]/div[2]/div[2]/div/div/div/div[2]/div/ul/li[3]'
                    if (ministryId == 5):    
                        nextBtnXpath = '//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_lkNext2"]'
                    if (ministryId == 7):
                        nextBtnXpath = '//*[@id="ctl00_SPWebPartManager1_g_0623dffd_eff8_4f9c_bf6d_2cdf2561adec_ctl00_lkNext2"]'
                    if (ministryId == 11):    
                        nextBtnXpath = '//*[@class="page"]/a[6]'                        
                    if (ministryId == 16):
                        nextBtnXpath = '//*[@id="mainHtml"]/body/div[3]/div[1]/div[2]/div[2]/div/ul/li[5]/a'
                    if (ministryId == 17):
                        nextBtnXpath = '//*[@id="ctl00_SPWebPartManager1_g_98940a7e_2c09_45ce_b14f_1469576fa0d6_ctl00_lkNext2"]'
                    if (ministryId == 18):
                        nextBtnXpath = '//*[@id="p_p_id_101_INSTANCE_TW6LTp1ZtwaN_"]/div/div/div[23]/ul/li[4]/a'
                    if (ministryId == 19):
                        nextBtnXpath = '//*[@id="tinkhac"]/div/table/tbody/tr/td/div/a[1]'
                    if (ministryId == 20):
                        nextBtnXpath = '//*[@id="BodyContent_ctl00_leftPanel"]/div/div/div/div[3]/div[3]/ul/li[6]/a'
                  
                    element = driver.find_element_by_xpath(nextBtnXpath)#tìm nút next                    
                    element.click()# thực hiện click để chuyển trang
                    sleep(2)# ngủ 2s để load bài mới
                except Exception as e:#nếu crawl hết dừng
                    print(e)
                    break
                count += 1
                if count == 1:#crawl 2 lần, tắt đi để crawl hết
                    break
                
                html = HTML(html=driver.page_source)#page thành HTML để xpath                
                tmp = html.xpath(detailUrlXpath)#lấy bài mới
                
                for url in tmp:                    
                    if (ministryId==11):                        
                        url = "http://www.mod.gov.vn/wps/portal/!ut/p/b1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLdHP2CLJwMHQ38zT0sDDyNnZ1NjcOMDQ2CzIEKIoEKDHAARwNC-sP1o8BKnN0dPUzMfQwMLHzcTQ08HT1CgywDjY0NHI2hCvBY4eeRn5uqX5AbYZBl4qgIANgfRb4!/dl4/d5/L2dBISEvZ0FBIS9nQSEh/"+str(url)
                    elif (ministryId == 16):
                        url = "https://bvhttdl.gov.vn"+str(url)
                    elif (ministryId == 20):
                        url = "http://cema.gov.vn"+str(url)

                    self.parseArticleResponse(url,thumbnailUrl, ministryId, response)                
                
                list_baiviet.extend(tmp)#thêm vào tập link 
            except Exception as e:
                print(e)
                break            
        return list_baiviet                
        

p = MySpider()
p.getLegislationUrl()
#p.getArticleUrl()
