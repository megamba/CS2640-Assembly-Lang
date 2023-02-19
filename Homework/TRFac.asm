#Author: Michelle Gamba
#Date: 6/27/2021
#Description: more midterm pratcie on my own
#
#int TRFac(int	n, int accum){	
#if(n==0)		
#	 return	accum;	
#else		
#	return	TRFac(n	– 1, n *	 accum);	
#}	


.data
msg1: .asciiz "Please enter n: "
msg2: .asciiz "Please enter accum: "
resultmsg: .asciiz "The result is "

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
	
	#get accum
	li $v0, 4
	la $a0, msg2
	syscall
	#read accum
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = accum
	
	#Procedure call
	move $a0, $s0		#move the argument to $a0
	move $a1, $s1		#move the argument to $a1
	jal TRFac		#call the procedure
	move $s2, $v0		#save return result in $s2
	
	#Print result
	li $v0, 4
	la $a0, resultmsg
	syscall
	
	move $a0, $s2
	li $v0, 1
	syscall

exit:	
	#exit
	li $v0, 10
	syscall

TRFac:
	addi $sp, $sp, -12	#update stack for 2 words
	sw $ra, 0($sp)		#save return address
	sw $a0, 4($sp)		#save the orginal argument
	sw $a1, 8($sp)
	
	#Procedure Body
	bne $a0, $zero, L1	# if n /= 0 then go to L1
 
	move $v0, $a1		#return value (result)
	
	L1:
		addi $a0, $a0, -1	# n = n - 1
		mul $a1, $a1, $a0	# n * accum
		jal TRFac		# fact(n-1)
		
	# Pop value from stack	
	lw $a1, 8($sp)
	lw $a0, 4($sp)		#restore original n
	lw $ra, 0($sp)		#restore return address
	addi $sp, $sp, 12
	
	jr $ra
