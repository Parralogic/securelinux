This script will secure your linux box/system/computer from unauthorized
usage, by disabling sudo usage; your systemsettings and your bashrc. This script
was written in Arch Linux with the plasma5 desktop environment.

UPDATE! 10/03/2023
To my knowledge, this script at the moment, will work IF your the ONLY user
using your system and in the wheel group for the sudo command....
still working on it......
also copy the script [secure.sh] to the /usr/bin/ directory, then just secure.sh in terminal
to secure it more sudo chown root:root secure.sh && sudo chmod 755 secure.sh
