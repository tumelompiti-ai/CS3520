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
## Step 5(c)
On a pipeline without forwarding, a RAW dependence at distance 1 or 2 is a hazard. At distance 3 or more the register file has already been written (written in the first half of the cycle, read in the second), so there is no hazard.

## Step 6
(a) Prediction on 5S-U, committed before running: t2 = 0, t3 = -7, t4 = 0, t5 = 0.
(b) See results.md. SC and 5S-F are correct. 5S-U is wrong in t2, t3, t4 and t5. Predicted values matched the measured values.
(c) The negative value is t3 = -7 (0xfffffff9). I4 (sub t3, t2, t0) read t0 correctly: I1 is 3 instructions earlier, so t0 = 7 had already been written to the register file. But I4 read t2 too early: I3 is only 1 instruction earlier and had not reached WB, so t2 was still 0. The result was 0 - 7 = -7.
## Step 7
(a) The minimum is 6 nops. The dependences at distance 1 are I2->I3, I3->I4 and I5->I6, and each needs 2 nops between the pair to reach distance 3. These are three separate gaps, so no nop can serve two of them. If I remove any one nop, one pair is left at distance 2, which is a hazard on 5S-U, and the program gives a wrong result.
(b) On 5S-F, p2-nops.s takes 16 cycles. The nops do no useful work there: forwarding already handles every hazard in p2, so the nops are just 6 wasted cycles (the original p2 takes 10).
(c) p2-nops on 5S-U has CPI 16 / 12 = 1.33, lower than the original p2 on 5S-F (10 / 6 = 1.67), but it takes 16 cycles against 10. Both can be true because the nops count as retired instructions: they add to the instruction count and pull the CPI down without doing any useful work. CPI alone cannot compare two different programs, because the instruction counts differ. Execution time (cycles x clock period) can.
## Step 8
(a) p2 on 5S-noFW takes 16 cycles, the same as p2-nops.s on 5S-U. The hazard detection unit did by hardware what I did by hand in Step 7: it held the dependent instruction in ID and sent bubbles down the pipeline (6 stall cycles in total, 2 each for I3, I4 and I6) until the producer had written back. The program stayed at 6 instructions, so the CPI is 16 / 6 = 2.67 instead of 1.33, because stall cycles are not retired instructions.
(b) Forwarding paths on 5S-F: I3 reads t1 via EX/MEM -> EX, I3 reads t0 via MEM/WB -> EX, I4 reads t2 via EX/MEM -> EX, I4 reads t0 from the register file (no forwarding needed), I5 reads t2 via MEM/WB -> EX, I6 reads t3 via MEM/WB -> EX, I6 reads t4 via EX/MEM -> EX.

Think: why does RISC-V require the hardware to guarantee correct results, instead of leaving it to the compiler?
p2-nops.s only works because it has exactly the right number of nops for a 5-stage pipeline with no forwarding. On a machine with a seven-stage pipeline, results would be written back later, so the same program would have distances that are too short and would give wrong results. It would need recompiling for every processor. If the hardware guarantees correctness, one binary runs correctly on every implementation, old or new, and the hardware only spends extra cycles where a hazard really exists.
## Step 9
Prediction on 5S-F: 2 load-use stalls (lw t1 -> add t2, and lw t4 -> sub t5), so cycles = 8 + 4 + 2 = 14. Committed before running.

## Step 10
Measured: 14 cycles on 5S-F, matching the prediction. SC takes 8 cycles (CPI 1.00); 5S-U takes 12 cycles and gives wrong results (t2 = 0, t5 = 0), because it has no stall or forwarding.
The add t2, t0, t1 is held back in ID for one cycle (cycle 5 in my numbering, which is cycle 4 in Ripes). The instruction held behind it is lw t3, 8(gp), which stays in IF for that cycle. The same happens a second time with sub t5, t3, t4, and the sw behind it is held in IF.
