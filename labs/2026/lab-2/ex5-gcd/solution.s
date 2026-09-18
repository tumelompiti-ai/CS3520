.data
a: .word 48
b: .word 18

.text
main:
    la   t0, a
    lw   a0, 0(t0)    # a0 = 48
    la   t0, b
    lw   a1, 0(t0)    # a1 = 18
    jal  ra, gcd      # call gcd
    
    li   a7, 1        # print result
    ecall
    
    li   a7, 10       # exit
    ecall

gcd:
    addi sp, sp, -4
    sw   ra, 0(sp)    # save ra

loop:
    beq  a1, zero, done  # if b == 0, done
    rem  t0, a0, a1      # t0 = a % b
    mv   a0, a1          # a = b
    mv   a1, t0          # b = t0
    j    loop

done:
    lw   ra, 0(sp)    # restore ra
    addi sp, sp, 4
    ret