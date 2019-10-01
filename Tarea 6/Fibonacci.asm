.text
	li $v0, 0		#valor resultante n
	li $s0, 6		#número de veces que se realizará fibonacci
	jal Fibonacci		#Entrar en Recursividad de Fibonacci
	j end			#Fin del programa
Fibonacci:				#Función que realiza la recursividad
	addi $sp,$sp, -8 	#Reservamos memoria en el stack para guardar 2 valores
	sw $ra, 0($sp)		#Dirección de retorno dónde se realizó un jump and link
	sw $s0, 4($sp)		#Valor de n para regresar y realizar fibonacci
	slti $t0, $s0, 2	#Comparación para determinar si n es menor a 2
	beq $t0, 1, nMenor	#Entrar en el caso cuándo el valor de n es menor a 2 (1 o 0)
	addi $s0, $s0, -1	#Fibonacci(n-1)
	jal Fibonacci		#Recursividad en Fibonacci
	addi $s0, $s0, -1	#Fibonacci(n-2) 
	jal Fibonacci		#Recursividad en Fibonacci
	j Fiboneccit		#Función que acaba con la recursividad
nMenor:					#Función que agrega el valor total a Fibonacci
	add $v0, $v0, $s0	#Suma al resultado de n, en este caso será 1 o 0
	j Fiboneccit		#ir a Fibonacci sin recursividad
Fiboneccit:				#Función que limpia el stack
	lw $ra, 0($sp)		#Guardamos valor de ra del stack pointer
	lw $s0, 4($sp) 		#Guardamos valor de n en el stack pointer
	addi $sp, $sp, 8	#Limpiamos 2 espacios en el Stack
	jr $ra			#Regresa a la línea que la llamó con jump and link
end: