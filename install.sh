#!/bin/bash

# created by Nikolai Nekrutenko

# Ubuntu server 20.04.2 LTS

# DEFINING ALL THE VARIABLES

#define colors for colored text
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

#define the installation variable, and set it to one
var=1

# define variables for the manufacturer and model of the GPU(s), and hide the commandline output
{
  vendor=$(lshw -class display | grep 'vendor' | uniq)
  model=$(lshw -class display | grep 'product')
} &> /dev/null

# DEFINING THE INSTALLATION FUNCTIONS
# define the confirm install function
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
  # reinstall nvidia drivers and CUDA if it is not a fresh install
  apt purge nvidia-*
  apt autoremove -y
  add-apt-repository ppa:graphics-drivers/ppa -y
  apt upgrade -y
  # install all the necessary libraries, will ask config during install
  apt install xorg nvidia-driver-460 nvidia-cuda-toolkit -y
  nvidia-xconfig -a --allow-empty-initial-configuration --cool-bits=28 --connected-monitor="DFP-0"
  #--custom-edid="DFP-0:/etc/X11/dfp-edid.bin" --use-display-device="DFP-0"
  nvidia-xconfig --enable-all-gpus --cool-bits=28 --allow-empty-initial-configuration
}

# Phoenix Miner installation
phoenixminer_install() {
  # install unzip
  apt install unzip -y
  # Download latest Phoenix Miner (5.5c at the time of editing this) - https://phoenixminer.org/download/latest/
  wget https://bit.ly/3pf1gzU
  # Extract the file, rename it, and delete the installer
  unzip 3pf1gzU
  mv PhoenixMiner_* PhoenixMiner
  rm 3pf1gzU
  # Make Phoenix Miner itself executable
  cd PhoenixMiner && chmod +x PhoenixMiner && cd ..
}

# ETHlargementPill installation for GTX 1080, 1080TI and Titan XP
pill_install() {
  # Download
  wget https://github.com/admin-ipfs/OhGodAnETHlargementPill/raw/master/OhGodAnETHlargementPill-r2
  # Make the file executable, and rename it
  chmod +x OhGodAnETHlargementPill-r2
  mv OhGodAnETHlargementPill-r2 ETHPill
}

# THE CONDITIONAL INSTALLATON CODE
clear
if [[ $vendor =~ "NVIDIA" ]]; then
  echo -e "${green}NVIDIA GPUs detected${reset}" "\U2714"
elif [[ $vendor =~ "AMD" ]]; then
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
clear
printf "\U1F48A" && confirm_install "The pill? (GTX 1080, 1080Ti & Titan XP)"
clear

# set the proper time
sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"
sudo hwclock --systohc
# update and upgrade packages to the latest version
apt update && apt upgrade -y
# just such a useful tool, should be installed regardless of option
apt install screen -y
# allow ssh through firewall, and enable firewall for security purposes
ufw allow ssh
yes | ufw enable

# installation
if [[ $vendor =~ "NVIDIA" ]]; then
  nvidia_install
  phoenixminer_install
  if [[ $var = 4 ]]; then
    pill_install
  fi
else
  exit 0
fi

# REBOOT SYSTEM AND GET READY TO MINE
# make all the scripts executable
chmod +x mine.sh eth.sh clockfan.sh install2.sh
clear
# display a message, then reboot
echo -e "\U26CF" "${green}Happy Mining${reset} & ${red}Heating${reset}" "\U26CF"
sleep 5
reboot
