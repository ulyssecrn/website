+++
title = "Medistrib: a pill organizer filling robot"
description = "A robot that fills patients' pill organizers, from a 6-month maker project at CentraleSupélec. I wrote the firmware and designed the hoppers and the belt carriage. Graded 20/20."
weight = 22
template = "project.html"

[extra]
featured = true
tags = ["Robotics", "Firmware", "Fusion 360", "3D printing"]
image = "medistrib.jpg"
image_alt = "The Medistrib prototype: two pill hoppers, a belt-driven tray with seven compartments, an Arduino stack and an LCD reading Quel patient"
image_caption = "The proof of concept, April 2023."
specs = [
  ["Year", "2023"],
  ["Course", "Maker project, 6 months"],
  ["Team", "6"],
  ["Grade", "20/20"],
  ["Controller", "Arduino Mega"],
]
+++

Medistrib started as a 6-month maker project at CentraleSupélec, with a team of six. Our first idea was a cocktail robot, which the project supervisor found inappropriate, so we switched to pills: filling patients' pill organizers in hospitals and nursing homes is a recurring, repetitive task where mistakes matter.

**My part:** I wrote the firmware, designed the pill hoppers in Fusion 360, and designed the belt carriage that moves the tray, heavily inspired by the belts of belt 3D printers.

## The prototype

We built it at La Fabrique, CentraleSupélec's prototyping workshop.

- **Two pill hoppers**, each with a slotted disc at the bottom to feed pills out, and an optical sensor at the outlet.
- **A belt-driven carriage** that moves a seven-compartment tray under the hoppers, with a stepper motor and a limit switch.
- **An Arduino Mega** with two stepper drivers, on prototyping shields.
- **An LCD menu** with a knob, to choose the patient.

<div class="fig-row">{{ <fig file="top.jpg" alt="Top view: two hoppers, the blue one holding dark capsules around a slotted disc, above the compartment tray" caption="The hoppers from above." /> }}{{ <fig file="electronics.jpg" alt="An Arduino Mega with two prototype shields, two stepper drivers and colorful wiring" caption="The Arduino Mega stack." /> }}</div>

<div class="fig-row wide">{{ <fig file="sensor.jpg" alt="Close-up of a small board with a red light at the outlet of the blue hopper" caption="The sensor at a hopper outlet." /> }}{{ <fig file="lcd.jpg" alt="A 3D-printed panel with an LCD reading Medistrib, Quel patient, Patient A or B, and a knob" caption="Choosing the patient." /> }}</div>

## After the course

The jury gave us 20/20, asked whether we had thought about a start-up, and suggested CentraleSupélec's entrepreneurship program for the next semester. Four of us joined it. We contacted nursing homes and pharmacies to study the need, and looked at the regulations and the market.

We did not go further. We were heading down different paths, and the regulation of medical devices in hospitals and nursing homes is a lot to take on. It was still very interesting, and it taught me something I keep in mind: going from an idea to a prototype and then trying to sell it does not work. You find the need first, then build a prototype that meets it, with the regulations and the market in view from the start.

{{ <fig file="team.jpg" alt="Six students smiling behind the Medistrib prototype on a wooden counter" caption="The maker project team. I'm on the left." /> }}
