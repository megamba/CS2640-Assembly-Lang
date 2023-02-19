#Author: MG Cs2640
#Date: 6/16/2021
#Description: on my own, nested for loop

.data
mesg1: .asciiz "\nEnter number for n:"
mesg2: .asciiz "Enter number for m:"
mesg3: .asciiz "The sum is: "
.text
main: 
	li $s0, 0	# sum = 0
	li $t0, 1	# i = 1
	li $t1, 1	# j = 1
	#print message to get n
	la $a0, mesg1
	li $v0, 4
	syscall
	#read n
	li $v0, 5
	syscall
	move $t2, $v0	# $t2 value is n
	
	#print message to get m
	la $a0, mesg2
	li $v0, 4
	syscall
	#read m
	li $v0, 5
	syscall
	move $t3, $v0	# $t3 value is m
	
	for_loop_i:
		beq $t0, $t2, exit	# if i = n then exit
		li $t1, 1 		# j = 1
		for_loop_j:
			beq $t1, $t3, exit_j	# if j = m then exit j loop
			add $s0, $s0, $t0	# sum = sum + i
			add $s0, $s0, $t1	# sum = sum + i + j
			
			addi $t1, $t1, 1	# j = j + 1
			j for_loop_j 		#return to j loop
		exit_j: 
			addi $t0, $t0, 1	# i = i + 1
			j for_loop_i
		
	exit:
		#print the message of sum
		la $a0, mesg3
		li $v0, 4
		syscall
		#Print the value of sum
		move $a0, $s0
		li $v0, 1
		syscall
		
		#exit syscall
		li $v0, 10
		syscall
	
		