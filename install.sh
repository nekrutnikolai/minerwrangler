#!/bin/bash

# created by Nikolai Nekrutenko

# Ubuntu server 20.04 lts

# DEFINING ALL THE VARIABLES

#define colors for colored text
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

#define the installation variable, and set it to one
var=1

# define variables for the manufacturer and model of  the GPU(s)
vendor=$(lshw -class display | grep 'vendor' | uniq)
model=$(lshw -class display | grep 'product')

# DEFINING THE INSTALLATION FUNCTIONS

#define the confirm install function
confirm_install() {
  local REPLY
  while true; do
    read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY])
        echo
        ((var*=2))
        return 0 ;;
      [nN])
        echo
        ((var-=1))
        return 1 ;;
      *)
        echo " ${red}invalid input${reset}"
    esac
  done
}

# define Nvidia installation
nvidia_install() {
  # install all the necessary libraries
  apt install git unzip screen xserver-xorg p7zip xorg-dev libgtk-3-dev xdm -y

  # reinstall nvidia drivers if it is not a fresh install
  apt purge nvidia-*
  apt autoremove
  add-apt-repository ppa:graphics-drivers/ppa -y
  apt upgrade
  apt install nvidia-driver-440 -y

  # install CUDA for mining
  apt install nvidia-cuda-toolkit -y

  # configure NVIDIA drivers so that they can work headlessly, basically trick the gpu into thinking there's a display
  echo 'export PATH=/bin:/usr/bin:/sbin' >> /etc/X11/xdm/Xsetup
  echo ‘export HOME=/root’ >> /etc/X11/xdm/Xsetup
  echo ‘export DISPLAY=:0’ >> /etc/X11/xdm/Xsetup
  echo ‘xset -dpms’ >> /etc/X11/xdm/Xsetup
  echo ‘xset s off’ >> /etc/X11/xdm/Xsetup
  echo ‘xhost +’ >> /etc/X11/xdm/Xsetup

  nvidia-xconfig -a --allow-empty-initial-configuration --cool-bits=28 --use-display-device="DFP-0" --connected-monitor="DFP-0" --custom-edid="DFP-0:/etc/X11/dfp-edid.bin"

  sed -i '/Driver/a Option "Interactive" "False"' /etc/X11/xorg.conf
}

# Phoenix Miner installation
phoenixminer_install() {
  # Download
  wget https://github.com/NikolaiTeslovich/UltimateMinerInstall/raw/main/PhoenixMiner_5.3b_Linux.tar.gz

  # Extract the file, rename it, and delete the installer
  tar -xvf PhoenixMiner_5.3b_Linux.tar.gz
  mv PhoenixMiner_5.3b_Linux PhoenixMiner
  rm PhoenixMiner_5.3b_Linux.tar.gz
}

# ETHlargementPill installation for GTX 1080, 1080TI and Titan XP
pill_install() {
  # Download
  wget https://github.com/Virosa/ETHlargementPill/raw/master/OhGodAnETHlargementPill-r2

  # Make the file executable, and rename it
  chmod +x OhGodAnETHlargementPill-r2
  mv OhGodAnETHlargementPill-r2 ETHPill
}

# THE CONDITIONAL INSTALLATON CODE

clear

if [[$vendor =~ "NVIDIA"]]; then
  echo -e "${green}NVIDIA GPUs detected${reset}" "\U2714"

elif [[$vendor =~ "AMD"]]; then
  echo "${red}AMD GPUs are not yet supported${reset}"
  echo "exiting in 5 seconds"
  sleep 5
  exit 0

else
  echo "${red}No GPUs detected${reset}"
  echo "exiting in 5 seconds"
  sleep 5
  exit 0

fi

echo "$model"

# setup questions
confirm_install "Is this the correct hardware?" || exit 0

printf "\U1F48A" && confirm_install "The pill? (for GTX 1080, 1080TI & Titan XP)"

# update and upgrade packages to the latest version
apt update && apt upgrade -y

# allow ssh through firewall, and enable firewall for security purposes
ufw allow ssh

ufw enable -y

# installation
if [[$vendor =~ "NVIDIA"]]; then
  nvidia_install
  phoenixminer_install

elif [[$var = 4]]; then
  pill_install

else
  exit 0

fi

# reboot system to get ready to mine

clear

echo "if you want to make this script even better, check out my github (NikolaiTeslovich)"

echo "rebooting shortly"

sleep 5

echo -e "\U26CF" "${green} Happy Mining${reset}" "\U26CF"

sleep 1

reboot
