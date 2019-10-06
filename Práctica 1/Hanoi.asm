#Maris Mora, Michel
#Soto Pérez, Omar
.data				#reserve 32 byte spaces for 8 variables
original:	.space 32	#reserve space in MIPS memory for original placement of hanoi tower discs.
auxiliar:	.space 32	#reserve space in MIPS memory for auxiliar placement of discs.
destination:	.space 32	#reserve space in MIPS memory for destination placement of hanoi tower discs.
.text
main:	
addi $s0,$zero,8 	#Declare the variable who cointains the number of discs on original hanoi tower (maximum of 8) in this case $s0 
addi $t0,$zero,1	#Register with value of one to make a comparion in hanoi
#Next we set a variable who points to the direction of original tower of hanoi
addi $s1,$zero,0x1001	#First we load $s1 with the high part of the address of orginal array
sll  $s1,$s1,16		#Then Shift the high part 16 bits (4 bytes) to the left so it can get to the right place
#The original tower of hanoi is empty, so next step is to fill it up with the $s0 quantity of discs
addi $sp, $sp, 4	#Reserve 4 bytes (1 variable) in the stack
sw $s0, 0($sp)		#Save in the stack the original value of $s0

Fill:			#Fill original tower array with discs values
sw $s0,0($s1)		#Place disc in original
addi $s0,$s0,-1		#Decrease value of disc
addi $s1,$s1,4		#Get to the next position of original array
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

Hanoi:
addi $sp,$sp,-20	#Reserve 20 bytes space (4 registers) in the stack
sw $ra,0($sp)		#Save $ra from line 34 once and other ones in line 55 and 64
sw $s0,4($sp)		#Save in $s0 Actual value of disc
sw $s1,8($sp)		#Save $s1 who contains original array 
sw $s2,12($sp)		#Save $s2 who contains auxiliar array
sw $s3,16($sp)		#Save $s3 who contains destination array
bne $s0,$t0, RecursivityCase	#Check		$s0!=1
#In diferent case
sw $zero,0($s1)		#Clear disc 1 from original array
sw $s0,0($s3)		#Move disc 1 to destination array
j Hanexit		#Jump to Hanexit

RecursivityCase:	#Line 44 condition $s0!=1
addi $s1,$s1,4		#Move from disc in original array
addi $s0,$s0,-1		#Decrease the value of actual disc
lw $s2,16($sp)		#Load $s2 with destination address
lw $s3,12($sp) 		#Load $s3 with auxiliar address
jal Hanoi		#Recursivity to Hanoi
lw $s3,16($sp)		#Load $s3 with destination address
addi $s1,$s1,-4		#Move the position of the disc moved in org
lw $t1,0($s1)		#Load $t2 with the disc contained in origin 
sw $t1,0($s3) 		#Save $t2 value in destination
sw $zero,0($s1)		#Clear disc contained  in original array
addi $s3,$s3,4		#Move to next position in destination array
lw $s1,12($sp)		#Load $s1 with auxiliar address
lw $s2,8($sp)		#Load $s2 with original address
jal Hanoi		#Recursivity to Hanoi number 2

Hanexit:
lw $ra,0($sp)		#Load $ra saved in $ra
lw $s0,4($sp)		#Load $s0 saved in $s0
lw $s1,8($sp)		#Load $s1 with original array address
addi $sp,$sp,20		#Clean the stack from values taken before and also not used values
jr $ra			#Jump to $ra saved in stack

exit: