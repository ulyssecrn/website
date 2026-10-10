+++
title = "20 A supercapacitor charger"
description = "A BQ25820 charger with an op-amp cell balancer and my STM32 firmware. Ran 20 A on a 1S pack and charged the 2S flight pack at 12 A."
weight = 20
template = "project.html"

[extra]
tags = ["Power", "Firmware", "STM32", "I2C"]
image = "bench.jpg"
image_alt = "The electronics bench at Tornyol: soldering station, fume extractor and cables"
image_caption = "The electronics bench at Tornyol. Photo: Tornyol."
specs = [
  ["Charger IC", "TI BQ25820"],
  ["Input", "24 V"],
  ["Designed for", "7.6 V, 20 A"],
  ["Ran on the bench", "20 A on 1S, 12 A on 2S"],
  ["Firmware", "STM32, over I2C"],
]
+++

Supercapacitors store less energy than a LiPo but charge much faster, which suits a drone that keeps returning to a base station. Once the flight controller ran on supercapacitors, the drone needed a charger that could push a lot of current.

I designed it around TI's BQ25820: a 24 V input, a synchronous buck for constant-current then constant-voltage charging, and an op-amp midpoint balancer across the two cells. I started from TI's evaluation module and shrank it to a credit-card-size board.

- **Designed for 7.6 V and 20 A**, to charge a 2S pack.
- **On the bench:** I confirmed CC/CV charging, ran 20 A on a 1S pack, and charged the 2S pack the drone flew at 12 A. I calibrated the BQ25820's current reading against a multimeter and checked heat with a thermal camera.
{{ <fig file="rail-bringup.jpg" alt="Rigol oscilloscope showing an enable signal and a power rail rising shortly after it" caption="Power rail bring-up on the bench." /> }}

- **Firmware:** I wrote the STM32 bring-up firmware over I2C: register configuration, cell balancing and controlled charge voltage.
- **Result:** the drone went from 3 min of flight per 15 min of charge on LiHV to 90 s of flight per 90 s of charge.
