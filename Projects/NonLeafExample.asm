#Author: CS2640
#Date: 6/21/2021
#Description: Non Leaf Procedure Example
# int fact(int n){
# if (n<1){
# return f;
#} else{
# return n + fact(n-1);
#}
.data
msg1: .asciiz "Please enter n: "
msg2: .asciiz "The result is: "
msg3: .asciiz "\nEnter -1 to exit"

.text
main:
	#get c
	li $v0, 4
	la $a0, msg3
	syscall
	#read c
	li $v0, 5
	syscall
	move $s7, $v0		#$s7 is the user choice to exit
	
	beq $s7, -1, exit	#if c = -1, exit else continue
	
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
	jal fact		#call the procedure
	move $s1, $v0		#save return result in $s1
	
	#Print result
	li $v0, 4
	la $a0, msg2
	syscall
	
	move $a0, $s1
	li $v0, 1
	syscall
	j main			#jump to main
exit:	
	#exit
	li $v0, 10
	syscall

fact: 
	addi $sp, $sp, -8	#update stack for 2 words
	sw $ra, 4($sp)		#save return address
	sw $a0, 0($sp)		#save the orginal argument
	
	#Procedure Body
	slti $t0, $a0, 1	# if n < 1 then $t0 = 1
	beq $t0, $zero, L1	# if n > 1 then go to L1
 
	addi $v0, $zero, 1 	#if n < 1 then fact = 1
	addi $sp, $sp, 8
	jr $ra
	
	L1:
		addi $a0, $a0, -1	# n = n - 1
		jal fact		# fact(n-1)
	# Pop value from stack	
	lw $a0, 0($sp)		#restore original n
	lw $ra, 4($sp)		#restore return address
	addi $sp, $sp, 8
	#Get result
	mul $v0, $a0, $v0 	# $v0 = n*fact(n-1)
	jr $ra
	
