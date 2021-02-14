#!/bin/bash

# created by Nikolai Nekrutenko

# check if the eth script exists, then start mining
test -f eth.sh && screen -S eth -d -m ./eth.sh || echo "no ETH script found"

# check if the pill exists, then start mining
test -f ETHPill && screen -S pill -d -m sudo ./ETHPill || echo -e "no" "\U1F48A" "found"

# list all the screens
screen -list
