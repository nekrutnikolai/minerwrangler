#! /bin/sh

# created by Nikolai Nekrutenko

# Ubuntu server 18.04 lts

# first, edit the grub

wget https://github.com/NikolaiTeslovich/UltimateMinerInstall/raw/main/PhoenixMiner_5.3b_Linux.tar.gz

tar -xvf PhoenixMiner_5.3b_Linux.tar.gz

mv PhoenixMiner_5.3b_Linux PhoenixMiner

# to save power and change fan speed
git clone https://github.com/Shaped/amdpwrman.git

# install all the gpu driver shit
mkdir gpu

cd gpu

wget https://drivers.amd.com/drivers/linux/amdgpu-pro-20.40-1147287-ubuntu-18.04.tar.xz --referer https://support.amd.com

tar -Jxvf amdgpu-pro-20.40-1147287-ubuntu-18.04.tar.xz

cd amdgpu-pro-20.40-1147287-ubuntu-18.04

./amdgpu-install -y

./amdgpu-pro-install -y --opencl=pal,legacy,rocm --headless

sudo usermod -a -G video $LOGNAME

sudo reboot
