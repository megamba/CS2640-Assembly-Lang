# Authors:	Thongsavik Sirivong
#		Michelle Gamba
#		Nathan Goshay
#		Alex Lin
#
# Date: 	06/30/2021
# Description:	Hangman game

.data
msg1:		.asciiz "Enter next character (A-Z), or 0 to exit: "
gameSetup:	.asciiz "   |-----|   Word: ________\n   |     |\n         |   Misses:        \n         |\n         |\n         |\n         |\n ---------\n"
msgWelcome:	.asciiz "Welcome to hangman!\n"
msgWinner:	.asciiz "\nYOU WIN!! \n"
msgLoser:	.asciiz "\nYou lost.\n"
msgError:	.asciiz "\nInvalid input. Please try again.\n"
    
hiddenWord:	.asciiz "COMPUTER"    
wordLength:	.word 8
MISSES:		.word 0
HITS:		.word 0
    
.text 
main:
#Print welcome message
	li $v0, 4      	 
	la $a0, msgWelcome  
	syscall         

loop:
#Print game set up 
	li $v0, 4     
	la $a0, gameSetup  
	syscall       

	jal getInput
	move $a0, $v0 #Put the returned character into a0 for checkInput
	jal checkInput
	
	lw $t7, HITS #Get hits count
	add $t7, $t7, $v0 #add new hits count
	sw $t7, HITS 

	beq $v0, $zero, ifMiss #Check char to see if it misses
	j endifMiss #Jump to endifMiss
	ifMiss:     
	jal miss  #if misses, call miss function
	endifMiss:  

	lw $t0, MISSES #Get number of misses
	beq $t0, 6, lose    #max misses = 6

	lw $t0, HITS   #Get number of hits
	lw $t1, wordLength  #Get length of the word
	beq $t0, $t1, win   #win if all the words are guessed right

	j loop #jump back to loop
	endLoop:
	j exit #jump to exit

#Get the user's input
getInput:
#Print message1
	li $v0, 4     
	la $a0, msg1 
	syscall       

deleteNewLine:
	li $v0, 12    #get char input to $v0
	syscall       
	beq $v0, 10, deleteNewLine #Get next char in 
 	move $t0, $v0   #$t0 = input character

	li $v0, 11   #Code for print char
	li $a0, 10   #Char to print newline
 	syscall
 	syscall      #Print new lines

 	beq $t0, '0', exit #If zero, exit program
 	blt $t0, 'A', invalidInput #Check char < A
 	bgt $t0, 'Z', invalidInput #Check char > Z
	j endGetInput #No input error

invalidInput:
	#Print error message
        li $v0, 4         
        la $a0, msgError 
        syscall           
        j getInput	#Jump to getInput

endGetInput:
	move $v0, $t0 #Return character
	jr $ra        
  
#Checking the user's input through hangmang word
checkInput:
	li $v0, 0  #count = 0
	li $t0, 0  #iterator = 0
	lw $t1, wordLength #get the wordLength to check
	la $t7, hiddenWord  #get the hiddenWord to check
	la $t6, gameSetup  #get start address of the game drawing for editing
    
forLoop:
    	beq $t0, $t1, endCheckInput #End for when iterator = word length
    	add $t2, $t0, $t7 #Address of current character
    	lb $t3, 0($t2)    #$t3 = current character
    	beq $t3, $a0, match #Check if input equals current char
    	j repeatForLoop   #Jump to repeatForLoop
    	
#check to see if char are matched, if matched then reveal on the board
match:
	add $t2, $t6, 19 #Address of first char of word in game
	add $t2, $t2, $t0 #Address of char being checked
	lb $t4, 0($t2)   #Char in Game being checked
	bne $t4, $t3, noRepeat #Check if char not already revealed
	j repeatForLoop #jump to repeatForLoop

noRepeat:
	addi $v0, $v0, 1 #count++
        sb $t3, 0($t2)   #shows the character on board

#Repeat the loop function
repeatForLoop:
	addi $t0,$t0, 1 #iterator++
        j forLoop #jump to forLoop
    	endForLoop:

endCheckInput:
 	jr $ra 
 	
win:
	#print game setup
	li $v0, 4     
	la $a0, gameSetup  
	syscall       
	#Print lose message
 	li $v0, 4      
 	la $a0, msgWinner 
 	syscall         
 	j exit          
 		
lose:
  	#print game setup
 	li $v0, 4     
 	la $a0, gameSetup  
 	syscall       
  	#print lose message
	li $v0, 4       
 	la $a0, msgLoser
 	syscall         
 	j exit
 	
#Add missed guess to the board and increments MISSES
miss:
	la $t6, gameSetup  #Grab start address of the game drawing for editing
	lw $t7, MISSES 	    #MISSES ++
	addi $t5, $t6, 59  #Adress of first letter of misses 
	add $t5, $t5, $t7  
	sb $a0, 0($t5)     #Update board with the new misses

    	#Choose which part of the hangman to update
	beq $t7, 0, head
	beq $t7, 1, body
	beq $t7, 2, leftArm
	beq $t7, 3, rightArm
	beq $t7, 4, leftLeg
	beq $t7, 5, rightLeg
	j endHangmanUpdate #jump to endHangmanUpdate

#draw the head
head:
	addi $t5, $t6, 42 #Adress of head character
	li $t4, 79        
	sb $t4, 0($t5)    
	j endHangmanUpdate
#draw the body
body:
	addi $t5, $t6, 71 #Adress of body1 character
	li $t4, 124       
	sb $t4, 0($t5)    
	addi $t5, $t6, 82 #Get address of body2 character
	li $t4, 124       
	sb $t4, 0($t5)    
	j endHangmanUpdate #jump to endHangmanUpdate
      
#draw the left arm
leftArm:
	addi $t5, $t6, 70 #Address of leftArm character
	li $t4, 92        
	sb $t4, 0($t5)    
	j endHangmanUpdate
#draw the right arm
rightArm:
	addi $t5, $t6, 72 #Adress of rightArm character
	li $t4, 47        
	sb $t4, 0($t5)    
	j endHangmanUpdate
#draw the left leg
leftLeg:
	addi $t5, $t6, 92 #Address of leftLeg character
	li $t4, 47        
	sb $t4, 0($t5)    
	j endHangmanUpdate
#draw the right leg
rightLeg:
	addi $t5, $t6, 94 #Address of rightLeg character
	li $t4, 92        
	sb $t4, 0($t5)    
	j endHangmanUpdate
	
endHangmanUpdate:
	addi $t7, $t7, 1 # Misses++
	sw $t7, MISSES #Store new misses count

endMiss:
	jr $ra         

exit:
#exit the program
	li $v0, 10 
	syscall


