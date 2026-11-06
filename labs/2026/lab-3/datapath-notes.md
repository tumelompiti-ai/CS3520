# Lab 3 - Datapath Notes

## Step 4 - Trace Questions

### 1. lui vs auipc
Both are U-type, same format, same immediate field.
The difference is the first ALU input.
- lui: ALU Op1 = 0, so result = 0 + (imm << 12) = imm << 12
- auipc: ALU Op1 = PC, so result = PC + (imm << 12)
Example from trace: lui t4, 0x2b = 176128, auipc t5, 0 at PC=0x14 = 20.
The element that makes the difference is the ALU Op1 mux / source select.

### 2. sw never writes a register
sw has RegWrite = 0.
It has MemWrite = 1, so it writes to Data Memory, not to the Register File.
Control signal that shows it: RegWrite = 0.

### 3. beq vs bne - same registers, one jumps, one doesn't
t0 = 12, t1 = 5.
- beq t0, t1: 12 != 5, branch unit output = 0, pc_src = 0, no jump
- bne t0, t1: 12 != 5, branch unit output = 1, pc_src = 1, jump

Trace: Registers -> Branch Unit. Branch Unit uses funct3 to pick the
condition (beq = equal, bne = not equal).
Then: pc_src = Branch (control signal = 1 for branch) AND Branch Unit output.
Gates: Branch Unit comparator + AND gate -> pc_src mux select.
pc_src = 0 means PC+4, pc_src = 1 means branch target.

### 4. jal / jalr save return address
Both write PC+4 to rd (ra = x1 = 0x38 in our run).
The input of the write-back mux that supplies it is the 3rd input: PC+4.
Write-back mux inputs are: 0 = ALU result, 1 = Memory read data, 2 = PC+4.
For jal/jalr, MemToReg / write-back select = 2.

## Step 6 - Differences from Textbook Datapath

### A. No dedicated branch adder
Branch target is NOT computed by a separate adder.
It is computed by the main ALU: ALU Res = PC + (imm << 1 / sign-extended imm).
In Ripes, the ALU is reused for branch-target calculation.

### B. No ALU Zero flag for beq
There is a separate Branch Unit, not a Zero flag.
Zero can only say equal / not equal.
The Branch Unit can do: beq, bne, blt, bge, bltu, bgeu -
signed and unsigned less-than / greater-or-equal comparisons.
That is why it is needed.

### C. Write-back mux has 3 inputs, not 2
Textbook has 2: ALU result and Memory data.
Ripes has 3: ALU result, Memory data, and PC+4.
The 3rd input is for jal / jalr to save the return address.