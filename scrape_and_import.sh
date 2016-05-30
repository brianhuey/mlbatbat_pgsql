#!/bin/bash
yesterday=`TZ='America/Los_Angeles' date --date='yesterday' "+%d/%m/%Y"`
day=${yesterday:0:2}
month=${yesterday:3:2}
year=${yesterday:6:4}
./spider.pl $yesterday
echo "/games/year_$year/month_$month/day_$day"
./pg_import.pl -d ./games/year_$year/month_$month/day_$day
