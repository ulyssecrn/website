+++
title = "Production-line vision for U-Scan"
description = "Python and OpenCV defect checks on a Raspberry Pi station, deployed on the production line in China, then a TensorFlow Lite autoencoder back in Paris."
weight = 20
template = "project.html"

[extra]
role = "Industrialization Engineering Intern"
dates = "September 2024 to January 2025"
tags = ["Computer vision", "Edge ML", "Raspberry Pi", "Manufacturing"]
image = "cleanroom.jpg"
image_alt = "Me in a full cleanroom suit, mask and shoe covers, giving a thumbs up"
image_caption = "Suited up at the factory in China."
specs = [
  ["Product", "Withings U-Scan"],
  ["Station", "Raspberry Pi"],
  ["Software", "Python, OpenCV, TensorFlow Lite"],
  ["Deployed", "Factory in China, preproduction"],
]
+++

U-Scan is Withings' at-home urine analysis device. It reads test strips inside a cartridge, and every cartridge goes past a vision station on the production line.

{{ <fig file="u-scan.jpg" alt="Withings U-Scan, an at-home urine analysis device, shown open" caption="U-Scan. Photo: Withings." /> }}

## The vision station

I extended the line's Raspberry Pi vision station with new checks in Python and OpenCV, to catch cartridge defects the existing station missed:

- **YCbCr channel tests** on the cartridge images.
- **A bubble check** for the integrity of the cartridge seal.

## Preproduction in China

I flew to the manufacturing site in China, alone, for the preproduction run, which lasts about a week. I worked with engineers I had only met on video calls, and few people on the line spoke English or French.

- Before production started, I went through every station to anticipate failures.
- Once the line was running, I kept a schedule for improving the stations not in use that day, and reserved time every day for anything that could block production.
- I diagnosed one station's failing script on the spot: a Python package issue.
- The new checks caught defect types nobody had seen in the lab.

It taught me to design with how something will be built and tested at scale in mind.

## Back in Paris

After the trip, I added a TensorFlow Lite autoencoder for anomalous strips to the Pi station.

I also built a Pi-controlled jig for battery-life stress testing. It simulated daily device use with a pump and measured current draw.
