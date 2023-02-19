#Author: CS2640
#Date: 6/21/2021
#Description: Procedure call Example
# int leaf_example(int g, h, i, j){
# int f;
# f = (g + h} - (i +j);
# return f;
#}

.data
msg1: .asciiz "Please enter g: "
msg2: .asciiz "Please enter h: "
msg3: .asciiz "Please enter i: "
msg4: .asciiz "Please enter j: "
msg5: .asciiz "The result is: "

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
	
	#get i
	li $v0, 4
	la $a0, msg3
	syscall
	#read i
	li $v0, 5
	syscall
	move $s2, $v0		#$s2 = i
	
	#get j
	li $v0, 4
	la $a0, msg4
	syscall
	#read j
	li $v0, 5
	syscall
	move $s3, $v0		#$s3 = j
	
	#pass the values to argument registers
	move $a0, $s0		# $a0 = g
	move $a1, $s1		# $a1 = h
	move $a2, $s2		# $a2 = i
	move $a3, $s3		# $a3 = j
	

	#call the procedure
	jal leaf_example
	
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
	
	
leaf_example:
	#push the save values into the stack
	addi $sp $sp, -4	#update the stack pointer to save $s0
	sw $s0, 0($sp)		#save $s0 on stack
	
	#Procedure Body
	add $t0, $a0, $a1	# $t0 = g + h
	add $t1, $a2, $a3	# $t1 = i + j
	sub $s0, $t0, $t1	# $s0 = (g+h) - (i+j)
	
	#return value (result)
	move $v0, $s0
	
	#pop the saved values from stack
	lw $s0, 0($sp)		#restore $v0
	addi $sp, $sp, 4
	
	#jump to return address
	jr $ra