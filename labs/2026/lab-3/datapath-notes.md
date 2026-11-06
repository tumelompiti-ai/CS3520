# Lab 3 - Datapath Notes

## Step 2 - Think
The third write-back input is PC+4. jal and jalr cannot work without it, because PC+4 is the return address written to rd.

## Step 3 - Think
data_mem.addr is alu.res (0x11 for the add), because the ALU output also feeds the memory address. It is harmless because wr_en = 0 and data_out is ignored (the write-back mux selects ALURES). It costs time: the clock period must cover ALU + memory for every instruction, because lw needs that path.

## Step 4 - Trace Questions

### 1. lui vs auipc
Both are U-type, same format, same immediate field.
The element that makes the difference is the ALU operand-1 mux (alu_op1_src).
- lui: op1 is not the PC (constant 0), so result = 0 + (imm << 12) = imm << 12
- auipc: op1 = PC, so result = PC + (imm << 12)
Example from trace: lui t4, 0x2B = 176128. auipc t5, 0 at PC = 0x14 gives 20.

### 2. sw never writes a register
The signal is reg_do_write = 0 (RegWrite = 0).
The write-back mux still outputs a value (the ALU result), but it is not committed to the register file because the write enable is 0.
sw instead has data_mem wr_en = 1, so it writes to data memory.

### 3. beq vs bne - same registers, one jumps, one doesn't
t0 = 12, t1 = 5.
- beq t0, t1: 12 != 5, branch unit output = 0, pc_src select = 0, no jump
- bne t0, t1: 12 != 5, branch unit output = 1, pc_src select = 1, jump

Path: registers -> Branch unit (condition chosen by funct3) -> AND gate (with the branch control signal) -> OR gate (with the jump signals) -> pc_src select.
pc_src = 0 selects PC+4. pc_src = 1 selects the branch target.

### 4. jal / jalr save return address
Both write PC+4 to rd (ra = x1).
The PC+4 input (the 3rd input) of the write-back mux supplies it.
The ALU cannot supply it because it is busy computing the jump target. Data memory cannot supply it because it only returns loaded data.

## Step 5 - Statistics
Instructions listed: 18. Retired: 17. Cycles: 17. CPI: 1.00. IPC: 1.
The listed count is 18 because the pseudo-instruction la expands to two instructions (auipc + addi). The instruction at 0x30 (addi x12, x0, 99) is never executed, because bne jumps over it.

Think: CPI is already 1.00, so the design sacrificed Tc (the clock period). Tc must cover the slowest instruction path (lw: instruction fetch, register read, ALU, data memory, register write), so it is several times longer than the slowest single stage. The exact factor comes from the Week 7 worked-exercise delays.

## Step 6 - Differences from Textbook Datapath

### A. No dedicated branch adder
The branch target is computed by the main ALU: ALU Res = PC + imm. The immediate generator supplies the offset, and alu_op1_src selects the PC instead of a register.
Gained: no second adder, so less hardware and area.

### B. Separate Branch unit instead of the ALU Zero flag
The Zero flag can only say equal or not equal. The Branch unit compares rs1 and rs2 directly, so it handles beq, bne, blt, bge, bltu and bgeu (signed and unsigned).
Gained: all six branch types, and the ALU stays free to compute the branch target at the same time.

### C. Write-back mux has 3 inputs, not 2
The textbook has two inputs: ALU result and memory data. This design adds PC+4, used by jal and jalr to save the return address.
Gained: jal and jalr can write the return address without using the ALU, which is busy computing the jump target.

### Trade-off (shared ALU vs dedicated adder)
Using the ALU for branch targets saves area, but it needs a separate comparator and ties up the ALU during branches. A dedicated adder costs more hardware but computes the target in parallel with the ALU, which suits pipelined designs. Choose the shared ALU when area is tight, and the dedicated adder when speed matters.