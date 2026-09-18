# Encoding Analysis — B-type and J-type Instructions

## Branch Instruction (B-type)
Instruction: blt x8, x6, 16
Address: 0x3c
32-bit encoding: 0x00644463

Binary: 0000 0000 0110 0100 0100 0100 0110 0011

Field breakdown (B-type):
- imm[12]   = 0        (bit 31)
- imm[10:5] = 000000   (bits 30:25)
- rs2       = 00110    (bits 24:20) = x6
- rs1       = 01000    (bits 19:15) = x8
- funct3    = 100      (bits 14:12) = blt
- imm[4:1]  = 1000     (bits 11:8)
- imm[11]   = 0        (bit 7)
- opcode    = 1100011  (bits 6:0)

Offset = 16 bytes forward (to <done> label)

## Jump Instruction (J-type)
Instruction: jal x0, -12
Address: 0x48
32-bit encoding: 0xff5ff06f

Binary: 1111 1111 0101 1111 1111 0000 0110 1111

Field breakdown (J-type):
- imm[20]    = 1        (bit 31)
- imm[10:1]  = 1111010110 (bits 30:21)
- imm[11]    = 1        (bit 20)
- imm[19:12] = 11111111 (bits 19:12)
- rd         = 00000    (bits 11:7) = x0
- opcode     = 1101111  (bits 6:0)

Offset = -12 bytes (jumps back to <loop> label)

## Why are the immediate bits scattered?

The immediate bits are stored in non-contiguous positions so that
the register fields (rs1, rs2, rd) stay in the SAME bit positions
across ALL instruction formats. This means the hardware can read
the register numbers before it even knows which instruction it is,
simplifying and speeding up the decode stage of the pipeline.