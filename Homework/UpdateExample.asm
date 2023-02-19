#Author: CS2640
#Date: 6/21/2021
#description: on my own MIPS translation with procedure call

.data
a: .word 1
b: .word 0
c: .word 0
msg1: .asciiz "Please enter g: "
msg2: .asciiz "Please enter h: "
msg3: .asciiz "Please enter k: "
msg4: .asciiz "Please enter m: "
msg5: .asciiz "b = "
msg6: .asciiz "c = "
.text
main:
	#get g
	li $v0, 4
	la $a0, msg1
	syscall
	#read g
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = g
	
	#get h
	li $v0, 4
	la $a0, msg2
	syscall
	#read h
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = h
	
	#get k
	li $v0, 4
	la $a0, msg3
	syscall
	#read k
	li $v0, 5
	syscall
	move $s2, $v0		#$s2 = k
	
	#get m
	li $v0, 4
	la $a0, msg4
	syscall
	#read m
	li $v0, 5
	syscall
	move $s3, $v0		#$s3 = m
	
	lw $a0, a
	
	if:
		beq $a0, 0, then
		bne $a0, 0, else 
	then:
		#pass the values to argument registers
		move $a0, $s0		# $a0 = g
		move $a1, $s1		# $a1 = h
		
		#call procedure
		jal leaf_procedure
		
		#restore the return value
		move $s0, $v0
	
		#print the result
		li $v0, 4
		la $a0, msg5
		syscall
	
		move $a0, $s0
		li $v0, 1
		syscall
	
		#exit the code
		li $v0, 10
		syscall
	
		
	else: 
		#pass the values to argument registers
		move $a0, $s2		# $a0 = k
		move $a1, $s3		# $a1 = m
		
		jal leaf_procedure
		
		#restore the return value
		move $s0, $v0
	
		#print the result
		li $v0, 4
		la $a0, msg6
		syscall
	
		move $a0, $s0
		li $v0, 1
		syscall
	
		#exit the code
		li $v0, 10
		syscall
		
leaf_procedure:
	#push the save values into the stack
	addi $sp $sp, -4	#update the stack pointer to save $s0
	sw $s0, 0($sp)		#save $s0 on stack
	
	#Procedure Body
	add $t0, $a0, $a1 	#a1 +a2
	sll $t1, $a1, 4 	#a2<<4
	sub $s2, $t0, $t1 	# -
	
	#return value (result)
	move $v0, $s2
	
	#pop the saved values from stack
	lw $s0, 0($sp)		#restore $v0
	addi $sp, $sp, 4
	
	#jump to return address
	jr $ra