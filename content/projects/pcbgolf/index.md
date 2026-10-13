+++
title = "PCBGolf: shrinking a CAN-FD dev board"
description = "My entry to comma.ai's PCBGolf challenge: every interface of a 4-port CAN-FD dev board on a 4-layer, double-sided board of 33.9 × 42.3 mm."
weight = 20
template = "project.html"

[extra]
featured = true
status = "Submitted"
tags = ["PCB", "Miniaturization", "BGA", "CAN-FD"]
image = "render.png"
image_alt = "KiCad 3D render of the board: a barrel jack, a USB-C host port and four USB-C ports along one edge, with small parts packed between them"
image_caption = "The submitted board, top side. KiCad render."
kicanvas = true
specs = [
  ["Challenge", "comma.ai PCBGolf"],
  ["Layers", "4, parts on both sides"],
  ["Outline", "33.9 × 42.3 mm"],
  ["Bounding box", "35.0 × 43.0 × 9.3 mm"],
  ["Vias", "303"],
  ["MCU", "STM32H725, TFBGA-100"],
  ["Score", "About 49,200 by the formula (unofficial)"],
]
+++

comma.ai's [PCBGolf](https://github.com/commaai/PCBGolf) challenge gives everyone the same board, loosely based on their panda jungle, and asks how small it can get. The board has a 12 V input with 5 V and 3.3 V supplies, four OBD-C ports with switched power and current monitoring, four CAN-FD transceivers, a USB hub, an STM32H725 and a microSD slot. Every interface has to keep working, mating connectors must stay compatible, and the board has to be manufacturable and assemblable at JLCPCB.

The score is the assembled board's bounding-box volume in mm³, plus 50 per via, plus 5000 per copper layer. Lowest wins.

**Status:** submitted on October 12, 2026. By the published formula my entry comes to about 49,200: 14,027 mm³ of volume (34.98 × 43.00 × 9.32 mm, including the overhang of the USB-C connectors), 15,150 for 303 vias and 20,000 for 4 layers. That is my own calculation. The official score has not been posted yet.

## What I changed

The schematic is comma's. The layout and the design decisions below are mine, with help from AI agents on routing and footprints.

- **Stackup and placement.** 4 layers: signal, power, ground, signal. Parts on both sides, with the STM32 and the USB hub on the bottom and the CAN parts and chokes on top.
- **MCU package.** The original is an LQFP-144. I first tried a UFBGA-169 at 0.5 mm pitch, which could not be escaped on 4 layers without blind or buried vias. The board now uses a TFBGA-100 at 0.8 mm pitch.
- **Package change without touching the schematic.** The BGA footprint's pads are renamed to the symbol's LQFP pin numbers, so the schematic still uses comma's symbol.
- **Pins as a routing tool.** Ports F and G do not exist on the smaller package, so CAN2, the button and several ADC inputs moved, and every analog input stayed on an ADC pin. I also re-ordered the 24 per-port control signals by channel to untangle the routing. Both changes need matching firmware changes, which the rules allow.
- **Smaller parts.** 0201 and 0402 passives, smaller crystals, inductors, LEDs and FETs, and an SC-70 op-amp (TLV9101) in place of the SOT-23 one for the CAN LEDs.
- **microSD.** A stemless Molex 503398-1892 socket, 1.28 mm tall, on the bottom side.

{{ <fig file="bottom-iso.png" alt="KiCad 3D render of the bottom side: the STM32, the USB hub, the microSD socket and the CAN transceivers, with the four USB-C ports along the edge" caption="The bottom side, with the STM32, the USB hub and the microSD socket." /> }}

<div class="fig-row natural">{{ <fig file="top.png" alt="Top view render: barrel jack, USB-C host port, power parts and four USB-C ports with their switches" caption="Top." /> }}{{ <fig file="bottom.png" alt="Bottom view render: STM32, USB hub, microSD socket and CAN transceivers labeled CAN1 to CAN4" caption="Bottom." /> }}</div>

## What is not done

Nothing has been fabricated, assembled or tested. The firmware for the new pin map is not written. USB high-speed signal integrity and power have not been simulated. The board passes KiCad's DRC with no errors and matches the schematic, but it has not been through JLCPCB's own manufacturability check, and ordering it would need their filled via-in-pad option for the BGA.

## Design files

{{ <kicanvas repo="ulyssecrn/PCBGolf" file="pcbgolf.kicad_pcb" label="PCB layout (as submitted)" ref="14a4fe6c571821c9da48f80088b50fd609a85cee" /> }}

The repo is at [github.com/ulyssecrn/PCBGolf](https://github.com/ulyssecrn/PCBGolf).

## Lessons

- **Layers and vias weigh more than size.** One copper layer costs as much as 100 vias. On my entry, layers and vias are 71% of the score, and the top entries use one layer and no vias. A larger board on fewer layers can win.
- **Choose the layer count from the formula first.** Next time I would start from the score, then pick packages that route on 1 or 2 layers, instead of shrinking first and paying for layers.
- **BGA pitch decides the layer count.** The 0.5 mm package needed blind or buried vias to escape on 4 layers. The 0.8 mm one does not.
- **One connector sets the height.** The DC barrel jack accounts for about 75% of the board's total height.
- **Pin assignment is a routing tool** when the firmware follows it.
