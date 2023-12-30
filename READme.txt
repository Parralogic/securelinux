This script will secure your linux box/system/computer from unauthorized
usage, by disabling sudo usage; your systemsettings and your bashrc. This script
was written in Arch Linux with the plasma5 desktop environment.

UPDATE! 12/30/2023
The secure script will now protect your Home forder sub-folders, still need to
modify the script so that all your files in the sub-folders are secured; with a
cd, chown, chmod and a wildcard * and a for loop. Those who know what Im referring to will be like
no-shit!

UPDATE! 10/17/2023
The secure.sh script will work with the three most used
Desktop Environments:[DE] KDE/plasma | xfce4 | Gnome.
...still working on it, but if your the only user it will work!
My idea is to make this script able to work with multiple users
on the system, because right now if you do have multiple accounts/users
all of them will be blocked/secured some what....

UPDATE! 10/14/2023
UPDATED the secure.sh script witches fucking with it the ALL=(ALL:ALL)
thats it!!

UPDATE! 10/03/2023
To my knowledge, this script at the moment, will work IF your the ONLY user
using your system and in the wheel group for the sudo command....
still working on it......
also copy the script [secure.sh] to the /usr/bin/ directory, then just secure.sh in terminal
to secure it more sudo chown root:root secure.sh && sudo chmod 755 secure.sh
