![logo](/resources/minerwrangler.png)

<h2 align="center">
  A headless driver installer & crypto miner configurator
</h2>

<h3 align="center">
  <a href="https://cryptoclarified.netlify.app/docs/minerwrangler/">Tutorial & quickstart (WIP)</a>
</h3>

<p align="center">
  MinerWrangler is the ultimate bundle of bash scripts to ease your way into cryptocurrency mining that is open-source and gives you full control over your rigs—by default. No monitor, keyboard, or mouse required. Only NVIDIA support for now.
</p>

<p align="center">
  <a href="https://github.com/NikolaiTeslovich/minerwrangler/blob/main/LICENSE">
    <img alt="MIT license" src="https://img.shields.io/github/license/NikolaiTeslovich/minerwrangler">
  </a>
  <img alt="GPU Support" src="https://img.shields.io/badge/GPU-NVIDIA-green">
</p>



## The ultimate one-liner

```
git clone https://github.com/NikolaiTeslovich/minerwrangler.git && cd minerwrangler && chmod +x install1.sh && sudo ./install1.sh
```

## Features

- [x] Simple and intuitive to use
- [x] One line to install
- [x] Full control over your rig(s)
- [x] Truly headless
- [x] Integrated with 💊 [OhGodAnETHlargementPill](https://github.com/admin-ipfs/OhGodAnETHlargementPill) (GTX 1080, GTX 1080Ti & TITAN Xp—GDDR5X GPUs)
> "ED (Ethereum Dysfunction) affects 1 in 10 NVIDIA GPUs in North America"

- [x] Support for the latest & greatest version of Ubuntu Server LTS
- [x] Firewall is enabled by default
- [x] Command-line interface

## Tested on

* **GPUs**
  * GTX 1080
  * RTX 2080
* **Driver version**
  * nvidia-driver-440
  * nvidia-driver-460 (default)

## To do

* Add option to automatically mine on boot
* Script to more easily configure overclocks and fan speeds
* RVN mining support
* Break down existing code in detail
* XMRig support
* AMD GPU support
* Support other miners and algorithms

## Preface

NVIDIA drivers on Linux are rather finicky and do not like being overclocked without a monitor connected to them, so I had to trick them using **lighdm**.

After countless hours, probably even days of banging my head against the monitor in despair to have my rigs work headlessly, and be **actually be overclockable**, I wanted to find a way that was simple, yet have the code and process be transparent to everyone, behind no paywall. In contrast to operating systems like HiveOS, or NHOS, using *MinerWrangler* in conjunction with Ubuntu Server, you can actually understand each step of the process and have full control over your rigs as providers of the blockchain.

## Prologue

Last edit: Feb 24, 2021

I started cryptocurrency mining back in August 2017 on a GTX 1080—still a very good card today—on my gaming PC using NiceHash. That was when Bitcoin was worth about $4k. At the time, I was just a freshman in high school looking to make a quick buck, essentially free money with my parents paying for the electricity—I was afterall heating the basement. I was only slightly interested in cryptocurrencies, occasionally looking at the prices on [CoinGecko](https://www.coingecko.com/en) and re-partitioning my, at the time, Coinbase portfolio into a bit of ETH and LINK during the otherwise boring English class—except for when we watched Romeo and Juliet 1968.

I kept on mining until the great bull and crash of 2017-2018. I clearly remember everybody in my family telling me to sell, sell, sell, while I still could. I probably would have, however I didn't have a way to withdraw those funds to a bank account—as I don't have one. Although some might look at this as a negative, it was a massive positive for me and taught me a lesson in patience. Compared to the prices at the time of writing this, $50k BTC and $2k ETH, I'm glad I held on and am still HODLing.

The only thing that I do regret, is stopping mining. I don't exactly remember why I stopped, probably because I lost interest due to the crash.

Fast forward to the Winter of 2019-2020, right before the Coronavirus pandemic took the world by a surprise. I decided to give crypto another chance after reading [The Bullish Case for Bitcoin](https://vijayboyapati.medium.com/the-bullish-case-for-bitcoin-6ecc8bdecc1)—a phenomenal read by the way. I went back to my old trusted method of NiceHash and Coinbase for a couple of weeks until I decided that I was sick of Windows 10. I was sick of stupid updates, the goddamn pop-up notifications that would cause me to crash my plane in WarThunder, and just the general clunky user interface. Plus, I was slowly moving away from computer gaming as my interest of RC flight took over. Linux, specifically Ubuntu, here I come!

Eventually, after countless hours, probably countless dozens of hours, I was mining ETH with PhoenixMiner on Ubuntu, this time to [Exodus wallet](https://www.exodus.com/)—a wallet that I still use to this day. Fortunately, I heard of the OhGodAnETHlargementPill, which when administered to my GTX 1080 yielded me 35, maybe even 36 Mh/s instead of the 28-30 that I was getting before.

I kept mining ETH non-stop until about June of the same year. Having heard of [Nerd Gearz](https://nerdgearz.com/) from a [Red Panda Mining video](https://www.youtube.com/channel/UCAGsnTCpw7pvhR4RAlEQGzg), I found a fantastic deal on some used Gigabyte Aorus RX 580's, so I bought two for a price of $200, which at this point has payed for itself many times over. It's crazy to think that these gpus can—at the time of writing—be sold for almost $300 due to the famous GPU shortage and insane demand from crypto miners. I pointed the two RX 580s to mine ETH, while I switched the GTX 1080 over to RVN, and was earning about 50 RVN each day!

Fast forward to November 2021, and my dad had lended me his RTX 2080 to mine as he was no longer using it for work. I pointed it at ETH, as well as the GTX 1080 was also, once again mining ETH. I also managed to pick up a Red Devil RX 5700XT on Craiglist—an absolute beast of a GPU—for about $350 used. I also invested in a hardware wallet, the [Ledger Nano X](https://shop.ledger.com/products/ledger-nano-x), to keep my crypto as safe as possible.

So to this day, I have a GTX 1080, and a RTX 2080 mining ETH with *MinerWrangler*, and two RX 580's and a RX 5700XT mining ETH using HiveOS unfortunately. *I still haven't figured out how to use AMD drivers headlessly.* However, I might switch the RTX 2080 to RVN as recently, the popularity of the project has gone up by a lot!

Who knows, maybe I'll major in Blockchain development—I find crypto fascinating and believe in a decentralized future.

## Credits

### Threads and forums that helped massively

* [OC Nvidia GTX1070s in Ubuntu 16.04LTS for Ethereum mining](https://gist.github.com/bsodmike/369f8a202c5a5c97cfbd481264d549e9) - tricking NVIDIA drivers into allowing headless overclocking
* [How to create a bootable USB stick to flash a BIOS](https://askubuntu.com/questions/46886/how-to-create-a-bootable-usb-stick-to-flash-a-bios) - updating BIOS on an old computer

### Logo image credits

* [Western retro font](https://www.dafont.com/western-retro.font)
* [Cowboy hat](https://www.pngitem.com/middle/hTiibR_guitar-clipart-cowboy-hat-cartoon-transparent-cowboy-hat/)
* [Cactus](http://clipart-library.com/clipart/cactus-clipart-34.htm)
* [Headless person from Dumb Ways To Die](https://dumbways2die.fandom.com/wiki/Hapless)
* [Ethereum logo](https://en.wikipedia.org/wiki/Ethereum#/media/File:Ethereum-icon-purple.svg)
