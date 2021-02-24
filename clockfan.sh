#!/bin/bash

# created by Nikolai

# Enable persistence mode on all GPUs
nvidia-smi -pm ENABLED

# Set power limits in Watts
# -------------------------
# GPU 0 - set the power limit to 155 Watts
nvidia-smi -i 0 -pl 155
# GPU 1 - set the power limit to 145 Watts
nvidia-smi -i 1 -pl 145

# Configure gpu fan speed by setting GPUFanControlState=1 and modifying the GPUTargetFanSpeed=fanspeed%
# -----------------------------------------------------------------------------------------------------
# GPU 0 - enable fan speed control and set the target fan speed to 55%
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings \
-a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=55'
# GPU 1 - enable fan speed control and set the target fan speed to 75%
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings \
-a '[gpu:1]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=75'

# Configure GPU memory speeds (VRAM) with GPUMemoryTransferRateOffset[performancestate]=Mhz_offset
# Notice how performancestates 2, 3 & 4 are used
# ----------------------------------------------
# GPU 0 - Increase the memory speed by 1000 Mhz (500Mhz)
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings \
-a '[gpu:0]/GPUMemoryTransferRateOffset[2]=1000' -a '[gpu:0]/GPUMemoryTransferRateOffset[3]=1000' -a '[gpu:0]/GPUMemoryTransferRateOffset[4]=1000'
# GPU 1 - Increase the memory speed by 1000 Mhz (500Mhz)
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings \
-a '[gpu:1]/GPUMemoryTransferRateOffset[2]=1000' -a '[gpu:1]/GPUMemoryTransferRateOffset[3]=1000' -a '[gpu:1]/GPUMemoryTransferRateOffset[4]=1000'

# Configure GPU core clock speed with GPUGraphicsClockOffset[performancestate]=Mhz_offset
# Once again, notice how performancestates 2, 3 & 4 are used
# ----------------------------------------------------------
# GPU 0 - Increase the memory speed by 150 Mhz
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings \
-a '[gpu:0]/GPUGraphicsClockOffset[2]=150' -a '[gpu:0]/GPUGraphicsClockOffset[3]=150' -a '[gpu:0]/GPUGraphicsClockOffset[4]=150'
# GPU 1 - Increase the memory speed by 150 Mhz
DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/:0 sudo nvidia-settings \
-a '[gpu:1]/GPUGraphicsClockOffset[2]=150' -a '[gpu:1]/GPUGraphicsClockOffset[3]=150' -a '[gpu:1]/GPUGraphicsClockOffset[4]=150'
