#!/bin/bash

# created by Nikolai Nekrutenko

# get into the directory
cd xmrig/build

# update the mine
git pull

./xmrig --donate-level 1 -o pool.supportxmr.com:443 -u XMRwalletaddress -k --tls -p workername
