# Postgres Scripts for MLB AtBat / PitchFX / Statcast importing
Much of this code is based on Mike Fast's pitchfx database scripts (https://fastballs.wordpress.com/2007/08/23/how-to-build-a-pitch-database/) which was designed around MySQL databases. My revisions adapt the code for Postgres databases. I've made some modifications to improve import speeds, namely generating primary keys based on MLB's game_id rather than serially generating ids for GAMES, ATBATS, PITCHES tables.

I have added additional information regarding base runners and non-game play actions such as challenges and mound visits. They are now included in new tables (RUNNERS, ACTIONS).

Additionally, these scripts scrape and import MLB Statcast data (batted ball distance and velocities) in to a new table, STATCAST.

## pg_struct.sql
Table structures for database

## spider.pl
Scrape MLB AtBat and Statcast files

## pg_import.pl
Dependencies: DBI, LWP, JSON, XML

Parse files and import in to database

## drop_tables.sql
Drop all tables that pg_struct.sql created.