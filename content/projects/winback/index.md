+++
title = "WinBack: first place at TartanHacks 2026"
description = "Capital One sponsor challenge winner at TartanHacks 2026. I wrote the Python backend that settles and logs payouts on the XRP Ledger."
weight = 25
template = "project.html"

[extra]
featured = true
tags = ["Python", "FastAPI", "XRP Ledger", "Hackathon"]
image = "stage.jpg"
image_alt = "Four team members on stage under a screen reading CapitalOne First Place, Bonjour Bombay"
image_caption = "Team Bonjour Bombay on stage at TartanHacks 2026. I'm on the right."
specs = [
  ["Event", "TartanHacks 2026, CMU"],
  ["Award", "1st, Capital One sponsor challenge"],
  ["Team", "4 people"],
  ["My part", "Python and FastAPI backend"],
]
+++

WinBack reinvests credit card cashback into Kalshi prediction markets, with the XRP Ledger as the settlement and audit layer. At the end of each month, users win the money tied to their correct predictions. Only cashback is at stake, so a wrong prediction costs nothing.

Our team, Bonjour Bombay, won first place in the Capital One sponsor challenge at TartanHacks 2026, in February.

**My part was the backend:** an async FastAPI service with a multi-wallet escrow model (company, escrow and per-user wallets), on-chain purchase logging, prediction configuration, and XRP payouts written to transaction memos as an audit trail, on the XRPL testnet. Teammates built the frontend and the Kalshi integration.

The code is at [github.com/ulyssecrn/winback-th-2026](https://github.com/ulyssecrn/winback-th-2026).
