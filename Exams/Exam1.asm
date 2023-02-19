#Author: Michelle Gamba
#Date: 6/28/2021
#Description: CS2640 Midterm

.data
msg1: .asciiz "Please enter n: "
resultmsg: .asciiz "The result is "
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
	
	#Procedure call
	move $a0, $s0		#move the argument to $a0
	jal A			#call the procedure
	move $s1, $v0		#save return result in $s1
	
	#Print result
	li $v0, 4
	la $a0, resultmsg
	syscall
	
	#printing each result 1 to n
	li $t0, 1		#i = 0
	for_loop:
		beq $t0, $s0, exit	#if i = n exit for loop
		move $a0, $t0		#move i to $a0
		jal A			#function call Fib(i)
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
	#exit
	li $v0, 10
	syscall
	
A: 
	#Push use registers into stack
	addi $sp, $sp, -8	#update stack for 2 words
	sw $ra, 0($sp)		#save return address
	sw $a0, 4($sp)		#save the orginal argument
        
	beq $a0, 1, one		# if n = 1, go to one label
	
	andi $t1, $a0, 0x01	# checking if $a0 even
	beq $t1, $zero, even	# if last digit 0, go to even
	bne $t1, $zero, odd	#if last digit is 1, go to odd
	
	#move $v0, $s1		
	
	 
	#pop the used registers from the stack	
	lw $ra, 0($sp)		
	addi $sp, $sp, 12	
		
	jr $ra
	
	even:
		addi $a0, $a0, -1	# n = n - 1
		jal A			# A(n-1)
		addi $v0, $v0, 1	# $s1 = A(n-1) + 1
		
		jr $ra


	
	odd:	
		addi $a0, $a0, -1	# n = n - 1
		jal A			# A(n-1)
		mul $v0, $v0, 2		# $v0 = A(n-1) * 2
		
		jr $ra

	
	one: 
		#pop the used registers from the stack
		lw $a0, 4($sp)		
		lw $ra, 0($sp)		
		addi $sp, $sp, 8	
		
		li $v0, 1
		jr $ra
		
	
	# Pop value from stack	
	lw $s0, 4($sp)		#restore original n
	lw $ra, 0($sp)		#restore return address
	addi $sp, $sp, 8

	jr $ra
	
	
	
	
