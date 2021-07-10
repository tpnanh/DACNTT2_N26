
# Create your views here.
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.db import connection
import pyodbc
from django.template.defaulttags import register
from django.core.paginator import Paginator
from django.shortcuts import render
import math
import sys
from pyspark.sql import SparkSession
import pandas as pd
import pyodbc
from pyspark.sql.types import StructType,StructField, StringType
import numpy as np

import findspark
findspark.init("C:\\Users\\ASUS\\AppData\\Local\\Programs\\Python\\Python39\\spark\\spark-3.0.3-bin-hadoop2.7")

sys.setrecursionlimit(2000)

spark = None

def displayOnWeb(request,table,isSearch):
    response = []
    subResponse = []
    resultList = []

    count = 0    

    if (len(table) != 0):
        for i in range(0,len(table)-1):
            subResponse.append(table[i])        
            resultList.append(table[i])
            count += 1  
            if (count == 10):
                count = 0
                response.append(subResponse)            
                subResponse = []
            if (len(table)<10):
                response.append(subResponse)  

        subResponse.append(table[len(table)-1])
        resultList.append(table[len(table)-1])
        response.append(subResponse)

        article = {}

        # if (isSearch == False):
        #     for i in range (0, len(response)):
        #         article['item ' + str (i)] = response[i]
        # else:         
        for i in range (0, len(response)):
            article['item ' + str (i)] = response[i]

        page = request.GET.get('page', 1)
        paginator = Paginator(resultList, 10)
        contacts = paginator.page(page)
    else:
        article = {}
        contacts = {}

    return article, contacts


def index(request):
    # getArticleUrl()
    global spark
    if(spark is None):
        spark = SparkSession.builder.appName("PySpark").getOrCreate()

    article_table = showArticleData()

    result = displayOnWeb(request,article_table,False)

    article = result[0]
    contacts = result[1]

    content = {'article' : article, 'contacts': contacts}
    return render (request, 'index.html', content)


def index_legislation(request):
    global spark
    if(spark is None):        
        spark = SparkSession.builder.appName("PySpark").getOrCreate()

    #legislation
    legislation_table = showLegislationData()
    result = displayOnWeb(request,legislation_table,False)

    legislation = result[0]
    legislationContacts = result[1]    

    content = {'legislation':legislation, 'legislationContacts':legislationContacts}
    return render (request, 'index.html', content)

def getArticle(request):
    articleId = request.GET.get('id')
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')    
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM article_info where article_id = $ ''' + str(articleId))
    item = cursor.fetchone()
    contents = {'item' : item}
    return render (request, 'article.html', contents)


def getLegislation(request):
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')    
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM legislation_info where legislation_id = $ ''' + str(legislationId))
    item = cursor.fetchone()
    contents = {'item' : item}
    return render (request, 'legislation.html', contents)


def getSearchingResult(request):
    global spark
    if(spark is None):
        spark = SparkSession.builder.appName("PySpark").getOrCreate()

    keyword = request.GET.get('find')
    listResult = findKeyword(keyword)    

    result = displayOnWeb(request,listResult,True)

    searchResult = result[0]     
    searchContacts = result[1] 

    results = {'searchResult' : searchResult, 'searchContacts' : searchContacts}
    return render (request, 'index.html', results)

def getSearchingLegislationResult(request):
    global spark
    if(spark is None):
        spark = SparkSession.builder.appName("PySpark").getOrCreate()

    keyword = request.GET.get('find')
    listResult = findLegislationKeyword(keyword)    

    result = displayOnWeb(request,listResult,True)

    searchLegislationResult = result[0]     
    searchLegislationContacts = result[1] 

    results = {'searchLegislationResult' : searchLegislationResult, 'searchLegislationContacts' : searchLegislationContacts}
    return render (request, 'index.html', results)

def getFilterResult(request):
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')    
    cursor = conn.cursor()

    newsType = request.GET.get('type')
    keyword = request.GET.get('filter')

    keyword = keyword.split(",")

    result = []
    items = []

    if (newsType in 'article'):
        for i in keyword:
            cursor.execute('''SELECT * from article_info, ministry_info 
                where article_info.ministry_id = ministry_info.ministry_id
                and ministry_info.ministry_name like N'%'''+i+'''' 
                ''')
            item = cursor.fetchall()
            if (len(item) > 0):
                items.append(item)                         
    else:
        for i in keyword:
            result.append(cursor.execute('''SELECT * from legislation_info, ministry_info 
                where legislation_info.ministry_id = ministry_info.ministry_id 
                and ministry_info.ministry_name like N'%i%' '''))

    if (items != []):
        result = displayOnWeb(request,np.array(items[0]).tolist(),True)
        filterResult = result[0]   
        filterContacts = result[1]
    else:
        filterResult = {}  
        filterContacts = {}

    results = {'filterResult' : filterResult, 'filterContacts' : filterContacts}
    return render (request, 'index.html', results)

def getFilterLegislationResult(request):
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')    
    cursor = conn.cursor()

    newsType = request.GET.get('type')
    keyword = request.GET.get('filter')

    keyword = keyword.split(",")

    result = []
    items = []

    for i in keyword:
        cursor.execute('''SELECT * from legislation_info, ministry_info 
            where legislation_info.ministry_id = ministry_info.ministry_id
            and ministry_info.ministry_name like N'%'''+i+'''' 
            ''')
        item = cursor.fetchall()
        if (len(item) > 0):
            items.append(item)

    if (items != []):
        result = displayOnWeb(request,np.array(items[0]).tolist(),True)
        filterLegislationResult = result[0]   
        filterLegislationContacts = result[1]
    else:
        filterLegislationResult = {}  
        filterLegislationContacts = {}

    results = {'filterLegislationResult' : filterLegislationResult, 'filterLegislationContacts' : filterLegislationContacts}
    return render (request, 'index.html', results)

   
def showArticleData():
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')    
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM article_info order by article_time desc''')
    row = cursor.fetchall()
    return row


def showLegislationData():
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')    
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM legislation_info''')
    row = cursor.fetchall()
    return row 

def connectDB():    
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=ANISE-TR\SQLEXPRESS;'
                      'Database=WebDB;'
                      'Trusted_Connection=yes;')    
    cursor = conn.cursor()
    return cursor
    
    
def covertStringToResponse(url):
    response = requests.get(url)            
    doc = html.fromstring(response.text)
    return doc

def getArticleUrl():
        category_page_info = connectDB().execute('select ministry_id,category_link_root, article_category_id from article_category_info where ministry_id = 1')
        for row in category_page_info:   
            page_param_info = connectDB().execute('select page_rule,article_param_xpath,article_url_xpath from ministry_article_category_configuration where ministry_id = $'+str(row[0])+' and article_category_type_id = $'+str(row[2]) )        
            for page_info in page_param_info:   
                #if there's no get param link
                if (page_info[1]==""):
                    try:
                        list_baiviet = crawlBySelenium(row[1],page_info[2], row[0])
                    except RequestException as e:
                        print(e)
                        
                    try:
                        for baiviet in list_baiviet:
                            parseresponse(baiviet, row[0])
                    except RequestException as e:
                        print(e)
                else: 
                    #get url with param  
                    url = covertStringToResponse(row[1]).xpath(page_info[1])
                                     
                    if (row[0]==7):    
                        param = int(url[len(url)-1])
                    elif (row[0]==14):
                        param = getMicParam(str(url[len(url)-1]))  
                    elif (row[0]==24):
                        param = getVassParam(str(url[len(url)-1]))  
                    else:
                        param = getParam(str(url[len(url)-1]))
                    for i in range (1,1+1): 
                        ##ministry 6, 11 doesn't use param
                        if (row[0]==6 or row[0]==11 or row[0]==16 or row[0]==19 or row[0] == 21):
                            articleUrl = row[1]                        
                        else:
                            ##ministry 8, 14 need to be removed default last param before crawl by param
                            if (row[0]==8 or row[0]==24):
                                row[1] = row[1][:-1]                            
                            if (row[0]==14):
                                startPoint = getMicStartpoint(str(url))
                                endPoint = getMicEndpoint(str(url))
                                articleUrl = startPoint + str(i) + endPoint
                                articleUrl = "https://www.mic.gov.vn"+articleUrl[2:-2]       
                            else: 
                                articleUrl = row[1]+str(i) 
                    parseArticleCategoryResponse(covertStringToResponse(articleUrl), row[0])                    
                    i += page_info[0]

    
def parseArticleCategoryResponse(response, ministryId): 
    category_detail = connectDB().execute(' select ministry_id,article_url_xpath,article_thumbnail_xpath from ministry_article_category_configuration where ministry_id = $'+str(ministryId))
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
                    parseresponse(article_url_xpaths[url_index], ministryId)                    
                    
                    
def parseresponse( article_url, ministryId): 
    article_response = covertStringToResponse(article_url)
    article_detail = connectDB().execute('select article_title_xpath,article_description_xpath,article_time_xpath,article_author_xpath,article_content_xpath from ministry_article_detail_configuration where ministry_id = $'+str(ministryId))
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
                        article_content = clearSpace(article_response.xpath(row[i]))
                        if (ministryId==11):
                            article_content = article_content[2:]
                        print("Content: "+str(article_content))
        saveArticleToDb(ministryId,article_url, article_title,article_description,article_time,article_author,article_content)
        print("\n -----------------")
        # print("\n -----------------")

def getLegislationUrl(self):
    legislation_page_info = connectDB().execute('select ministry_id,legislation_link_root, legislation_category_id from legislation_category_info where ministry_id = 1') 
    
    for row in legislation_page_info:   
        page_param_info = connectDB().execute('select page_rule, legislation_param_xpath,ministry_id from ministry_legislation_category_configuration where ministry_id = $'+str(row[0]))
        
        for page_info in page_param_info:    
            #if there's no get param link
            if (page_info[1]==""):
                print
            else:
                #get url with param
                url = covertStringToResponse(row[1]).xpath(page_info[1])
                #print(str(url))
                if (row[0]==2 or row[0]==12 or row[0]==8 or row[0]==13 or row[0]==11 or row[0]==14 or row[0]==21 or row[0]==22):
                    param = 0
                else:
                    param = getParam(str(url[len(url)-1]))
                    print(param)
            
            for i in range (2,5): 
                ##ministries don't use param
                if (row[0]==5 or row[0]==2 or row[0]==13 or row[0]==6 or row[0]==7 or row[0]==4 or row[0]==12 or row[0]==14 or row[0]==16 or row[0]==19 or row[0]==21 or row[0]==22):
                    legislationUrl = row[1]
                    parseLegislationCategoryResponse(covertStringToResponse(legislationUrl), row[0])
                else:                         
                    legislationUrl = row[1]+str(i) 
                parseLegislationCategoryResponse(covertStringToResponse(legislationUrl), row[0])                    
                i += page_info[0]


def parseLegislationCategoryResponse( response, ministryId): 
    category_detail = connectDB().execute('select ministry_id, legislation_url_xpath from ministry_legislation_category_configuration where ministry_id = $'+str(ministryId))
    for row in category_detail:            
        for i in range (len(row)):
            ## i = 1 for legislation url to save legislation to DB                
            if (i == 1):                       
                legislation_url_xpaths = response.xpath(row[i])
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
                    ##bo congthuong
                    elif (ministryId == 2):
                        legislation_url_xpaths[url_index] = "http://www.moit.gov.vn"+str(legislation_url_xpaths[url_index])  #Failed to establish a new connection: [Errno 11001] getaddrinfo failed')
                    ##bo gtvt
                    elif (ministryId == 5):
                        legislation_url_xpaths[url_index] = "https://mt.gov.vn"+str(legislation_url_xpaths[url_index]) #Failed to establish a new connection: [Errno 11001] getaddrinfo failed
                    ##bo ldtbxh
                    elif (ministryId == 6):                            
                        legislation_url_xpaths[url_index] = "http://www.mpi.gov.vn"+str(legislation_url_xpaths[url_index]) #Failed to establish a new connection: [Errno 11001] getaddrinfo failed
                    #bo khcn
                    elif (ministryId == 7):                            
                        legislation_url_xpaths[url_index] = "http://www.most.gov.vn"+str(legislation_url_xpaths[url_index]) #Failed to establish a new connection: [Errno 11001] getaddrinfo failed
                    ##bo ldtbxh
                    elif (ministryId == 8):                            
                        legislation_url_xpaths[url_index] = "http://www.molisa.gov.vn"+str(legislation_url_xpaths[url_index]) #done                        
                    ##bo quoc phong
                    elif (ministryId == 11):
                        url_quocphong = str(legislation_url_xpaths[url_index])                            
                        legislation_url_xpaths[url_index] = "http://www.mod.gov.vn"+ url_quocphong[:-32] + str(legislation_url_xpaths[url_index]) #crawl được xíu thì Failed to establish a new connection: [Errno 11001] getaddrinfo failed'))
                    ##bo 
                    elif (ministryId == 12):                            
                        legislation_url_xpaths[url_index] = "https://www.mof.gov.vn"+str(legislation_url_xpaths[url_index]) #cannot get xpath
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
                    ##uy ban dan toc
                    elif (ministryId == 20):
                        legislation_url_xpaths[url_index] = "http://csdl.ubdt.gov.vn"+str(legislation_url_xpaths[url_index]) #done
                    ##ngan hang nnvn
                    elif (ministryId == 21):
                        legislation_url_xpaths[url_index] = "http://vbpl.vn/nganhangnhanuoc/Pages/vbpq-thuoctinh.aspx?dvid=326&" + str(legislation_url_xpaths[url_index])[-22:-9] + "&Keyword="  #done
                    ##bo y te
                    elif (ministryId == 23):
                        legislation_url_xpaths[url_index] = "https://baohiemxahoi.gov.vn"+str(legislation_url_xpaths[url_index])
                    ##uy ban quan ly von dau tu
                    elif (ministryId == 26):
                        if(str(legislation_url_xpaths[url_index]).startswith("/doc")):
                            continue
                        legislation_url_xpaths[url_index] = str(legislation_url_xpaths[url_index])  #done - cannot get xpath of link download yet

                    parseLegislationResponse(legislation_url_xpaths[url_index], ministryId)                    
                    
                    
def parseLegislationResponse( legislation_url, ministryId): 
    legislation_response = covertStringToResponse(legislation_url)
    legislation_detail = connectDB().execute('select legislation_name_xpath, legislation_so_hieu_van_ban_xpath, legislation_ngay_ban_hanh_xpath, legislation_ngay_hieu_luc_xpath, legislation_trich_yeu_xpath, legislation_co_quan_ban_hanh_xpath, legislation_nguoi_ky_xpath, legislation_loai_van_ban_xpath, legislation_tinh_trang_xpath, legislation_link_download_xpath from ministry_legislation_detail_configuration where ministry_id = $'+str(ministryId))
    for row in legislation_detail:
        legislation_name = ""
        legislation_sohieu = ""
        legislation_ngaybanhanh = ""
        legislation_ngayhieuluc = ""
        legislation_trichyeu = ""
        legislation_coquanbanhanh = ""
        legislation_nguoiky = ""
        legislation_loaivanban = ""
        legislation_tinhtrang = ""
        legislation_link = ""
        if (legislation_response.xpath(row[0]) == []):
            break
        else:
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
                        print("Ngày ban hành: "+str(clearSpace(legislation_ngaybanhanh)))
                    elif (i == 3):                        
                        legislation_ngayhieuluc =  legislation_response.xpath(row[i])
                        print("Ngày hiệu lực: "+str(legislation_ngayhieuluc))
                    elif (i == 4):
                        legislation_trichyeu = clearSpace(legislation_response.xpath(row[i]))
                        print("Trích yếu: "+str(legislation_trichyeu))
                    elif (i == 5):
                        legislation_coquanbanhanh = clearSpace(legislation_response.xpath(row[i]))
                        print("Cơ quan ban hành: "+str(legislation_coquanbanhanh))
                    elif (i == 6):
                        legislation_nguoiky = clearSpace(legislation_response.xpath(row[i]))
                        print("Người ký: "+str(legislation_nguoiky))
                    elif (i == 7):
                        legislation_loaivanban = clearSpace(legislation_response.xpath(row[i]))
                        print("Loại văn bản: "+str(legislation_loaivanban))
                    elif (i == 8):
                        legislation_tinhtrang = clearSpace(legislation_response.xpath(row[i]))
                        print("Tình trạng: "+str(legislation_tinhtrang))
                    elif (i == 9):
                        legislation_link = clearSpace(legislation_response.xpath(row[i]))
                        print("Link: "+str(legislation_link))
        saveLegislationToDb(ministryId, legislation_url, legislation_name, legislation_sohieu,legislation_ngaybanhanh,legislation_ngayhieuluc, legislation_trichyeu, legislation_coquanbanhanh, legislation_nguoiky, legislation_loaivanban, legislation_tinhtrang, legislation_link)
        print("\n")


def getParam( param_url):
    param = ""
    for i in range(len(param_url),0,-1):
        if (param_url[i-1] != "="):
            param += param_url[i-1]
        else:
            return int(param[::-1])
        
def getMicParam( param_url):
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
            
def getMicEndpoint( param_url):
    param = ""
    for i in range(len(param_url),0,-1):
        if (param_url[i-1] != "/"):
            param += param_url[i-1]
        else:
            return '/'+str(param[::-1])

def getMicStartpoint( param_url):
    param = ""
    count = 0
    for i in range(len(param_url),0,-1):
        if (param_url[i-1] != "/"):
            if (count == 2):
                param = str(param_url[:i+1])
                return param
        else: 
            count += 1 
            
def getVassParam( param_url):
    param = ""
    for i in range(len(param_url),0,-1):
        if (param_url[i-1] != "."):
            param += param_url[i-1]
        else:
            return int(param[::-1])
            
        
def clearSpace( listString):
    return [string for string in listString if string != ' ']
            
                
def covertStringFromArticleToSqlFormat ( dateString):
    #from 28/02/2021 to 2021/02/28
    dt = datetime.datetime.strptime(dateString, '%d/%m/%Y')
    return '{2}/{1:02}/{0:02}'.format(dt.day, dt.month, dt.year)
    

def covertStringFromSqlToArticleFormat (dateString):
    #from 2021/02/28 to 28/02/2021
    dt = datetime.datetime.strptime(dateString, '%Y/%m/%d')
    return '{0:02}/{1:02}/{2}'.format(dt.day, dt.month, dt.year)


def saveArticleToDb( ministry_id, article_url, article_title,article_description,article_time,article_author, article_content):   
    try:
        conn = pyodbc.connect('Driver={SQL Server};'
                          'Server=ANISE-TR\SQLEXPRESS;'
                          'Database=WebDB;'
                          'Trusted_Connection=yes;')  
        value =  [(ministry_id, article_url, article_title[0],article_description[0],article_time[0],article_author[0], article_content[0])]
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
        
def saveLegislationToDb( ministry_id, legislation_url, legislation_name, so_hieu_van_ban,ngay_ban_hanh,ngay_hieu_luc, trich_yeu, co_quan_ban_hanh, nguoi_ky, loai_van_ban, tinh_trang, link_download):   
    try:            
        conn = pyodbc.connect('Driver={SQL Server};'
                          'Server=ANISE-TR\SQLEXPRESS;'
                          'Database=WebDB;'
                          'Trusted_Connection=yes;')  
        value =  [(ministry_id, legislation_url, legislation_name[0],so_hieu_van_ban[0],ngay_ban_hanh[0],returnNullData(ngay_hieu_luc), returnNullData(trich_yeu), co_quan_ban_hanh[0], nguoi_ky[0], loai_van_ban[0], returnNullData(tinh_trang), returnNullData(link_download))]
        
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
    
def select(self):
    article = connectDB().execute('select * from legislation_info ')
    for row in article:
        print("Row: "+str(row))
        
def returnNullData( data):
    if (data == ""):
        return ""
    else:
        return data[0]            
        
def read_config(self):
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--headless')
    driver = webdriver.Chrome('chromedriver', options=chrome_options)
    return driver
        
def crawlBySelenium( categoryUrl, detailUrlXpath, ministryId):
    driver = read_config()
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

                parseresponse(url, ministryId)                
            
            list_baiviet.extend(tmp)#thêm vào tập link 
        except Exception as e:#gặp sự cố dừng
            print(e)
            break            
    return list_baiviet      

def findKeyword(keyword):   
    resultList = connectDB().execute("SELECT * FROM article_info")
    articleRow = [ row for row in resultList ]
    articleData = np.array(articleRow)
    articleDF = pd.DataFrame(articleData)

    articleSchema = StructType([    
        StructField("Id",StringType(),True), 
        StructField("Ministry",StringType(),True), 
        StructField("Url", StringType(), True), 
        StructField("Title", StringType(), True), 
        StructField("Description", StringType(), True), 
        StructField("Time", StringType(), True),
        StructField("Author",StringType(),True), 
        StructField("Content",StringType(),True), 
        StructField("Thumbnail", StringType(), True)
    ])    

    sparkArticleDF = spark.createDataFrame(data = articleDF, schema = articleSchema)
    listArticleResult = sparkArticleDF.filter("Content like '% "+str(keyword)+" %'").collect()

    output=[i[0:len(i)] for i in listArticleResult]

    # output = []
    # for i in resultList:
    #     if (" "+str(keyword)+" " in i[7]):
    #         output.append(i)

    # print("output: "+str(len(output)))
    return output

def findLegislationKeyword(keyword):  
    legislationList = connectDB().execute("SELECT * FROM legislation_info")    
    legislationRow = [ row for row in legislationList ]    
    legislationData = np.array(legislationRow)  
    legislationDF = pd.DataFrame(legislationData)

    legislationSchema = StructType([    
        StructField("Id",StringType(),True), 
        StructField("Ministry",StringType(),True), 
        StructField("Name", StringType(), True), 
        StructField("Url", StringType(), True), 
        StructField("So hieu van ban", StringType(), True), 
        StructField("Ngay ban hanh", StringType(), True),
        StructField("Ngay hieu luc",StringType(),True), 
        StructField("Trich yeu",StringType(),True), 
        StructField("Co quan ban hanh", StringType(), True),
        StructField("Nguoi ky", StringType(), True),
        StructField("Loai van ban",StringType(),True), 
        StructField("Tinh trang",StringType(),True), 
        StructField("Link download", StringType(), True)
    ])

    sparkLegislationDF = spark.createDataFrame(data = legislationDF, schema = legislationSchema)
    listLegislationResult = sparkLegislationDF.filter("Name like '% "+str(keyword)+" %'").collect()

    output=[i[0:len(i)] for i in listLegislationResult]
    return output