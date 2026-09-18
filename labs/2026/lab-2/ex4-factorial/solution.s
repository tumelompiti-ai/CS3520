.data
N: .word 5

.text
main:
    la   t0, N
    lw   a0, 0(t0)    # a0 = N (argument)
    jal  ra, factorial # call factorial
    
    mv   a0, a0       # result already in a0
    li   a7, 1        # print integer
    ecall
    
    li   a7, 10       # exit
    ecall

factorial:
    addi sp, sp, -8   # allocate stack
    sw   ra, 4(sp)    # save return address
    sw   s0, 0(sp)    # save s0
    
    mv   s0, a0       # s0 = n
    li   t0, 1        # result = 1
    li   t1, 2        # i = 2

loop:
    bgt  t1, s0, done # if i > n, exit
    mul  t0, t0, t1   # result *= i
    addi t1, t1, 1    # i++
    j    loop

done:
    mv   a0, t0       # return result in a0
    lw   ra, 4(sp)    # restore return address
    lw   s0, 0(sp)    # restore s0
    addi sp, sp, 8    # deallocate stack
    ret