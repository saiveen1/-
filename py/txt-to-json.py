import json
dict = {}

# 打开文本文件
file = open('/Users/saiveen/Documents/豆瓣爬虫/py/test-txt/switch-dic-test.txt','r')

# 遍历文本文件的每一行，strip可以移除字符串头尾指定的字 indent控制输出缩进
for line in file.readlines():
	line = line.strip()
	k = line.split(':')[0]
	v = line.split(': ')[1]
	dict[k] = v
print(json.dumps(dict,indent = 4))  

##换行按格式输出
#for key,value in dict.items():
#	print('	"{key}","{value}"'.format(key = key, value = value))

file.close()

