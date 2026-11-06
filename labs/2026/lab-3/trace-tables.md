### Step 3 - add

| Element | Port | Prediction | Actual |
| --- | --- | --- | --- |
| pc_reg | out | 0x00000008 | 0x00000008 |
| pc_4 | out | 0x0000000C | 0x0000000C |
| instr_mem | data_out | 0x006283B3 | 0x006283B3 |
| decode | r1 / r2 | 5 / 6 | 5 / 6 |
| decode | wr | 7 | 7 |
| registerFile | r1_out / r2_out | 12 / 5 | 12 / 5 |
| alu_op1_src | out | 12 | 12 |
| alu_op2_src | out | 5 | 5 |
| alu | res | 17 | 17 |
| data_mem | wr_en | 0 | 0 |
| reg_wr_src | select / out | 0 / 17 | 0 / 17 |
| pc_src | select / out | 0 / 0x0000000C | 0 / 0x0000000C |

### Step 4 - All classes

| Instruction | PC | Pred alu res | Actual alu res | Pred reg_wr_src | Actual reg_wr_src | Pred pc_src | Actual pc_src |
| --- | --- | --- | --- | --- | --- | --- | --- |
| addi x5, x0, 12 | 0x00 | 12 |  | 0 / 12 |  | 0 |  |
| addi x6, x0, 5 | 0x04 | 5 |  | 0 / 5 |  | 0 |  |
| add x7, x5, x6 | 0x08 | 17 | 17 | 0 / 17 | 0 / 17 | 0 | 0 |
| sub x28, x5, x6 | 0x0C | 7 | 7 | 0 / 7 | 0 / 7 | 0 | 0 |
| lui x29, 0x2b | 0x10 | 176128 |  | 0 / 176128 |  | 0 |  |
| auipc x30, 0x0 | 0x14 | 0x00000014 | 0x00000014 | 0 / 0x00000014 | 0 / 0x00000014 | 0 | 0 |
| lw | 0x18 | address | address | 1 / Mem | 1 / Mem | 0 | 0 |
| sw | 0x1C | a0 + 4 | a0 + 4 | ignored | ignored | 0 | 0 |
| beq | 0x20 | - | - | - | - | 0 | 0 |
| bne | 0x24 | - | - | - | - | 0 | 0 |
| jal | 0x28 | target | target | 2 / PC+4 | 2 / PC+4 | 1 | 1 |
| jalr | 0x2C | target | target | 2 / PC+4 | 2 / PC+4 | 1 | 1 |

