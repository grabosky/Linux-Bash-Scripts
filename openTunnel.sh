#!/bin/bash
#Script for opening a SOCKS5 tunnel
#Automates opening of local port (8125) and starts listening for tunnel connection, then prints current SSH processes 
#(to verify it is working)
#Adam Grabowski
#2019-06-01

#Open local ports 
if sudo ufw allow 8125 && sudo ufw allow 8125/tcp ; then
    echo "Port 8125 SUCCESSFULLY opened on server side."
else
    echo "Port 8125 FAILED to open on server side."
fi

#Open SSH listening for upcoming SOCKS5 connection through 8125 port
if sudo ssh -D 8125 -fCqN user@hostname.com ; then
    echo "Tunnel SUCCESSFULLY opened on server side. "
else
    echo "Tunnel FAILED to open on server side."
fi

#Show current open connections
ps -aux | grep ssh


