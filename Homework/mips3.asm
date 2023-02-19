#Author:MG CS2640
#Date:6/16/2021
#Description: Counter Control loop example/ for loop example

.data
mesg1: .asciiz "\nEnter the value to calculate the sum up to: "
mesg2: .asciiz "The total is: "
.text
main:
	li $s0, 0	# total = 0
	li $t0, 0	# i = 0
	#print the message to read n
	la $a0, mesg1
	li $v0, 4
	syscall
	# read n value
	li $v0, 5
	syscall
	move $t1, $v0	# $t1 value is n
	#for loop
	for_loop:
		beq $t0, $t1, exit	# if i = n then exit
		add $s0, $s0, $t0	# total = total + i
		addi $t0, $t0, 1	# i = i + 1
		j for_loop
		
	exit:
		#print the message of total
		la $a0, mesg2
		li $v0, 4
		syscall
		#Print the value of total
		move $a0, $s0
		li $v0, 1
		syscall
		
		#exit syscall
		li $v0, 10
		syscall
	
	