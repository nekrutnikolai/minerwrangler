#!/bin/bash

# created by Nikolai Nekrutenko

screen -S xmr -d -m ./xmr.sh

screen -S eth -d -m ./eth.sh

test -f ETHPill && screen -S pill -d -m sudo ./ETHPill || echo "no ETHPill found"

screen -list
