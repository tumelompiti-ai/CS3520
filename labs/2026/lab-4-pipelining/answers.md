# Lab 4 answers

## Step 1
(a) Single-cycle clock period = 200 + 100 + 200 + 200 + 100 = 800 ps. lw uses all five stages, so it sets the period.
(b) Pipelined clock period = 200 ps (the slowest single stage).
(c) Latency of one lw: single-cycle = 800 ps; pipelined = 5 x 200 = 1000 ps.
(d) Time for 1,000,000 instructions:
    single-cycle = 1,000,000 x 800 ps = 800,000,000 ps
    pipelined = 1,000,004 x 200 ps = 200,000,800 ps
    speedup = 800,000,000 / 200,000,800 = approx 4.0
(e) The speedup is 4, not 5, because the stage delays are unbalanced and the slowest stage (200 ps) sets the clock for every stage. Making one stage faster does not shorten the clock unless it is a 200 ps stage (IF, EX or MEM) and all the others are sped up too.

## Step 2
(a) The first instruction finishes in cycle 5; the last (8th) in cycle 12.
(b) Cycles = k + N - 1. For k = 5 this is N + 4. CPI = (N + 4) / N.
(c) (N + 4) / N < 1.05 gives 4 / N < 0.05, so N > 80. N = 80 gives exactly 1.05, which is not below it, so N = 81.
(d) In cycle 5: WB = addi t0, MEM = addi t1, EX = addi t2, ID = addi t3, IF = addi t4.