#!/bin/bash

#Script to create New User, Group, both or ACL on a specific folder

{

createGroup () {
echo "Provide new group name:"
read groupa
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Starting creating group: $groupa"
#Create new group
sudo groupadd $groupa && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Successfully created group: $groupa !" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Creating group: $groupa FAILED!" ; exit 1
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Finished creating group: $groupa"
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Log from this operation can be viewed in script.log"
}




createUser () {
echo "Provide new user name:"
read usera
echo "Provide new user password:"
read passworda
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Starting creating new user: $usera"
#Create new user
sudo useradd -m -s /bin/bash -d /home/$usera $usera && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Successfully created user: $usera !" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Creating user: $usera FAILED!" ; exit 1
echo $usera:$passworda|chpasswd && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Successfully updated user's: $usera password!" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Updating user's: $usera password FAILED!" ; exit 1
sudo chage -M 99999 $usera && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Successfully updated user's: $usera password termination policy!" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Updating user's: $usera password termination policy FAILED!" ; exit 1
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Creating new user: $usera finished"
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Log from this operation can be viewed in script.log"
}




createUserAndGroup () {
echo "Provide new group name:"
read groupc
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Starting creating group: $groupc"
#Create new group
sudo groupadd $groupc && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Successfully created group: $groupc !" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Creating group: $groupc FAILED!"
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Finished creating group: $groupc"

echo "Provide new user name:"
read userc
echo "Provide new user password:"
read passwordc
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Starting creating new user: $userc"
#Create new user
sudo useradd -m -s /bin/bash -d /home/$userc $userc && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Successfully created user: $userc !" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Creating user: $userc FAILED!"
echo $userc:$passwordc|chpasswd && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Successfully updated user's: $userc password!" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Updating user's: $userc password FAILED!"
sudo chage -M 99999 $userc && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Successfully updated user's: $userc password termination policy!" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Updating user's: $userc password termination policy FAILED!"
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Creating new user: $userc finished"

echo "$(date "+%Y-%m-%d-%H_%M_%S") : Starting adding new user: $userc to group: $groupc"
#Add user to group
sudo usermod -a -G $groupc $userc && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Successfully added: $userc to group: $groupc !" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Adding user: $userc to group: $groupc FAILED!"
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Finished adding new user: $userc to group: $groupc"
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Log from this operation can be viewed in script.log"
}




createACL () {
#Ask for folder path
echo "Provide full folder path to a folder of which ACL permissions you want to change:"
read folda
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Starting setting base and default permissions"
#Prohibid base permissions to be changed in the future
chmod 775 $folda -R  && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Base permissions set on folder successfully!" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Setting base permissions on a folder FAILED!"
chmod -R g+s $folda && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Group's base permissions set on folder successfully!" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Group's base permissions set on folder FAILED!"
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Setting base and default permissions finished"
echo "Provide name of the group which should be added to folder's ACL:"
read groupb
echo "$(date "+%Y-%m-%d-%H_%M_%S") : You are adding: $groupb to folder's ACL" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : FAILED!"
echo "Provide new permissions for ACL (ie. rwx or r--):"
read permissionsa
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Starting setting ACLs with permissions: $permissionsa"
#Set proper permissions to specific group on specific folder
sudo setfacl -R -m g:$groupb:$permissionsa $folda && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Setting ACL successfull!" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Setting ACL FAILED!"
sudo setfacl -Rd -m g:$groupb:$permissionsa $folda && echo "$(date "+%Y-%m-%d-%H_%M_%S") : Setting defaults for ACL successfull!" || echo "$(date "+%Y-%m-%d-%H_%M_%S") : Setting defaults for ACL FAILED!"
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Setting ACLs finished"
echo "$(date "+%Y-%m-%d-%H_%M_%S") : Log from this operation can be viewed in script.log"
}




echo "Do you want to create: \n     (1) New Group\n     (2) New User\n     (3) New Group and User\n     (4) Add New ACL Permissions To Existing Folder \nEnter number to select:"
read input

if [ $input = 1 ]; then
createGroup
elif [ $input = 2 ]; then
createUser
elif [ $input = 3 ]; then
createUserAndGroup
elif [ $input = 4 ]; then
createACL
else echo "This is invalid selection! Exiting..."
fi



} 2>&1 | tee script.log
