#! /bin/sh

# created by Nikolai Nekrutenko

# Ubuntu server 20.04 lts

sudo apt update

sudo apt upgrade -y

# install all the necessary libraries
sudo apt install git unzip build-essential cmake libuv1-dev libssl-dev libhwloc-dev screen xserver-xorg p7zip xorg-dev libgtk-3-dev xdm -y

# allow ssh through firewall, and enable firewall
sudo ufw allow ssh

sudo ufw enable -y

# reinstall nvidia drivers
sudo apt purge nvidia-*

sudo apt autoremove

sudo add-apt-repository ppa:graphics-drivers/ppa

sudo apt upgrade

sudo apt install nvidia-driver-440 -y

# install CUDA for mining
sudo apt install nvidia-cuda-toolkit -y

# configure NVIDIA drivers so that they can work headlessly
echo 'export PATH=/bin:/usr/bin:/sbin' >> /etc/X11/xdm/Xsetup

echo ‘export HOME=/root’ >> /etc/X11/xdm/Xsetup

echo ‘export DISPLAY=:0’ >> /etc/X11/xdm/Xsetup

echo ‘xset -dpms’ >> /etc/X11/xdm/Xsetup

echo ‘xset s off’ >> /etc/X11/xdm/Xsetup

echo ‘xhost +’ >> /etc/X11/xdm/Xsetup

sudo nvidia-xconfig -a --allow-empty-initial-configuration --cool-bits=28 --use-display-device="DFP-0" --connected-monitor="DFP-0" --custom-edid="DFP-0:/etc/X11/dfp-edid.bin"

sudo sed -i '/Driver/a Option "Interactive" "False"' /etc/X11/xorg.conf

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

#install etherenlargement pill
wget https://github.com/Virosa/ETHlargementPill/raw/master/OhGodAnETHlargementPill-r2

chmod +x OhGodAnETHlargementPill-r2

# install of that xmrig shiete
git clone https://github.com/xmrig/xmrig.git

mkdir xmrig/build && cd xmrig/build

cmake ..

make -j$(nproc)

# reboot system to get ready to mine
sudo reboot
