#!/bin/bash
#Script for closing a SOCKS5 tunnel
#Automates closing of local port (8125) in ufw firewall, then prints current SSH process ID (you still need to kill it manually though)
#Adam Grabowski
#2019-06-01

if sudo ufw deny 8125 && sudo ufw deny 8125/tcp ; then
    echo "Port 8125 SUCCESSFULLY CLOSED on server side."
else
    echo "Port 8125 FAILED to CLOSE on server side."
fi
ps aux |grep ssh
echo "Find PID of the Tunnel process and type sudo kill number"


