# Author: Michelle Gamba
# Date: 06/16/2021
# Description: Quiz 2 submission 
# if(f == g)
#    A[4] = f + g;
# else if(f == h)
#    A[4] = A[4] + 4;
# else
#    A[i] = g - h;

.data
arr: .space 24    # arr[6]
f: .word 1
g: .word 8
h: .word 3
i: .word 2
J: .word 5   


.text
main:
    lw $s0, f    # load registers
    lw $s1, g
    lw $s2, h
    lw $s3, i
    lw $s4, J
    li $s5, 4


    addi $s6, $zero, 0    # array index
    beq $s0, $s1, ifthen  # if(f == g)
    beq $s0, $s2, elif    # if(f == h)
    j else

    j exit

    ifthen: 
        addi $s6, $s6, 16    # adds 16 to index so we can access A[4]
        add $t1, $s0, $s1    # A[4] = f + g; -> $t1 will be our temp register
        sw $t1, arr($s6)

        j exit            # exit the if statement

    elif:
        # A[4] = A[h] + 4
        addi $s6, $s6, 16
        sw $t3, arr($s6)    # $t3 = A[4]
        li $s6, 0     # $s6 = 0

        mult $s5, $s2        # array index
        add $s6, $s6, $s5    # $s6 = 4 * index
        addi $t4, $t2, 4    # A[h] + 4
        sw $t4, arr($t3)    # store A[4]

        j exit            # exit the if statement

    else:
        # A[i] = g - h
        mult $s5, $s3        # array offset
        sub $t3, $s1, $s2
        sw $t3, arr($s5)    # A[i] = $t3
        addi $s6, $s6, 4    # index += 4

        j exit            # exit the if statement


    exit:
        # stop the program
        li $v0, 10
        syscall