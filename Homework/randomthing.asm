.data
.text
        # passing the argument 10 to the function A()
        li $a0, 10
        jal A
        move $s0 , $v0
        
        # printing the value returned from the function
        li $v0 , 1
        move $a0 , $s0
        syscall
        
        # exiting the program
        li $v0 , 10
        syscall

# defining the function A()
A:
        # setup the stack contents 
        sub $sp , $sp , 8
        sw $ra , ($sp)    # save the return address
        sw $s0, 4($sp)    # save the value of $s0 
        
        # save the value of 1 into the $v0 register and check for base case
        li $v0 , 1
        beq $a0, 1 , base
        
        # call the recursive function A(n-1)
        move $s0 , $a0
        sub $a0 , $a0 , 1
        jal A
        
        # this is the body of the function
        # check if the value of n is even or odd
        and $s1 , $s0 , 1
        beq $s1 , 0 , even
        beq $s1 , 1 , odd
# if it is even add 1 to the previous result    
even:   add $v0 , $v0 , 1
        j base
# if it is odd multiply the previous result by 2
odd:    mul $v0 , $v0 , 2
        j base
# base condition
base:
        # remove the stack contents
        lw $ra , ($sp)
        lw $s0 , 4($sp)
        add $sp , $sp , 8
        jr $ra