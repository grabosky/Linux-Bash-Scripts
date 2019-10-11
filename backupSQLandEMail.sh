#!/bin/bash
#Backups mysql dump + sends it by e-mail
#Requirement: mutt installed
#Author: Adam Grabowski 
#Date: 2019-10-7

{
    _now=$(date +"%Y-%m-%d-%H_%M_%S")
    _file="backup_01_$_now.sql.gz"

    echo "$(date "+%Y-%m-%d-%H_%M_%S") : Starting work"
    sudo mysqldump -u DBUSERNAME -pPASSWORD dbname_01 | gzip > /home/user/backups/backup_01_$_now.sql.gz
    echo "MySQL Backup for Domain" | sudo mutt -a "/home/user/backups/"$_file -s "Backup SQL - "$_now -- emailaddress@gmail.com
    echo "$(date "+%Y-%m-%d-%H_%M_%S") : Done"

} 2>&1 | tee errors.log



