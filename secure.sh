#!/bin/bash
#Creator: David Parra-Sandoval
#Date: 09/29/2023
#Last Modified: 04/08/2024
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

if [[ $XDG_SESSION_DESKTOP = KDE ]]; then
SUPERUSER=$(sudo cat /etc/sudoers | grep "%wheel ALL=(ALL:ALL) ALL")
elif [[$XDG_SESSION_DESKTOP = zorin ]]; then
SUPERUSER=$(sudo cat /etc/sudoers | grep ALL | grep sudo) #ZORIN
elif [[ $XDG_SESSION_DESKTOP = XFCE ]]; then
SUPERUSER=$(sudo cat /etc/sudoers | grep wheel | head -2 | tail -1)
fi

REPLACE="# %sudo ALL=(ALL:ALL) ALL"

if [[ $XDG_SESSION_DESKTOP = KDE ]]; then
sudo chmod 000 /usr/bin/systemsettings
elif [[ $XDG_SESSION_DESKTOP = zorin ]]; then
sudo chmod 000 /usr/bin/gnome-control-center
elif [[ $XDG_SESSION_DESKTOP = XFCE ]]; then
sudo chmod 000 /usr/bin/xfce4-settings-manager
sudo chmod 000 /usr/bin/xfce4-session-settings
fi

chmod 400 /home/$THEUSER/.bashrc
sudo chown root:root /home/$THEUSER/{Downloads,Documents,Templates,Videos,Pictures,Vaults,Music}
sudo chmod 000 /home/$THEUSER/{Downloads,Documents,Templates,Videos,Pictures,Vaults,Music}
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

if [[ $XDG_SESSION_DESKTOP = KDE ]]; then
SUPERUSER=$(cat /etc/sudoers | grep "%wheel ALL=(ALL:ALL) ALL")
elif [[ $XDG_SESSION_DESKTOP = XFCE ]]; then
SUPERUSER=$(sudo cat /etc/sudoers | grep wheel | head -2 | tail -1)
elif [[ $XDG_SESSION_DESKTOP = zorin ]]; then
SUPERUSER=$(sudo cat /etc/sudoers | grep ALL | grep sudo) #ZORIN
fi

REPLACE=" %sudo ALL=(ALL:ALL) ALL"
sed -i "s/$SUPERUSER/$REPLACE/" /etc/sudoers
if [[ $XDG_SESSION_DESKTOP = KDE ]]; then
chmod 755 /usr/bin/systemsettings
elif [[ $XDG_SESSION_DESKTOP = zorin ]]; then
chmod 755 /usr/bin/gnome-control-center
elif [[ $XDG_SESSION_DESKTOP = XFCE ]]; then
chmod 755 /usr/bin/xfce4-settings-manager
chmod 755 /usr/bin/xfce4-session-settings
fi
sudo chown $USERTOUNSECURE:david /home/$USERTOUNSECURE/{Downloads,Documents,Templates,Videos,Pictures,Vaults,Music}
chmod 700 /home/$USERTOUNSECURE/{Downloads,Documents,Templates,Videos,Pictures,Vaults,Music}
chmod 644 /home/$USERTOUNSECURE/.bashrc
break
;;
esac
done

if [[ $OPTION = SECURE ]]; then
echo "sudo privileges removed/onhold till UNSECURE is selected!"
echo "systemsettings unavailable/unexecutable!"
echo "your bashrc file is only readable!"
echo "Home Folder; Folders Secured!"
echo "REMEMBER! run this script as root not sudo to UNSECURE it!"
echo "SYSTEM SECURED" >> /home/$THEUSER/MySystemIsSECURED
xmessage -nearmouse "SystemSecured! to Unsecure run su in terminal, you need the root password then execute secure.sh" 2> /dev/null  
else
echo "sudo privileges active/not-onhold!"
echo "systemsettings available/executable!"
echo "your bashrc file readable and writable!"
echo "Home Folder; Folders unSecured!"
rm /home/$USERTOUNSECURE/MySystemIsSECURED &> /dev/null
fi

