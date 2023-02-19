#Author: CS2640
#Date:6/16/2021
#Description: syscall examples

.data
mesg0: .asciiz "\nPlease enter your choice,(-1 to exit):"
mesg1: .asciiz "\nPlease enter the first number: "
mesg2: .asciiz "\nPlease enter the second nummber: "
mesg3: .asciiz "\nThe result of the addition is: "

.text
main:
#print message
la $a0, mesg0
li $v0,4
syscall

# read userchoice id it is -1 exit
li $v0, 5
syscall
move $s0, $v0

loop: beq $s0, -1 , exit#if the input is -1 then go to exit
# while i != -1
 
    # print message to get the first number
    la $a0, mesg1
    li $v0, 4
    syscall
    
    # read the first number 
    li $v0, 5
    syscall 
    move $t0, $v0
    
    # print message to get the second number
    la $a0, mesg2
    li $v0, 4
    syscall
    # read the second number
    li $v0,5
    syscall
    move $t1, $v0
    
    # do addition 
    add $t2, $t0, $t1
    
    # print result message
    la $a0, mesg3
    li $v0, 4
    syscall
    # print the result
    move $a0, $t2
    li $v0, 1
    syscall
    #print message
    la $a0, mesg0
    li $v0,4
    syscall

    # read userchoice id it is -1 exit
    li $v0, 5
    syscall
    move $s0, $v0
    j loop    #loop back to beq
    

exit:    li $v0 , 10
    syscall