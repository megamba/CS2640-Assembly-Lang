#Author: Michelle CS 2640
#Date: 6/16/2021
#Description: While loop example

.data
msg1: .asciiz "\nEnter an integer or -1 to exit: "
msg2: .asciiz "You entered: "

.text
main:
	#print message to get the input
	la $a0, msg1
	li $v0, 4
	syscall
	#read the input
	li $v0, 5
	syscall
	move $s0, $v0 #here the input is in $s0
	loop:
		beq $s0, -1, exit
		#print the output message
		la $a0, msg2
		li $v0,4
		syscall
		
		move $a0, $s0
		li $v0, 1
		syscall
		
		#get input again!
		#print message to get the input
		la $a0, msg1
		li $v0, 4
		syscall
		#read the input
		li $v0, 5
		syscall
		move $s0, $v0 #here the input is in $s0
		j loop
	exit:
		li $v0, 10
		syscall
		