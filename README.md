## Postgres Scripts for MLB AtBat / PitchFX / Statcast importing
Much of this code is based on Mike Fast's pitchfx database scripts (https://fastballs.wordpress.com/2007/08/23/how-to-build-a-pitch-database/) which was designed around MySQL databases. My revisions adapt the code for Postgres databases. I've made some modifications to improve import speeds, namely generating primary keys based on MLB's game_id rather than serially generating ids for GAMES, ATBATS, PITCHES tables.

I have added additional information regarding base runners and non-game play actions such as challenges and mound visits. They are now included in new tables (RUNNERS, ACTIONS).

Additionally, these scripts scrape and import MLB Statcast data (batted ball distance and velocities) in to a new table, STATCAST.

### pg_struct.sql
Table structures for database

### spider.pl
Scrape MLB AtBat and Statcast files

Use:

./spider.pl DD/MM/YYYY

Where DD/MM/YYYY is the begin date, the current date is the end date.

### pg_import.pl
Parse files and import it in to database
Dependencies: DBI, LWP, JSON, XML

Use:

./pg_import.pl -d day_dir -y year_dir

Where day_dir is a directory that contains individual game dirs (directories beginning with gid_)
year_dir is a directory that contains months and day directories. Ideally if you are just starting your database, and you've just scraped a large number of games, you will want to use the -y flag and do a bulk import. After that, you will want to use the -d flag to import a single day's worth of games. Alternatively, you can use the crontab script described below to automatically import games on a daily basis.

### drop_tables.sql
Drop all tables that pg_struct.sql created.

### cron
Crontab file to update database with yesterday's scores. Runs scrape_and_import.sh every day from April-October at 5am.
You may need to edit cron to specify the actual path of scrape_and_import.sh

Use:

crontab cron


