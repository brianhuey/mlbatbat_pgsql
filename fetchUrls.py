import os
from lxml import etree
import csv
directories = [x[0] for x in os.walk('/home/ec2-user/baseball/games/year_2015')]
url1 = 'http://statsapi.mlb.com/api/v1/game/'
url2 = '/feed/color'
urlList = []
for directory in directories:
    if directory.split('/')[-1][:3] == 'gid':
        path = directory
        if os.path.isfile(str(path + '/boxscore.xml')):
            boxscore = etree.parse(open(str(path + '/boxscore.xml')))
            game_pk = boxscore.xpath('@game_pk')[0]
            urlList.append([str(url1 + game_pk + url2)])

with open('urls.csv', 'w') as fp:
    a = csv.writer(fp, delimiter=',')
    a.writerows(urlList)

