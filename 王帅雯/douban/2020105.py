# -*- coding: utf-8 -*-
import requests
import xlrd
import json
import csv

from lxml import etree

csvfile = open('/Users/saiveen/Documents/豆瓣爬虫/豆瓣爬虫/20105/comment.csv', 'w')
writer = csv.writer(csvfile)

writer.writerow(["date", "user_id", "comment", "rating"])

headers = {
	'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36'
}

proxies = {'http': '223.242.247.12:9999'}

url = "https://movie.douban.com/subject/30329892/comments?start={}&limit=20&sort=new_score&status=P".format(20)

r = requests.get(url, headers=headers, proxies=proxies)

content = r.content

page = etree.HTML(content)

tot = page.xpath('//*[@id="comments"]//div[2]')

if tot != []:
	for row in tot:
		# 会多出一个空白用户 原因未知
		if "".join(row.xpath('./h3/span[2]/a/@href')) == '':
			pass
		else:

			user_id = ("".join(row.xpath('./h3/span[2]/a/@href'))).split('/')[4]

			date = "".join(row.xpath('./h3/span[2]/span[3]/text()')).strip()

			rating = "".join(row.xpath('./h3/span[2]/span[2]/@class'))
			# 未评分 后面有个空格下次直接复制
			if rating == "comment-time ":
				rating = "用户未评分"
			else:
				rating = int(("".join(row.xpath('./h3/span[2]/span[2]/@class'))).split('r')[1]) / 10

			comment = "".join(row.xpath('./p/span/text()')).strip()
			#				print(len(user_id))
			#				print(user_id)
			#				for i in range(0, len(rating)):
			#					rating[i] = int(rating[i].split('r')[1]) / 10

			writer.writerow([date, user_id, comment, rating])
else:
	print('end')
