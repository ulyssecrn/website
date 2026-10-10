+++
title = "On-device knee moment inference"
description = "A ~90k-parameter knee moment model I trained, running in about 2 ms on the Teensy 4.1 that runs the exoskeleton's control loop. On the bench so far."
weight = 10
template = "project.html"

[extra]
status = "In progress"
tags = ["Embedded ML", "Firmware", "Teensy", "Real-time"]
image = "wearing.jpg"
image_alt = "Looking down at my knee wearing the exoskeleton: thigh cuff, knee motor and electronics box"
image_caption = "Wearing the lab's knee exoskeleton."
specs = [
  ["MCU", "Teensy 4.1, Cortex-M7, 600 MHz"],
  ["Model", "Streaming TCN, 90,241 parameters"],
  ["Inputs", "14: knee encoder, thigh and shank IMUs"],
  ["Output", "Knee moment, Nm/kg"],
  ["Rates", "100 Hz inference, 1 kHz control"],
]
+++

The knee exoskeleton's high-level control runs on a Jetson. The goal of this project is to run knee moment estimation on the Teensy 4.1 that runs the low-level control loop instead, and eventually drop the round trip to the Jetson.

**The model.** A streaming causal temporal convolutional network: 4 residual blocks, 64 channels, dilations 1, 2, 4 and 8, so each output sees the last 0.61 s of data at 100 Hz. It takes 14 inputs, the knee encoder angle and velocity plus the accelerometers and gyroscopes of IMUs on the thigh and shank, and estimates the biological knee moment in Nm per kg of body mass. I trained it, using the lab's general TCN architecture, on treadmill walking data recorded on this exoskeleton, with motion capture and inverse dynamics as ground truth.

**On the Teensy.** A Python code generator turns the model into dependency-free C++ that processes one sample at a time with ring buffers, with no TensorFlow Lite Micro. Around it I wrote the input normalization, sensor input assembly that matches the training data, 100 Hz inference that the 1 kHz control interrupt can preempt, an on-boot self-test against reference outputs, and per-step logging. I also sped up the generated convolution code by copying the weights into on-chip RAM and reordering the inner loop, and that change was later adopted in the generator.

**Status.** Bench only. It runs on a real Teensy 4.1 with synthetic inputs. It has not run with the real sensors yet, has not been worn, and its accuracy has not been validated on the device. The torque path is written but defaults to zero torque.

## Bench numbers

Teensy 4.1, synthetic inputs:

- **1.93 ms** mean inference step, 1.99 ms max, out of a 10 ms budget.
- The 1 kHz control loop held 1000 Hz while inference ran, with no missed inference ticks over 1793 steps.
- Outputs match the PyTorch reference within 3.2e-7 Nm/kg on a replayed on-device log.
- About 390 KB of RAM and 400 KB of flash for the model.

**Next:** real sensors, on-body tests, validation against motion capture, and a hardware emergency stop for untethered use.
