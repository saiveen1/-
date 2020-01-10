from lxml import etree

def getxpath(html):
		return etree.HTML(html)
sample1 = """<html>
	<head>
		<title>My page</title>
	</head>
	<body>
		<h2>Welcome to my <a href="#" src="x">page</a></h2>
		<p>This is the first paragraph.</p>
		<!-- this is the end -->
	</body>
</html>
"""
# 获取xml结构
s1 = getxpath(sample1)

#获取标题 用text() 注释用comment()
print(s1.xpath('//title/text()'))
print(s1.xpath('/html/head/title/text()'))

print(s1.xpath('////a/@src'))

#获取a下的href  value src都用@
print(s1.xpath('//a/@href'))

#获取所有href
print(s1.xpath('//@href'))
