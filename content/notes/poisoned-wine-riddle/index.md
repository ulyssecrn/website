+++
title = "Riddle: 1,000 bottles and one is poisoned"
description = "One bottle out of 1,000 is poisoned, and rats can test them. How few rats do you need? A riddle about binary encoding."
date = 2026-10-09
template = "note.html"

[extra]
kind = "Riddle"
+++

A king has 1,000 bottles of wine for a party tomorrow. One of them is poisoned. The poison takes about a day to act, so there is only time for one round of tests, and even a drop is lethal. Rats can taste the wine. What is the smallest number of rats that finds the poisoned bottle in time?

<details>
<summary>Answer</summary>

**10 rats.**

Number the bottles from 0 to 999 and write each number in binary. 10 bits are enough, because 2¹⁰ = 1024. Give each rat one bit: rat k drinks a drop from every bottle whose number has a 1 in bit k.

The next day, write a 1 for each dead rat and a 0 for each live one. That 10-bit number is the poisoned bottle.

With 50 bottles, 6 rats are enough, because 2⁶ = 64. It is the same idea as an address bus, where n lines select one of 2ⁿ locations.

**Bonus:** with time for two rounds, each rat has three possible outcomes: it dies after the first round, dies after the second, or survives. Write the bottle numbers in base 3 instead. A rat drinks in round one for a digit 1, in round two for a digit 2, and never for a 0. Since 3⁷ = 2187, 7 rats are enough.
</details>
