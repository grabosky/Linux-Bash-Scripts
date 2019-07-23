#!/bin/bash
#Adam Grabowski
#2019-05-01
#Bash script to automate copying file from local disk to remote FTP server and then renaming the file to cam.jpg using ncftp
#You need to have ncftp package installed
#Can be used for running in specific intervals using crontab
#It was scripted to work as file ftp upload script in addition to another .sh script which takes a snapshot from RaspberryPi camera


# Set current date and time into a String object in format (Year-month-day_Hour-Minute) 
DATE=$(date +"%Y-%m-%d_%H%M")


# Copy from local home dir to remote server logging in as username and password
ncftpput -t 30 -u user -p password ftp.address.com /public_html/ftpfolderpath/ /home/pi/camera/$DATE.jpg 2>&1 > /dev/null


# Wait for 1 second
sleep 1


# Log in again to FTP to rename file to generic cam.jpg name - helps with consistency naming for other scripts
ncftpls -u user -p password -W "RNFR /public_html/camera/$DATE.jpg" -W "RNTO /public_html/camera/cam.jpg" ftp://ftp.address.com 




