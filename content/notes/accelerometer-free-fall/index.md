+++
title = "Why a falling accelerometer reads 0 g"
description = "A watch in free fall accelerates at 1 g, yet its accelerometer reads 0. The short version of a talk I gave at Withings, with drops from the 7th floor and a turntable."
date = 2025-07-24
template = "note.html"

[extra]
kind = "Physics"
+++

A watch in free fall accelerates at 1 g. So its accelerometer should read 1 g. It reads 0. This is the short version of a talk I gave to my team at Withings. The full version, with the derivations and plots, is coming.

## What the sensor actually measures

A MEMS accelerometer is a small proof mass held by springs inside a frame. Capacitor plates sense how far the mass moves relative to the frame, and the readout electronics turn that into a voltage. Below the sensor's resonant frequency, the displacement is proportional to acceleration, so the output is a straight line: an offset plus a sensitivity times the acceleration.

The catch is what makes the mass move relative to the frame. Gravity pulls on the mass and on the frame equally, so it moves neither one relative to the other. Only forces that push on the frame and not on the mass, like a table holding the watch up, deflect the mass. So an accelerometer measures every acceleration except the one gravity causes.

- **On a table**, the table pushes the frame up, the mass sags on its springs, and the sensor reads 1 g.
- **In free fall**, gravity is the only force, nothing deflects the mass, and the sensor reads 0.

## Checking it

I logged a watch's accelerometer through a few experiments.

- **Dropped from the 7th floor**, inside a ball. The reading fell to about 0 g, then climbed as air drag built up, reaching 0.45 g just before impact, after 2.3 s of fall.
- **A second drop** never reached 0. The ball spun, so the off-center sensor saw a steady centripetal acceleration, plus oscillations from precession.
- **Fins and a parachute** on the ball, to play with drag and spin.
- **In a lift**, the reading rose above 1 g when the lift started up and dropped below it when it slowed down.
- **On a turntable** at 78 rpm, 10 cm from the center, a = rω² predicts 0.68 g. The sensor read 0.71 g.
