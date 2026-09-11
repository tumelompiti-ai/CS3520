.data
a: .word 15
b: .word 9

.text
main:
    la   t0, a        # load address of a
    lw   t1, 0(t0)    # t1 = a
    la   t0, b        # load address of b
    lw   t2, 0(t0)    # t2 = b

    bge  t1, t2, print_a  # if a >= b, print a
    
    # print b
    mv   a0, t2
    j    print

print_a:
    mv   a0, t1

print:
    li   a7, 1        # ecall 1 = print integer
    ecall
    
    li   a7, 10       # ecall 10 = exit
    ecall