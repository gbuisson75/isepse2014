#!/bin/bash

# FTP folder to backup
source="/home/orthoeur/www/isep/FTP-bashproject"
# SQL database to backup
user="orthoeurscinfo"
password="waJPtbG2"
host="mysql51-31.bdb"
dbname="orthoeurscinfo"

# Destination
date=$(date +"%d-%m-%Y-%Hh%M")
allbackups="/home/orthoeur/www/isep/backups"
chmod -R 705 $allbackups
mkdir -m 705 $allbackups/backup-$date

# Name of the SQL backup file
sqldumpname=$dbname-$date


# Permissions
umask 177 # Owner only has access in reading and writing

# FTP backup script
rsync -arv $source $allbackups/backup-$date

# SQL backup script
# dump of the database including tables with prefix "aaa" only
# mysqldump -u $user -p waJPtbG2 --databases $(mysql -u $user -p waJPtbG2 -N $dbname -Bse "show tables like 'aaa'") > $allbackups/backup-$date/$sqldumpname.sql

#basic dump of the database including all tables
mysqldump --user=$user  --password=$password  --host=$host $dbname > $allbackups/backup-$date/$sqldumpname.sql

# Save the logs to a external file when executing the script
backup.sh &>logBackup.txt

