#Author: CS2640 - Michelle Gamba
#Date: 6/19/2021
#Description : HW2 
# int array ={2,5,1, 9, 30, 4, 25, 10, 40, 56, 23, 17, 8, 3, 6}
# Write MIPS code to sort the data in the table above from highest to lowest. 
# print the sorted table the highest value in the smallest array location. 
# Use a minimum number of MIPS instructions.

.data
Array: .word 2,5,1, 9, 30, 4, 25, 10, 40, 56, 23, 17, 8, 3, 6
count: .word 10
.text
main:
	la $
	#for loop
	for_loop:
		beq $t0, $t1, exit	# if i = n then exit
		add $s0, $s0, $t0	# total = total + i
		addi $t0, $t0, 1	# i = i + 1
		j for_loop
