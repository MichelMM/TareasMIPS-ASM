.data
	vector1: .word 1 2 3 #Creación del arreglo Vector1
	vector2: .word 6 7 8 #Creación del arreglo Vector2
	results: .word 0     #Creación del arreglo Results
.text
	la $a0, vector1 #Adress de Vector1
	la $a1, vector2 #Adress de Vector2
	la $a2, results #Adress de Results
	li $s0, 3 #k
	li $s1, 0 #i
	li $s2, 0 #acc
for:	#No es necesario declarar main ya que la única función importante dentro de esta era el ciclo for y la declaración de variables, las cuales ya han sido declaradas fuera
	slt $t0,$s1,$s0	#comparación i < k
	beqz $t0,exit #salida en el caso falso
	jal multAndAccumulate #Jump a funcíón multandAccumulate guardando la dirección original
	addi $s1,$s1,1 #i++
	j for 
	 
multAndAccumulate:
	addi $sp,$sp,-4 #Liberamos un espacio en el Stack Pointer
	sw $ra,0($sp) #Se guarda dirección almacenada en ra por jal de for línea 16
	li $s4,0 #mulRes
	li $s5,0 #result
	lw $t1,0($a0)#vector1[i]
	lw $t2,0($a1)#vector2[i]
	lw $t3,0($a2)#Results[i]
	mul $s4,$t1,$t2 #mulRes = vector1[i] * vector2[i]
	jal Acumulate #Jump a funcíón Acumulate guardando la dirección original
	add $s5,$s5,$s6 #result = Acumulate(acc, mulRes)
	sw  $s5,0($a2) #Result[i] guardado en su correspondiente posición de memoria
	addi $a0,$a0,4 #vector1[i++]
	addi $a1,$a1,4 #vector2[i++]
	addi $a2,$a2,4 #Results[i++]
	lw $ra,0($sp) #recuperamos la dirección anteriormente almacenada en ra de for
	addi $sp,$sp,4 #Subimos el Stack pointer 1 posición ya que acaba de ser utilizada
	jr $ra #jump a la direccion de ra, en este caso, linea 16
Acumulate:
	li $s6,0 #suma
	add $s6,$s2,$s4 #suma = a + b
	jr $ra #jump a la direccion de ra, en este caso, linea 29
	
exit:
