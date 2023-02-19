#Author: Michelle Gamba
#Date: 6/23/2021
#Description: Midterm Practice Test - Fibonacci function

.data
msg1: .asciiz "Please enter n: "
msg2: .asciiz "Fibonacci series of 5 numbers is: "
space: .asciiz ", "
.text
main:
	#get n
	li $v0, 4
	la $a0, msg1
	syscall
	#read n
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = n
	
	#display output message
	li $v0, 4
	la $a0, msg2
	syscall

	#$t0 is i
	li $t0, 0		#i = 0
	for_loop:
		beq $t0, $s0, exit	#if i = n exit for loop
		move $a0, $t0		#move i to $a0
		jal fib			#function call Fib(i)
		move $a0, $v0		#move return value to $a0 for printing	
		li $v0, 1
		syscall
		
		#print space between numbers
		la $a0, space
		li $v0, 4
		syscall
		
		addi $t0, $t0, 1	# i = i + 1
		j for_loop		# jump to for loop

		
exit:	
	li $v0, 10
	syscall

fib: 
	#Push use registers into stack
	addi $sp, $sp, -12	#update stack for 2 words
	sw $ra, 0($sp)		#save return address
	sw $a0, 4($sp)		#save the orginal argument
	sw $s0, 8($sp)		#save the orginal argument
	
	#Procedure Body
	beq $a0, $zero, zero 	# if n = 0 then return 0
	
	ble $a0, 2, one_two	# if n /= 0 and it lessthan or equal to 2 go to one_two
	
	#return fib(n-1) + fib(n-2)
	addi $a0, $a0, -1	# n = n - 1
	jal fib			#function call fib(n-1)
	move $s0, $v0		# $s0 = fib(n-1)
	
	lw $a0, 4($sp)		# restore the orginal n
	addi $a0, $a0, -2	# n = n - 2
	jal fib			# fib(n-2)
	
	add $v0, $s0, $v0	# $v0 = fib(n-1) + fib(n-2)
	
	#pop the used registers from the stack
	lw $s0, 8($sp)		
	lw $ra, 0($sp)		
	addi $sp, $sp, 12

	jr $ra
	
	zero:
		#pop the used registers from the stack
		lw $s0, 8($sp)		
		lw $ra, 0($sp)		
		addi $sp, $sp, 12
		
		li $v0, 0		# return 0
		jr $ra
	one_two:
		#pop the used registers from the stack
		lw $s0, 8($sp)		
		lw $ra, 0($sp)		
		addi $sp, $sp, 12	
		
		li $v0,1		#return 1
		jr $ra
		
