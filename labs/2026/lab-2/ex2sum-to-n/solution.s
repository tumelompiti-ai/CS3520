.data
N: .word 10

.text
main:
    la   t0, N        # load address of N
    lw   t1, 0(t0)    # t1 = N
    li   t2, 0        # sum = 0
    li   t3, 1        # i = 1

loop:
    bgt  t3, t1, done # if i > N, exit
    add  t2, t2, t3   # sum += i
    addi t3, t3, 1    # i++
    j    loop

done:
    mv   a0, t2       # a0 = sum
    li   a7, 1        # print integer
    ecall

    li   a7, 10       # exit
    ecall