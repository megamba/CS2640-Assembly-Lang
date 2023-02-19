# Authors:	Thongsavik Sirivong
#		Michelle Gamba
#		Nathan Goshay
#		Alex Lin
#
# Date: 	06/30/2021
# Description:	Hangman


.data
secretWord: .asciiz "HANGMAN."
hiddenWord: .asciiz "_______________________"
attemptedChar: .space 6
message1: .asciiz "\nEnter a character (A-Z), or 0 (zero) to exit: "
message2: .asciiz "\nWord: "
message3: .asciiz "\nMisses: "
nextLine: .asciiz "\n"
exit_key: .byte '0'

.text
main:
	lb $s0, exit_key	# $s0 = exit_key
	
	
	
	li $s1, 6		# $s1 = 6 (Note: $s1 is the number of attempts or misses the player has)
	# Loop: terminates if($s1 == 0)
	loop: beqz $s1, end_loop
		# Print message 1
		la $a0, message1
		li $v0, 4
		syscall
		
		# User input: accept a character
		li $v0, 12
		syscall
		move $s2, $v0		# $s2 = input character
		
		# Print nextLine
		la $a0, nextLine
		li $v0, 4
		syscall
		
		# If($s1 == $s0), then exit the loop
		beq $s2, $s0, end_loop
		
		
		move $a1, $s2
		move $a2, $s1
		jal answerCheck
		sub $s1, $s1, $v0	# $s1 = $s1 - $v0
		
		jal printHiddenWord
		
		jal printAttemptedChar
		
		#move $a1, $t0
		#jal printFigure
		
		
		j loop
	end_loop:
	
	li $v0, 10
	syscall


# Procedure answerCheck: Checks if the character entered by the user exist in the string
# Arguments:	$a1 = (a character or letter)
#		$a2 = (the number of attempts left)
# Return:	$v0 = (0 or 1)
answerCheck:
	# Save the orginal registers onto the stack pointer
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	
	la $s0, secretWord	# $s0 = the address of the string secretWord
	lb $s1, 0($s0)		# $s1 = a character of the string secretWord

	la $s2, hiddenWord	# $s2 = the address of the string hiddenWord

	li $v0, 1		# $v0 = assign the return value to 1
	
	for_loop1: beq $s1, '.', end_for1
		
		# If ($s1 != $a1) then skip the following instructions and go to not_mathced
		bne $s1, $a1, not_matched
			sb $s1, 0($s2)		# Store the matched character, entered by the user, to hiddenWord
			li $v0, 0		# $v0 = assign the return value to 0
		not_matched:
		
		addi $s2, $s2, 1	# Increment the $s2 to the next character address of string hiddenWord 
		addi $s0, $s0, 1	# Increment the $s0 to the next character address of string secretWord
		lb $s1, 0($s0)
		
		j for_loop1
	end_for1:
	
	# If ($v0 != 1) then skip the following instuctions and go to dont_add_attempt
	bne $v0, 1, dont_add_attempt
		# If ($v0 == 1), then add the missed character onto the string attemptedChar
		la $s3, attemptedChar	# Load the address of attemptedChar
		li $t0, 6
		sub $t0, $t0, $a2	# $t0 = 6 - $a2 = the offset to the current character address in attemptedChar
		add $s3, $s3, $t0	# $s3 = $s3 + $t0 = set $s3 to the current address of attemptedChar
		sb $a1, 0($s3)		# Store the missed character entered by the user, to attemptedChar
	dont_add_attempt:
	
	# Restore the saved registers from the stack pointers
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra


# Procedure printFigure: Prints the hangman figure
# Arguments:	$a1 = (an integer from 0 to 6)
printFigure:
	beq $a1, 6, figure6
	beq $a1, 5, figure5
	beq $a1, 4, figure4
	beq $a1, 3, figure3
	beq $a1, 2, figure2
	beq $a1, 1, figure1
	beq $a1, 0, figure0
	j exit_figure
	figure6:
		
		j exit_figure
	figure5: 
		
		j exit_figure
	figure4:
		
		j exit_figure
	figure3:
		
		j exit_figure
	figure2:
		
		j exit_figure
	figure1:
		
		j exit_figure
	figure0:
	
		j exit_figure
	exit_figure:
	
	jr $ra


# Procedure printHiddenWrord: print the hidden word in the output
printHiddenWord:
	# Save the orginal registers onto the stack pointer
	addi $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	
	# Print message 2
	la $a0, message2
	li $v0, 4
	syscall
	
	la $s0, secretWord	# $s0 = the address of the string secretWord
	lb $s1, 0($s0)		# $s1 = a character of the string secretWord

	la $s2, hiddenWord	# $s2 = the address of the string hiddenWord
	
	for_loop2: beq $s1, '.', end_for2
		
		lb $a0, 0($s2)
		li $v0, 11
		syscall
		
		addi $s2, $s2, 1	# Increment the $s2 to the next character address of string hiddenWord 
		addi $s0, $s0, 1	# Increment the $s0 to the next character address of string secretWord
		lb $s1, 0($s0)
		
		j for_loop2
	end_for2:
	
	# Print nextLine
	la $a0, nextLine
	li $v0, 4
	syscall
	
	# Restore the saved registers from the stack pointers
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	addi $sp, $sp, 16
	
	jr $ra


# Procedure printAttempts: print the characters attempted on the output
printAttemptedChar:
	# Print message 3
	la $a0, message3
	li $v0, 4
	syscall
	
	la $a0, attemptedChar
	li $v0, 4
	syscall
	
	# Print nextLine
	la $a0, nextLine
	li $v0, 4
	syscall
	
	jr $ra













