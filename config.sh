#!/bin/bash

# created by Nikolai Nekrutenko

# Ubuntu server 20.04.2 LTS

#define colors for colored text
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

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

# SETTING UP THE PHOENIXMINER CONFIG
# Multiple-choice type of deal for finding the closest server
echo "Which region is closest to you"

select region in US_East US_West Asia Europe

do
        case $region in
        US_East|US_West|Asia|Europe)
                break
                ;;
        *)
                echo "Invalid selection"
                ;;
        esac
done
confirm_install "This region is closest to you? $region" || exit 0

# modify the eth.sh file for the server locations
if [[ $region =~ "US_West" ]]; then
  sed -i "s/us1/us2/g" eth.sh
elif [[ $region =~ "Asia" ]]; then
  sed -i "s/us1/asia1/g" eth.sh
elif [[ $region =~ "Europe" ]]; then
  sed -i "s/us1/eu1/g" eth.sh
fi

# update the eth.sh file with your ETH address
read -p 'Enter ETH wallet address: ' wallet
confirm_install "Double-check that this is your address? $wallet" || exit 0
sed -i "s/ETHwalletaddr/$wallet/g" eth.sh

# update the eth.sh file with your rig name
read -p 'Fancy rig name (only standard characters): ' rig
confirm_install "Is this the name you wanted? $rig" || exit 0
sed -i "s/rigname/$rig/g" eth.sh

echo "miner config complete"

# STARTED WORKING ON OC SETTINGS AND SETUP
# variable that gets the number of graphics cards
# numgpus=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
