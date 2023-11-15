from bs4 import BeautifulSoup

with open ('home.html', 'r') as htmlFile: 
    content = htmlFile.read()
    print(content)
