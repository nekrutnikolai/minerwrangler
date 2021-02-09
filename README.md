<h1 align="center">
  MinerWrangler
</h1>

<h3 align="center">
  A headless cryptocurrency miner installer and manager
</h3>

<p align="center">
  MinerWrangler is the ultimate bundle of shell scripts to ease your way into cryptocurrency mining that is open-source and gives you full control over your rigs—by default. No monitor, keyboard, or mouse required.
</p>

<p align="center">
  <a href="https://github.com/NikolaiTeslovich/minerwrangler/blob/main/LICENSE">
    <img alt="MIT license" src="https://img.shields.io/github/license/NikolaiTeslovich/minerwrangler">
  </a>
  <img alt="GPU Support" src="https://img.shields.io/badge/GPU-NVIDIA-green">
</p>

## The ultimate one-liner
```
git clone https://github.com/NikolaiTeslovich/minerwrangler.git && cd minerwrangler && chmod +x install.sh && sudo ./install.sh
```

## Tested on
* **GPUs**
  * GTX 1080
  * RTX 2080
* **Driver version**
  * nvidia-driver-440

## To do
* Write a usage guide
* Figure out which latest NVIDIA driver should work
* AMD version
* Make it conditional based on what GPUs and software the user would like
* Support other miners and algorithms
* Automatically start mining after a power outage
