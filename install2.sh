#!/bin/bash

# created by Nikolai Nekrutenko

# Ubuntu server 20.04.2 LTS

#define colors for colored text
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# install packages and run the nvidia-xconfig to make the system truly headless
apt upgrade -y
apt install --no-install-recommends xorg lightdm lightdm-gtk-greeter -y
nvidia-xconfig --enable-all-gpus --allow-empty-initial-configuration --cool-bits=28 --connected-monitor="DFP-0"
# setup the xorg config, notice how the "\ \ \ \" is used as indents
sed -i '/Option         "ConnectedMonitor" "DFP-0"/a\ \ \ \ Option \ \ \ \ \ \ \ \ "Interactive" "False"' /etc/X11/xorg.conf

# make the other scripts executable, while removing permissions for the current one
chmod 0 install2.sh
chmod +x mine.sh eth.sh clockfan.sh
# display some beautiful messages
echo -e "\U26CF" "${green}Happy Mining${reset} & ${red}Heating${reset}" "\U26CF"
sleep 3
clear
echo "${red}Rebooting for the last time...${reset}"
sleep 2
reboot
