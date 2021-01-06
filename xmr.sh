#!/bin/bash

# created by Nikolai Nekrutenko

cd xmrig/build

# update the miner automatically
git pull

./xmrig --donate-level 1 -o pool.supportxmr.com:443 -u XMRwalletadress -k --tls -p workername
