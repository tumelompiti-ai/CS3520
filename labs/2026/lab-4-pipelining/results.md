# Lab 4 results

## Step 4: p1-independent

| Processor | Cycles | Instrs. retired | CPI | Execution time |
|---|---|---|---|---|
| SC | 8 | 8 | 1.00 | 6400 ps |
| 5S-U | 12 | 8 | 1.50 | 2400 ps |
| 5S-F | 12 | 8 | 1.50 | 2400 ps |

## Step 6 prediction (5S-U), committed before running

- t2 = 0 (t0 is at distance 2 and t1 at distance 1, so both read 0)
- t3 = -7 (t2 is at distance 1, so it reads 0; t0 is at distance 3, so it reads 7; 0 - 7 = -7)
- t4 = 0 (t2 is at distance 2, so it reads 0)
- t5 = 0 (t3 is at distance 2 and t4 at distance 1, so both read 0)

## Step 6 results: p2-dependent

| Processor | t2 | t3 | t4 | t5 | Cycles | CPI | Correct? |
|---|---|---|---|---|---|---|---|
| SC | 12 | 5 | 24 | 29 | 6 | 1.00 | yes |
| 5S-U | 0 | -7 | 0 | 0 | 10 | 1.67 | no |
| 5S-F | 12 | 5 | 24 | 29 | 10 | 1.67 | yes |
## Step 7 prediction
Minimum nops = 6 (2 between I2 and I3, 2 between I3 and I4, 2 between I5 and I6).
## Step 7: p2-nops.s (6 nops)

| Processor | t2 | t3 | t4 | t5 | Cycles | Instrs. retired | CPI | Correct? |
|---|---|---|---|---|---|---|---|---|
| 5S-U | 12 | 5 | 24 | 29 | 16 | 12 | 1.33 | yes |
| 5S-F | 12 | 5 | 24 | 29 | 16 | 12 | 1.33 | yes |
## Step 8: p2-dependent on 5S-noFW

| Processor | Program | Cycles | Instrs. retired | CPI | Correct? |
|---|---|---|---|---|---|
| 5S-noFW | p2-dependent.s | 16 | 6 | 2.67 | yes |
| 5S-U | p2-nops.s | 16 | 12 | 1.33 | yes |

## Step 9 prediction (p3-loaduse on 5S-F)

Load-use pairs: lw t1 -> add t2 (1 stall), lw t4 -> sub t5 (1 stall). Total stalls = 2.
Cycles = 8 + 4 + 2 = 14.

## Step 10: p3-loaduse

| Processor | t2 (x + y) | t5 (z - w) | Cycles | CPI | Correct? |
|---|---|---|---|---|---|
| SC | 11 | 3 | 8 | 1.00 | yes |
| 5S-U | 0 | 0 | 12 | 1.50 | no |
| 5S-F | 11 | 3 | 14 | 1.75 | yes |