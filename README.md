# Stocks Commission & Charges Calculator
This CLI tool calculates the commissions and charges that apply when purchasing shares. Built primarily for my IS stocks module.

Charges considered:
- Brokerage fee
- Clearing fee
- Trading Access Fee
- Government Service Tax (Singapore)

## Running
For example, when purchasing 3500 shares at $3.80 each:
```shell
$ ruby main.rb -b 3.80 -q 3500

Brokerage Fee = $36.575
Clearing Fee = $4.3225
Trading Access Fee = $0.9975
GST = $2.9326500000000006
Total = $13344.83
```