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
        legislation_page_info = self.connectDB().execute('select ministry_id,legislation_link_root, legislation_id from legislationinfo where ministry_id = 8')        
        
        for row in legislation_page_info:   
            page_param_info = self.connectDB().execute('select page_rule, legislation_param_xpath,ministry_id from ministry_legislation_configuration where ministry_id = $'+str(row[0])+" and legislation_id = $"+str(row[2])) 
            #print(row[0])
            print(row[1])
            #print(row[2])
            
            for page_info in page_param_info:    
                print("urk2: "+str(row))
                #if there's no get param link
                print(page_info[1])
                url = self.covertStringToResponse(row[1]).xpath(page_info[1])
                print(str(url))
                
                if (page_info[1]==""):
                    print
                else:
                    #get url with param
                   
                    if (row[0]==14):
                        param = self.getMicParam(str(url[len(url)-1]))
                        print(param)
                    elif (row[0]==24):
                        param = self.getVassParam(str(url[len(url)-1]))
                        print(param)
                    else:
                        param = self.getParam(str(url[len(url)-1]))
                        print(param)
                
                for i in range (2,5): 
                    ##ministry 6, 11 doesn't use param
                    if (row[0]==3 or row[0]==13 or row[0]==6 or row[0]==7 or row[0]==4 or row[0]==11 or row[0]==16 or row[0]==19 or row[0] == 21):
                        legislationUrl = row[1]                        
                    else:
                        ##ministry 8, 14 need to be removed default last param before crawl by param
                        if (row[0]==14) :
                            row[1] = row[1][:-1]                            
                        if (row[0]==14):
                            startPoint = self.getMicStartpoint(str(url))
                            print(startPoint)
                            endPoint = self.getMicEndpoint(str(url))
                            print(endPoint)
                            legislationUrl = startPoint + str(i) + endPoint
                            legislationUrl = "https://www.mic.gov.vn"+legislationUrl[2:-2]       
                        else: 
                            legislationUrl = row[1]+str(i) 
                    self.parseCategoryResponse(self.covertStringToResponse(legislationUrl), row[0])                    
                    i += page_info[0]
    
    
    def parseCategoryResponse(self, response, ministryId): 
        category_detail = self.connectDB().execute('select ministry_id, legislation_url_xpath from ministry_legislation_configuration where ministry_id = $'+str(ministryId))
        for row in category_detail:            
            for i in range (len(row)):
                ## i = 1 for legislation url to save legislation to DB                
                if (i == 1):                       
                    legislation_url_xpaths = response.xpath(row[i])
                    for url_index in range (len(legislation_url_xpaths)):                        
                        ##bo cong an
                        if (ministryId == 1):
                            legislation_url_xpaths[url_index] = "http://bocongan.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo gddt
                        elif (ministryId == 4):
                            legislation_url_xpaths[url_index] = "https://moet.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo noivu
                        elif (ministryId == 3):
                            legislation_url_xpaths[url_index] = "https://moha.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo congthuong
                        elif (ministryId == 2):
                            legislation_url_xpaths[url_index] = "http://www.moit.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo gtvt
                        elif (ministryId == 5):
                            legislation_url_xpaths[url_index] = "https://mt.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo ldtbxh
                        elif (ministryId == 6):                            
                            legislation_url_xpaths[url_index] = "http://www.mpi.gov.vn"+str(legislation_url_xpaths[url_index])
                        #bo khcn
                        elif (ministryId == 7):                            
                            legislation_url_xpaths[url_index] = "http://www.most.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo ldtbxh
                        elif (ministryId == 8):                            
                            legislation_url_xpaths[url_index] = "http://www.molisa.gov.vn/Pages"+str(legislation_url_xpaths[url_index])
                            print("legislation_url_xpaths bo ldxh" + legislation_url_xpaths[url_index])
                        ##bo nong nghiep
                        elif (ministryId == 10):                            
                            legislation_url_xpaths[url_index] = "http://www.mard.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo quoc phong
                        elif (ministryId == 11):                            
                            legislation_url_xpaths[url_index] = "http://www.mod.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo 
                        elif (ministryId == 12):                            
                            legislation_url_xpaths[url_index] = "ttps://www.mof.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo thong tin truyen thong
                        elif (ministryId == 14):
                            legislation_url_xpaths[url_index] = "https://www.mic.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo tu phap
                        elif (ministryId == 15):
                            legislation_url_xpaths[url_index] = "https://moj.gov.vn/"+str(legislation_url_xpaths[url_index])
                        ##bo vh, tt & dl
                        elif (ministryId == 16):
                            legislation_url_xpaths[url_index] = "https://bvhttdl.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##uy ban dan toc
                        elif (ministryId == 20):
                            legislation_url_xpaths[url_index] = "http://cema.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##ngan hang nnvn
                        elif (ministryId == 21):
                            legislation_url_xpaths[url_index] = "https://www.sbv.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##bo y te
                        elif (ministryId == 22):
                            legislation_url_xpaths[url_index] = "https://baohiemxahoi.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##vien han lam khcn
                        elif (ministryId == 23):
                            legislation_url_xpaths[url_index] = "https://vast.gov.vn"+str(legislation_url_xpaths[url_index])
                        ##uy ban quan ly von dau tu
                        elif (ministryId == 26):
                            legislation_url_xpaths[url_index] = "http://cmsc.gov.vn/"+str(legislation_url_xpaths[url_index])

                        self.parselegislationResponse(legislation_url_xpaths[url_index], ministryId)
                    
                        
                        
    def parselegislationResponse(self, legislation_url, ministryId): 
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
                        print("Số hiệu: "+str(legislation_sohieu))
                    elif (i == 2):
                        legislation_ngaybanhanh = legislation_response.xpath(row[i])
                        print("Ngày ban hành: "+str(legislation_ngaybanhanh))
                    elif (i == 3):                        
                        legislation_ngayhieuluc =  legislation_response.xpath(row[i])
                        print("Ngày hiệu lực: "+str(legislation_ngayhieuluc))
                    elif (i == 4):
                        legislation_ngayky = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Ngày ký: "+str(legislation_ngayky))
                    elif (i == 5):
                        legislation_trichyeu = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Trích yếu: "+str(legislation_trichyeu))
                    elif (i == 6):
                        legislation_coquanbanhanh = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Cơ quan ban hành: "+str(legislation_coquanbanhanh))
                    elif (i == 7):
                        legislation_nguoiky = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Người ký: "+str(legislation_nguoiky))
                    elif (i == 8):
                        legislation_loaivanban = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Loại văn bản: "+str(legislation_loaivanban))
                    elif (i == 9):
                        legislation_tinhtrang = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Tình trạng: "+str(legislation_tinhtrang))
                    elif (i == 10):
                        legislation_link = self.clearSpace(legislation_response.xpath(row[i]))
                        print("Link: "+str(legislation_link))
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
                
                    
    def covertStringFromlegislationToSqlFormat (self, dateString):
        #from 28/02/2021 to 2021/02/28
        dt = datetime.datetime.strptime(dateString, '%d/%m/%Y')
        return '{2}/{1:02}/{0:02}'.format(dt.day, dt.month, dt.year)
        

    def covertStringFromSqlTolegislationFormat (self, dateString):
        #from 2021/02/28 to 28/02/2021
        dt = datetime.datetime.strptime(dateString, '%Y/%m/%d')
        return '{0:02}/{1:02}/{2}'.format(dt.day, dt.month, dt.year)
    
    
    def savelegislationToDB(self, ministry_id,legislation_name,legislation_url,so_hieu_van_ban,ngay_ban_hanh,ngay_hieu_luc,ngay_ky,trich_yeu,co_quan_ban_hanh,nguoi_ky_loai_van_ban,tinh_trang,linh_download):        
        self.connectDB().execute(
                'INSERT INTO WebDB.dbo.legislation_info (ministry_id,legislation_name,legislation_url,so_hieu_van_ban,ngay_ban_hanh,ngay_hieu_luc,ngay_ky,trich_yeu,co_quan_ban_hanh,nguoi_ky_loai_van_ban,tinh_trang,linh_download)'
                'VALUES'
                '(ministry_id,legislation_name,legislation_url,so_hieu_van_ban,ngay_ban_hanh,ngay_hieu_luc,ngay_ky,trich_yeu,co_quan_ban_hanh,nguoi_ky_loai_van_ban,tinh_trang,linh_download)'
                )
        self.connectDB().commit()
                
        

p = MySpider()
p.getUrl()