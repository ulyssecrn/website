+++
title = "VL53L9CX ToF bring-up and lidar flight model"
description = "Brought up a VL53L9CX ToF sensor on an STM32N6 and retrained a GRU flight model's input layers for it: 90% obstacle avoidance in simulation."
weight = 30
template = "project.html"

[extra]
tags = ["Firmware", "STM32N6", "Embedded ML"]
image = "tof-on-drone.jpg"
image_alt = "A VL53L9 time-of-flight breakout board mounted on a drone frame, with 3V3 and G labels on the wiring"
image_caption = "The VL53L9CX on its breakout, mounted on a drone frame."
specs = [
  ["Sensor", "ST VL53L9CX"],
  ["MCU", "STM32N6, with NPU"],
  ["Bus", "I2C"],
  ["Model", "GRU, input layers retrained"],
]
+++

The drone's flight model runs on an STM32N6, a companion board next to the Betaflight flight controller, and it used sonar to sense obstacles. I moved it to a time-of-flight sensor.

**Sensor bring-up.** I integrated a VL53L9CX ToF sensor over I2C on the STM32N6, adapting ST's drivers, and extended the existing on-NPU inference firmware from sonar to lidar input.

{{ <fig file="steval-vl53l9.jpg" alt="ST STEVAL-VL53L9 evaluation board" caption="ST's VL53L9 evaluation board. Photo: STMicroelectronics." /> }}

## How it works

The N6 runs bare metal, in a single loop. Each pass:

1. Reads a depth frame from the VL53L9CX over I2C, 12 × 10 zones.
2. Asks the flight controller for its attitude and the pilot's sticks over UART, using MSP, Betaflight's serial protocol.
3. Builds the network inputs: the normalized depth frame, the target velocity, an up vector from roll and pitch, and the GRU's hidden state from the previous frame.
4. Runs the model in int8 on the NPU.
5. Turns the output thrust vector into roll, pitch, throttle and yaw, and sends it back to the flight controller as an MSP RC override.
6. Logs telemetry to USB and to onboard flash.

**Safety.** The flight controller keeps arming and failsafe. The N6 only sends commands while the pilot holds the autopilot switch, the GRU state resets every time it engages, and if the sensor drops out, the N6 re-initializes it.

## The flight model

I modified a GRU flight model's input layers for lidar and retrained it in the team's RL framework. Most of that work was simulating the sensor's noise, which is what let the model fly outside, between trees and bushes.

**Sunlight.** I replayed the recordings from outdoor flights and saw sunlight glare in the depth frames. I modeled that glare in the simulator, and the models trained with it performed better outside.

**Results.** In simulation, the retrained model avoided obstacles 90% of the time and held 87% velocity following, which measures how well each simulated drone kept its target velocity between obstacles. On the real drone, it flew for 4 min among cars and trees, mostly without crashing.
