#!/bin/bash
#Description: Script to help managing groups ownership of files/folders. 
#Create New Group and New User or update ACL on a specific folder
#Date: 2020-01-28
#Author: Adam Grabowski 

echo "Do you want to create new user and group(1) or add new ACL permissions to existing folder(2)?"

read input

if [ $input = 1 ]; then

echo "Provide new group name:"
read groupa

#Create new group
sudo groupadd $groupa

echo "Provide new user name:"
read usera
echo "Provide new user password:"
read passwords

#Create new user
sudo useradd -m -s /bin/bash -d /home/$usera $usera; echo $usera:$passworda|chpasswd; chage -M 99999 $usera;

#Add user to group
sudo usermod -a -G $groupa $usera


elif [ $input = 2 ]; then

#Ask for folder path
echo "Provide full folder path to a folder of which ACL permissions you want to change:"
read folda

#Prohibid base permissions to be changed (set as default)
chmod 775 $folda -R
chmod -R g+s $folda

echo "Provide name of the group which should be added to folder's ACL:"
read groupb

echo "Provide new permissions (ie. rwx or r--):"
read permissionsa

#Set proper permissions to specific group on specific folder
sudo setfacl -R -m g:$groupb:$permissionsa $folda
sudo setfacl -Rd -m g:$groupb:$permissionsa $folda

fi

