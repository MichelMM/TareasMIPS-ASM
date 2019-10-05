#Maris Mora, Michel
#Soto Pérez, Omar
.data				##reserve 32 byte spaces for 8 variables
original:	.space 32	#reserve space in MIPS memory for original placement of hanoi tower discs.
auxiliar:	.space 32	#reserve space in MIPS memory for auxiliar placement of discs.
destination:	.space 32	#reserve space in MIPS memory for destination placement of hanoi tower discs.
.text
main:		
addi $s0,$zero,3 	#Declare the variable who cointains the number of discs on original hanoi tower (maximum of 8) in this case $s0 
#Next we set a variable who points to the direction of original tower of hanoi
addi $s1,$zero,0x1001	#First we load $s1 with the high part of the address of orginal array
sll  $s1,$s1,16		#Then Shift the high part 16 bits (4 bytes) to the left so it can get to the right place
#The original tower of hanoi is empty, so next step is to fill it up with the $s0 quantity of discs
addi $sp, $sp, 4	#Reserve 4 bytes (1 variable) in the stack
sw $s0, 0($sp)		#Save in the stack the original value of $s0

Fill:			#Fill original tower array with discs values
sw $s0,0($s1)		#Place disc in original
addi $s0,$s0,-1		#Decrease value of disc
addi $s1,$s1,-4		#Get to the next position of original array
bne $s0,$zero, Fill	#Check the value of $s0, if this equals to 0, it means that the number of discs inside the original array is correct
lw $s0, 0($sp)		#Give back to $s0 the original value of discs
addi $sp, $sp,4 	#Clean stack and stop pointing to the top position
Point:			#Next step is to point to the 3 arrays we set, original, auxiliar and destination
addi $s1,$zero,0x1001	#Load $s1 with the high part of the address of orginal array
add $s2, $s1, $zero	#Load $s2 with the high part of the address of orginal array
add $s3, $s1, $zero	#Load $s3 with the high part of the address of orginal array
sll  $s1,$s1,16		#Shift the high part 16 bits (4 bytes) to the left so it can get to first place 0x10010000
sll  $s2,$s2,16		#Shift the high part 16 bits (4 bytes) to the left so it can get to first place 0x10010000
sll  $s3,$s3,16		#Shift the high part 16 bits (4 bytes) to the left so it can get to first place 0x10010000
addi $s2,$s2,0x20	#Add to $s2 0x20 value so it get to auxiliar array 0x10010020
addi $s3,$s3,0x40	#Add to $s2 0x40 value so it get to destanation array 0x10010040
jal Hanoi		#Jump to Hanoi
j exit			#Jump to exit
