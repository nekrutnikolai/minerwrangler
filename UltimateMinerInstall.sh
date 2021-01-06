#!/bin/bash

# created by Nikolai Nekrutenko

# Ubuntu server 20.04 lts

#define colors for colored text
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

#define the confirm function
confirm() {
  while true; do
    read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) echo " ${red}invalid input${reset}"
    esac
  done
}

# check with user that the gpus are correctly installed and are the right ones
vendor=$(lshw -class display | grep 'vendor' | uniq)
model=$(lshw -class display | grep 'product')

clear

if [[ $vendor =~ "NVIDIA" ]]; then
  echo "${green}NVIDIA GPUs detected${reset}"

elif [[ $vendor =~ "AMD" ]]; then
  echo "${red}AMD detected but not yet supported :(${reset}"

else
  echo "${red}No NVIDIA GPUs detected${reset}"

fi

echo "$model"

confirm "Does this look good?" || exit 0

# update and upgrade packages to the latest version
apt update && apt upgrade -y

# install all the necessary libraries
apt install git unzip screen xserver-xorg p7zip xorg-dev libgtk-3-dev xdm -y

# allow ssh through firewall, and enable firewall for security purposes
ufw allow ssh

ufw enable -y

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

# install NBMiner for dat RVN!

wget https://github.com/NebuTech/NBMiner/releases/download/v33.4/NBMiner_33.4_Linux.tgz

# extract it
tar xvzf NBMiner_33.4_Linux.tgz

# rename to NBMiner
mv NBMiner_Linux NBMiner

rm NBMiner_33.4_Linux.tgz

# install Phoenix Miner
wget https://github.com/NikolaiTeslovich/UltimateMinerInstall/raw/main/PhoenixMiner_5.3b_Linux.tar.gz

tar -xvf PhoenixMiner_5.3b_Linux.tar.gz

mv PhoenixMiner_5.3b_Linux PhoenixMiner

rm PhoenixMiner_5.3b_Linux.tar.gz

#ask user if the pill shall be installed? etherenlargement pill and rename it to ETHPill
pill() {
  wget https://github.com/Virosa/ETHlargementPill/raw/master/OhGodAnETHlargementPill-r2

  chmod +x OhGodAnETHlargementPill-r2

  mv OhGodAnETHlargementPill-r2 ETHPill
}

printf '\U1F48A'&& confirm "The pill?" && pill

# install of that xmrig shiete

apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y

git clone https://github.com/xmrig/xmrig.git

mkdir xmrig/build && cd xmrig/build

cmake ..

make -j$(nproc)

# reboot system to get ready to mine
reboot
