#Author: Michelle Gamba
#Date: 6/22/2021
#Description: Quiz 3
# public int sum(int n, int acc) {
#	if(n > 0) {
#		return sum(n - 1, acc + n);
#	}else {
#		return acc;
#	}
#}

.data
msg1: .asciiz "Please enter n: "
msg2: .asciiz "Please enter acc: "
msg3: .asciiz "The result is: "

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
	
	#get acc
	li $v0, 4
	la $a0, msg2
	syscall
	#read n
	li $v0, 5
	syscall
	move $s1, $v0		#$s1 = acc
	
	#Procedure call
	move $a0, $s0		#move the argument to $a0
	move $a1, $s1		#move the argument to $a1
	jal sum			#call the procedure
	move $s2, $v0		#save return result in $s2
	
	#Print result
	li $v0, 4
	la $a0, msg3
	syscall
	
	move $a0, $s2
	li $v0, 1
	syscall
		
	#exit
	li $v0, 10
	syscall

sum:
	addi $sp, $sp, -12	#update stack for 2 words
	sw $ra, 8($sp)		#save return address
	sw $a1, 4($sp)		#save the orginal argument
	sw $a0, 0($sp)		#save the orginal argument

	#Procedure Body
	#beqz $a0, else		# if n = 0 then go to else 
	#bgtz $a0, if		# if n > 0 then go to if
	slti $t0, $a0, 1	# if n = 0 then $t0 = 1
	beq $t0, $zero, if	# if n > 0 then go to if

	move $v0, $a1		#return value (result)
	addi $sp, $sp, 12
	jr $ra
	
	if:
		add $a1, $a1, $a0	# acc = acc + n
		addi $a0, $a0, -1	# n = n - 1
		jal sum			# sum(n - 1, acc + n)
		

	# Pop value from stack	
	lw $a0, 0($sp)		#restore original n
	lw $a1, 4($sp)		
	lw $ra, 8($sp)		#restore return address
	addi $sp, $sp, 12
	
	#Get result
	jr $ra
	
