+++
title = "Riddle: carrying a couch up the stairs"
description = "Two people carry a couch up a flight of stairs, one at each end. Who carries more of the weight?"
date = 2026-10-09
template = "note.html"

[extra]
kind = "Riddle"
+++

Two people carry a couch up a flight of stairs, one at each end, both holding it from below and pushing straight up. Who carries more of the weight?

<details>
<summary>Answer</summary>

**The person below**, but not for the reason most people give.

If the couch were a thin plank held at its two ends, the split would be 50/50 at any angle. Tilting it shortens both horizontal lever arms by the same factor, cos θ, so the torques still balance in the middle.

A real couch is thick. Its center of mass sits some height h above the line between the two pairs of hands. Tilt it by θ and the center of mass moves horizontally toward the lower end, by h sin θ. Taking torques about the lower hands, with L the distance between the hands and W the weight:

- Person above: W × (1/2 − (h/L) tan θ)
- Person below: W × (1/2 + (h/L) tan θ)

For a 2 m couch with its center of mass 40 cm above the hands, on stairs at 35°, the person below carries about 64% of the weight. The steeper the stairs and the bulkier the couch, the worse it gets for them.
</details>
