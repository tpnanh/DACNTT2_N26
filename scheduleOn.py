import schedule
import time
import datetime

def job():
	print("kko")

schedule.every().day.at("11:45").do(job)
while True:
    schedule.run_pending()
    time.sleep(1)