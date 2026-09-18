.data
arr: .word 1, 2, 3, 4, 5, 6
n:   .word 6

.text
main:
    la   t0, arr      # t0 = base address of array
    la   t1, n
    lw   t1, 0(t1)    # t1 = n
    li   t2, 0        # count = 0
    li   t3, 0        # i = 0

loop:
    bge  t3, t1, done # if i >= n, exit
    lw   t4, 0(t0)    # t4 = arr[i]
    andi t5, t4, 1    # t5 = arr[i] & 1
    bne  t5, zero, skip # if odd, skip
    addi t2, t2, 1    # count++

skip:
    addi t0, t0, 4    # next element
    addi t3, t3, 1    # i++
    j    loop

done:
    mv   a0, t2       # a0 = count
    li   a7, 1        # print integer
    ecall

    li   a7, 10       # exit
    ecall