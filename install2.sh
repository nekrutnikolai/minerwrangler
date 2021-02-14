#!/bin/bash

# created by Nikolai Nekrutenko

# Ubuntu server 20.04.2 LTS

#define colors for colored text
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

apt upgrade -y

apt install --no-install-recommends xorg lightdm lightdm-gtk-greeter -y

nvidia-xconfig --enable-all-gpus --allow-empty-initial-configuration --cool-bits=28 --connected-monitor="DFP-0"
# setup, notice how the "\ \ \ \" is used as indents
sed -i '/Option         "ConnectedMonitor" "DFP-0"/a\ \ \ \ Option \ \ \ \ \ \ \ \ "Interactive" "False"' /etc/X11/xorg.conf

chmod +x mine.sh eth.sh clockfan.sh

echo -e "\U26CF" "${green}Happy Mining${reset} & ${red}Heating${reset}" "\U26CF"
sleep 3
clear
echo "${red}Rebooting ...${reset}"
sleep 2
reboot
