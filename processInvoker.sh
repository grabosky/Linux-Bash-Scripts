#!/bin/bash
#Adam Grabowski
#2017-05-03
#Script to make sure a java process is always running
#Put it to crontab to check every 1 minute
#How it works: Check if java process is dead and if yes, invoke it again

process=java
makerun="/opt/bin/startDaemon.sh"

if ps ax | grep -v grep | grep $process > /dev/null
then
    exit
else
    $makerun &
fi

exit

