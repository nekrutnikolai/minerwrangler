# enable persistence mode
sudo nvidia-smi -pm ENABLED

# set power limit to 75 watts
sudo nvidia-smi -i 0 -pl 175
sudo nvidia-smi -i 1 -pl 145

# configure gpu fan speed

DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:0]/GPUFanControlState=1
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [fan:0]/GPUTargetFanSpeed=55

DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:1]/GPUFanControlState=1
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [fan:1]/GPUTargetFanSpeed=75

# configure gpu mem speeds
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[2]=2000
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[3]=2000
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[4]=2000

DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:1]/GPUMemoryTransferRateOffset[2]=1400
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:1]/GPUMemoryTransferRateOffset[3]=1400
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:1]/GPUMemoryTransferRateOffset[4]=1400

# configure gpu clock speeds
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:0]/GPUGraphicsClockOffset[2]=0
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:0]/GPUGraphicsClockOffset[3]=0
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:0]/GPUGraphicsClockOffset[4]=0

DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:1]/GPUGraphicsClockOffset[2]=0
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:1]/GPUGraphicsClockOffset[3]=0
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings -a [gpu:1]/GPUGraphicsClockOffset[4]=0
