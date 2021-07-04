from scrapy import Spider
from scrapy.selector import Selector

class BCASpider(Spider):
    name = "crawl_bo_cong_an"
    start_urls = ['http://bocongan.gov.vn/tin-tuc-su-kien/xay-dung-luc-luong-cong-an-hai-duong-dap-ung-yeu-cau-nhiem-vu-duoc-giao-t29741.html']

    def parse(self, response):
        c = len(response.xpath('//div[@class="ExternalClassC7390833FF6E46508943B920E41F402A"]/p'))
        print("Content: ")
        for i in range(0, c-4):
          print(response.xpath('//div[@class="ExternalClassC7390833FF6E46508943B920E41F402A"]/p/text()').extract()[i].strip())