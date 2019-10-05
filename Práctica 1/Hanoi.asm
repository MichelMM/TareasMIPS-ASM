.data				##reserve 32 byte spaces for 8 variables
original:	.space 32	#reserve space in MIPS memory for original placement of hanoi tower discs.
destination:	.space 32	#reserve space in MIPS memory for destination placement of hanoi tower discs.
auxiliar:	.space 32	#reserve space in MIPS memory for auxiliar placement of discs.
.text
main:		
addi $s0,$zero,3 	#Declare the variable who cointains the number of discs on original hanoi tower (maximum of 8) in this case $s0 
