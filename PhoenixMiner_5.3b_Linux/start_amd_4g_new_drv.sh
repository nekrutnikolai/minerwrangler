#
# Example shell file for starting PhoenixMiner.exe to mine ETH with AMD card
# with 4GB VRAM and newer drivers (19.50 and newer)
#

# IMPORTANT: Replace the ETH address with your own ETH wallet address in the -wal option (Rig001 is the name of the rig)

while :
do
	./PhoenixMiner -rmode 0 -pool ssl://eu1.ethermine.org:5555 -pool2 ssl://us1.ethermine.org:5555 -wal 0x008c26f3a2Ca8bdC11e5891e0278c9436B6F5d1E.Rig001
	echo "Hit [CTRL+C] to stop the miner from restarting in 10 seconds"
	sleep 10
done
