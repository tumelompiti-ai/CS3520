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

## Step 4 (Think questions)

1. Why do 5S-U and 5S-F give identical numbers for p1?
No instruction in p1 reads a register that an earlier instruction writes (all the addi instructions use zero as their source). So there are no data hazards. The forwarding unit and the hazard detection unit never have anything to do on this program, and both processors take 12 cycles for 8 instructions.

2. Has pipelining made p1 slower, since CPI is 1.50 on 5S-F against 1.00 on SC?
No. CPI is only cycles per instruction, and it ignores how long each cycle is. Execution time = cycles x clock period.
SC: 8 cycles x 800 ps = 6400 ps.
5S-F: 12 cycles x 200 ps = 2400 ps.
The pipeline finishes p1 in 2400 ps against 6400 ps, a speedup of 6400 / 2400 = about 2.67. The CPI is above 1 only because of the 4 cycles needed to fill the pipeline, and with a short program like this they weigh heavily. The pipeline's much shorter clock period more than makes up for it.