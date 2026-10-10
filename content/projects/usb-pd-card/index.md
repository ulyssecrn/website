+++
title = "USB-C PD business card"
description = "A credit-card PCB that reads a charger's USB PD offers and lights one LED per voltage. A battery-free NFC tag opens this site on a phone tap."
weight = 10
template = "project.html"

[extra]
featured = true
status = "In progress"
tags = ["PCB", "USB-C", "NFC", "Firmware"]
image = "render.png"
image_alt = "KiCad 3D render of the card: name and contact details on the left, LEDs labeled by voltage and wattage and the USB-C edge plug on the right"
image_caption = "KiCad render of the work in progress."
kicanvas = true
specs = [
  ["Size", "85.6 × 54 mm"],
  ["Board", "0.6 mm FR4, ENIG"],
  ["Finish", "Purple soldermask, white silkscreen"],
  ["Thickness", "About 1.7 mm with parts"],
  ["MCU", "WCH CH32X035"],
  ["NFC", "NXP NT3H2111"],
  ["Fab", "JLCPCB assembly"],
]
+++

My business card is a PCB. Plug a USB-C charger into its edge and it will light one LED for each capability the charger advertises: 5, 9, 12, 15 and 20 V, PPS and EPR, plus a 5-LED bar for the maximum wattage (15, 30, 45, 65 and 100 W). Tap it with a phone and a battery-free NFC tag opens this site.

**Status:** schematic done. Layout in progress: the USB side is placed and routed, the NFC coil is next. Not ordered yet, and the firmware is not started. It has not been fabricated or tested. This page will get bring-up notes and lessons learned once it has.

## How it works

{{ <diagram file="block.svg" caption="Two independent circuits on one board. The USB side runs only when a cable is plugged in. The NFC side runs on energy from the phone's field." /> }}

**USB side.** The card edge is shaped as a USB-C plug tongue, so a cable plugs straight into the board. Both CC lines go to a CH32X035, a small RISC-V MCU with a USB PD PHY built in. Each CC line has its own 5.1 kΩ pull-down, so a charger sees a sink and turns VBUS on before the MCU has booted. Firmware will wait for the charger's Source_Capabilities message, parse every power data object (fixed, PPS and EPR), light the matching LEDs, and then request 5 V only. The card never asks for a higher voltage.

**NFC side.** An NXP NT3H2111 tag sits at the edge of a spiral coil etched into the PCB. A phone's field will power the tag, which serves an NDEF record with the URL of this site, and the harvested energy will also light one LED. Nothing on this side touches the USB circuit or needs a battery.

## Design decisions

- **D+ and D− are left unconnected.** The CH32X035's BOOT pin is PC17, which is also the USB D+ pin, and some chargers drive D+ to about 2.7 V. Connecting it could drop the MCU into its bootloader on plug-in.
- **External Rd resistors.** The CH32X035 cannot present its own Rd without WCH's companion chip, and the pull-downs must be there before any firmware runs.
- **Coil sized to the tag.** The NT3H2111 has about 50 pF of input capacitance, so resonance at 13.56 MHz needs about 2.75 µH. The coil is a 46 × 38 mm rectangle, 5 turns of 0.5 mm track with 0.3 mm gaps. Its estimated inductance is 2.30 µH, which puts it at about 14.4 MHz untuned. That is deliberately high, because a tuning capacitor can only lower the frequency: about 6.8 pF brings it to 13.56 MHz, and the board has a footprint for one. These are estimates from a coil script in the repo. Nothing is measured yet.
- **Coil and electronics on opposite halves.** No copper pour, traces or art inside or near the coil, and the USB-C plug shell stays at least 5 mm away.

## Design files

The KiCad project is public at [github.com/ulyssecrn/usb-pd-card](https://github.com/ulyssecrn/usb-pd-card).

{{ <kicanvas repo="ulyssecrn/usb-pd-card" file="usb-pd-card.kicad_sch" label="Schematic" /> }}

{{ <kicanvas repo="ulyssecrn/usb-pd-card" file="usb-pd-card.kicad_pcb" label="PCB layout (in progress)" /> }}

## Key parts

| Ref | Part | Role | LCSC |
|---|---|---|---|
| U1 | WCH CH32X035G8U6 | MCU with USB PD PHY | [C7437027](https://www.lcsc.com/product-detail/C7437027.html) |
| U3 | NXP NT3H2111W0FHKH | NFC tag with energy harvesting | [C710403](https://www.lcsc.com/product-detail/C710403.html) |
| U2 | Microne ME6228A33M3G | 3.3 V LDO, SOT-23 | [C487914](https://www.lcsc.com/product-detail/C487914.html) |
| D1 | SMF20A | VBUS TVS | [C41411782](https://www.lcsc.com/product-detail/C41411782.html) |
| D3, D4 | H7VL10B | CC line ESD | [C20615787](https://www.lcsc.com/product-detail/C20615787.html) |
| D2, D5 to D16 | KT-0603R | 13 red LEDs | [C2286](https://www.lcsc.com/product-detail/C2286.html) |

The full BOM, with LCSC numbers for every part, is in the repo.

## Credits

The PCB-edge USB-C footprint is adapted from Nicholas Johnson's [flip-card](https://github.com/Nicholas-L-Johnson/flip-card) (MIT). I used [Koda's](https://designedbykoda.com/) NFC business card as a reference for the coil geometry.
