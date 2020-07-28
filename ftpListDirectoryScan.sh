#!/bin/bash
#Adam Grabowski
#2016
#Bash script that reccursively connetcs to an IP list of FTP servers found in "serversList.txt" and saves an output of a default directory to a file named as recently scanned IPaddress.txt
#In other words this script can scrape list of files from a list of FTP servers 

for IPADDRESS in `cat /home/yourhomedir/ftpListDirectoryScan/serversList.txt`
do
   echo $IPADDRESS
   command curl ftp://$IPADDRESS/ --user anonymous:anonymous > /home/yourhomedir/ftpListDirectoryScan/scanned/$IPADDRESS.txt
done
