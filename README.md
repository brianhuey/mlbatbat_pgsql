# Postgres Scripts for MLB AtBat / PitchFX / Statcast importing

## pg_struct.sql
Table structures for database

## spider.pl
Scrape MLB AtBat and Statcast files

## pg_import.pl
Dependencies: DBI, LWP, JSON, XML
Parse files and import in to database