#author: Michelle Gamba
#Date: 6/23/2021
#Dynamic memory

.data
msg1: .asciiz "Please enter the array size:"
msg2: .asciiz "Please enter the element " 


.text
main:
	#display message to get array size
	la $a0, msg1
	li $v0, 4
	syscall
	#read array size
	li $v0, 5
	syscall
	move $s0, $v0		# $s0 = array size
	
	sll $s1, $s0, 2		# $s0 = $s0*4

	#allocate memory
	move $a0, $s0		# move the number of bytes to $a0
	li $v0, 9
	syscall
	
	move $s2, $v0		# move the base address of the array to $s2
	
	#$t0 is i
	li $t0, 0		# i = 0
	for_loop:
		beq $t0, $s0, exit	# if i = n then exit
		#display mesg
		la $a0, msg2
		li $v0, 4
		syscall
		#read 
		li $v0, 5
		syscall
		
		#compute the effective memory address
		sll $t1, $t0, 2		# $t1 = i + 4 (offset)
		add $t2, $t1, $s2	#$t2 = offset + base address
		sw $v0, 0($t2)		#save new address $t2
		
		addi $t0, $t0, 1	# i = i + 1

		j for_loop
		
	exit:		
		#exit syscall
		li $v0, 10
		syscall
