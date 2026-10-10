+++
title = "22 × 22 mm drone flight controller"
description = "A 6-layer Betaflight flight controller around an STM32G473, with four custom ESCs, that runs on a LiPo or on supercapacitors."
weight = 10
template = "project.html"

[extra]
tags = ["PCB", "STM32", "Power", "6 layers"]
image = "drone.jpg"
image_alt = "A Tornyol microdrone with cyan prop guards, mounted on a test rig"
image_caption = "One of Tornyol's microdrones on a test rig. Photo: Tornyol."
specs = [
  ["Size", "22 × 22 mm"],
  ["Layers", "6"],
  ["MCU", "STM32G473"],
  ["ESCs", "4 × EFM8BB51"],
  ["Power", "1S LiPo or 2S supercaps"],
  ["Firmware", "Betaflight"],
]
+++

I designed a new flight controller end to end: schematic, part selection, layout and routing of a 6-layer board. It carries an STM32G473, an integrated high-speed gyro, flash memory, the power supplies and four custom ESCs (EFM8BB51, flashed over C2) with their half-bridge power stages. It runs on a 1S LiPo or a 2S supercapacitor pack.

It replaced the [BetaFPV Matrix 1S 5in1 II](https://betafpv.com/collections/1s-brushless-fc/products/matrix-1s-5in1-ii-brushless-flight-controller) the team flew before, as a drop-in. The goals were a lower cost, no video transmitter, and supercapacitor power. After two iterations in two months, the prototype flew.

{{ <fig file="betafpv-rework.jpg" alt="Close-up of a BetaFPV Matrix 1S flight controller held in fingers, with its red antenna wire" caption="The BetaFPV board I reverse-engineered as a reference. The red wire is its antenna. This is not my board." /> }}

**A burned power stage.** On the first board, the ESC power stages burned their FETs because the high-side switch could never turn off. I found the cause in LTspice. The 1S revision uses a P-channel high side. The 2S revision uses two N-channel FETs with a bootstrap supply and an NPN transistor to turn the high side off, simulated first. Both revisions worked with the motors spinning.

{{ <fig file="gate-drive-sim.jpg" alt="My desk at Tornyol: a curved monitor with ESC Configurator and an LTspice simulation, a multimeter and a thermal camera" caption="Simulating the ESC gate drive in LTspice. Boards, schematic, config and colleagues are blurred." /> }}

The flight controller runs Betaflight and the ESCs run Bluejay, flashed over C2, so this project was hardware work. The board is confidential, so there is no photo of it here.
