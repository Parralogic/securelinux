#!/bin/bash
#Creator: David Parra-Sandoval
#Date: 09/29/2023
#Last Modified: 10/14/2023
clear

echo "Select My Idea of, Linux Security!"
select OPTION in SECURE UNSECURE; do
case $OPTION in
SECURE)
if [[ $UID = 0 ]]; then
echo "running as root!!"
echo "only run this selection as sudo user!"
exit 1
fi
whoami > MySystemIsSECURED  
THEUSER=`whoami`
SUPERUSER=$(sudo cat /etc/sudoers | grep "%wheel ALL=(ALL:ALL) ALL")
REPLACE="# %wheel ALL=(ALL:ALL) ALL"
sudo chmod 000 /usr/bin/systemsettings
chmod 400 /home/$THEUSER/.bashrc
sudo sed -i "s/$SUPERUSER/$REPLACE/" /etc/sudoers
break
;;
UNSECURE)
if [[ $UID != 0 ]]; then
echo "not root!"
exit 1
fi
until [[ $REPLY = [yY]* ]]; do
echo "Select User to Unsecure!"
select UUSER in $(ls /home); do
USERTOUNSECURE=$UUSER
read -p "UNSECURE $USERTOUNSECURE?[y/n] "
case $REPLY in
y|Y|Yes|YES) echo OK!; break
;;
n|N|No|NO) echo re-select!
;;
esac
done
done
SUPERUSER=$(cat /etc/sudoers | grep "%wheel ALL=(ALL:ALL) ALL")
REPLACE=" %wheel ALL=(ALL:ALL) ALL"
sed -i "s/$SUPERUSER/$REPLACE/" /etc/sudoers
chmod 755 /usr/bin/systemsettings
chmod 644 /home/$USERTOUNSECURE/.bashrc
break
;;
esac
done

if [[ $OPTION = SECURE ]]; then
echo "sudo privileges removed/onhold till UNSECURE is selected!"
echo "systemsettings unavailable/unexecutable!"
echo "your bashrc file is only readable!"
echo "REMEMBER! run this script as root not sudo to UNSECURE it!"
echo "SYSTEM SECURED" >> /home/$THEUSER/MySystemIsSECURED
xmessage -nearmouse "SystemSecured! to Unsecure run su in terminal, you need the root password then execute secure.sh" 2> /dev/null  
else
echo "sudo privileges active/not-onhold!"
echo "systemsettings available/executable!"
echo "your bashrc file readable and writable!" 
rm /home/$USERTOUNSECURE/MySystemIsSECURED &> /dev/null
fi

