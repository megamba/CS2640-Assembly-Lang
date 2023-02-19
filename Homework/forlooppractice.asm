#Author: Michelle Gamba
#Date: 6/27/2021
#Description: Midterm Practice
#int func (int arg){
# int v = 1, i;
# for (i = 1 ; i <= arg ; i++) {
# v = v * i;
# }
# return v;
# }
.data
msg1: .asciiz "Please enter argument number: "
msg2: .asciiz "The final result is "

.text
main:
	#get arg
	li $v0, 4
	la $a0, msg1
	syscall
	#read arg
	li $v0, 5
	syscall
	move $s0, $v0		#$s0 = arg
	
	li $t0, 1		# i = 1
	li $t1, 1		# v = 1
	
	for_loop:
		bgt $t0, $s0, exit	# if i > arg then exit
		
		mul $t1, $t1, $t0	# v = v * i
		addi $t0, $t0, 1	# i = i + 1
		j for_loop
		
exit:
		#print the message of total
		la $a0, msg2
		li $v0, 4
		syscall
		#Print the value of total
		move $a0, $t1
		li $v0, 1
		syscall
		
		#exit syscall
		li $v0, 10
		syscall
