+++
title = "Low-power snoring detection on a smartwatch"
description = "Audio ADC drivers and a duty-cycled wake-on-sound pipeline that cut the feature's battery cost from 15 days to 1.7 on a 30-day watch."
weight = 10
template = "project.html"

[extra]
role = "R&D Engineering Intern"
dates = "February to July 2025"
tags = ["Firmware", "Low power", "nRF52", "Audio"]
image = "my-scanwatch.jpg"
image_alt = "A Withings ScanWatch 2 on my wrist"
image_caption = "My ScanWatch 2, the watch platform I worked on."
specs = [
  ["Watch", "ScanWatch 2, nRF52"],
  ["Audio ADC", "Asahi Kasei AK5707"],
  ["Buses", "I2C, I2S"],
  ["Duty cycle", "30 s of every 120 s"],
  ["Battery cost", "15 → 1.7 days"],
]
+++

For a sleep apnea study, Withings wanted snoring detection on an existing smartwatch, the nRF52-based ScanWatch 2. My assigned scope was research and power estimation. I also brought the audio path up in firmware, on my own initiative, because I wanted something testable in a real watch.

**Drivers.** I wrote C drivers for an Asahi Kasei AK5707 low-power audio ADC: I2C for control, I2S for audio, driving an analog microphone. No driver existed, only a register map and closed-source test software. I then adapted the watch firmware to feed an existing Withings snoring-detection model.

<div class="fig-row">{{ <fig file="i2c-bench.jpg" alt="Tektronix oscilloscope showing an I2C burst, probing a breadboard wired to an ST Nucleo board" caption="Bit-banged I2C on the bench." /> }}{{ <fig file="i2s-frames.jpg" alt="Tektronix oscilloscope showing I2S data bursts and the frame clock" caption="Checking I2S frames on the scope." /> }}</div>

**Wake-on-sound.** The AK5707 has an acoustic activity analyzer that can wake the MCU on sound. On its own it was not enough: snoring is a continuous sound, so during snoring it woke the MCU almost constantly. Adding duty cycling fixed that. The analyzer listens 30 s out of every 120 s. This works because snoring lasts longer than one listening window.

| Approach | Battery cost on a 30-day watch |
|---|---|
| Always recording | 15 days |
| Duty cycling alone | 6 days |
| Duty cycling and the acoustic analyzer | 1.7 days, typical night |

**Through a sealed case.** The microphone sits inside a watertight casing. I measured the casing's frequency response, with an enclosed and an open reference mic on the same playback. I chose the filter empirically, by running detection on filtered recordings: a 400 Hz first-order high-pass, plus an adaptive detection threshold. Three people wore the prototype overnight, and I compared its detections against a Withings sleep mat.
