#!/bin/bash

# created by Nikolai Nekrutenko

# Ubuntu server 20.04 lts

#define the installation variable, and set it to one
var=1

#define colors for colored text
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

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

  # configure NVIDIA drivers so that they can work headlessly
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
  wget https://github.com/NikolaiTeslovich/UltimateMinerInstall/raw/main/PhoenixMiner_5.3b_Linux.tar.gz

  tar -xvf PhoenixMiner_5.3b_Linux.tar.gz

  mv PhoenixMiner_5.3b_Linux PhoenixMiner

  rm PhoenixMiner_5.3b_Linux.tar.gz
}

# ETHlargementPill installation for GTX 1080, 1080TI and Titan XP
pill_install() {
  wget https://github.com/Virosa/ETHlargementPill/raw/master/OhGodAnETHlargementPill-r2

  chmod +x OhGodAnETHlargementPill-r2

  mv OhGodAnETHlargementPill-r2 ETHPill
}

# XMRig installation
xmrig_install() {
  apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y

  git clone https://github.com/xmrig/xmrig.git

  mkdir xmrig/build && cd xmrig/build

  cmake ..

  make -j$(nproc)
}

# check with user that the gpus are correctly installed and are the right ones
vendor=$(lshw -class display | grep 'vendor' | uniq)

model=$(lshw -class display | grep 'product')

clear

if [[$vendor =~ "NVIDIA"]]; then
  echo "${green}NVIDIA GPUs detected${reset}"

elif [[$vendor =~ "AMD"]]; then
  echo "${red}AMD detected but not yet supported${reset}"

else
  echo "${red}No GPUs detected${reset}"

fi

echo "$model"

# setup questions

confirm_install "Does this look good?" || exit 0

confirm_install "CPU Mining?"

if [[$vendor =~ "NVIDIA"]]; then
  printf "\U1F48A" && confirm_install "The pill? (for GTX 1080, 1080TI & Titan XP)"

fi

# update and upgrade packages to the latest version
apt update && apt upgrade -y

# allow ssh through firewall, and enable firewall for security purposes
ufw allow ssh

ufw enable -y

# installation
if [[$vendor =~ "NVIDIA"]]; then
  nvidia_install
  phoenixminer_install

elif [[$var = 3]]; then
  xmrig_install

elif [[$var = 2]]; then
  pill_install

elif [[$var = 8]]; then
  xmrig_install
  pill_install

else
  exit 0

fi

# reboot system to get ready to mine

clear

echo "if you want to make this script even better, check out my github (NikolaiTeslovich)"

echo "rebooting shortly"

sleep 5

echo -e "\U26CF" "${green} Happy Mining ${reset}" "\U26CF"

sleep 1

reboot
