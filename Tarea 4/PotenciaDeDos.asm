.text
    li $a0,8 #n con el valor que potencia
    li $a1, 2 #Valor que se potenciara, en este caso 2
    jal PotenciaDeDos #Saltar a PotenciaDeDos guardando la proxima dirección en ra	
    j exit
    
PotenciaDeDos:
    slti $t0, $a0, 1 #Comparar si n es mayor a 1
    beq $t0, $zero, Recursividad #entrar cuando n es mayor a 1
    li $v0 1 #Asignar a v0 el valor de 1
   jr $ra #Regresar al valor de ra asignado
Recursividad:
	addi $sp, $sp, -8 #Reservar 2 espacios para el Stack
	sw $ra, 4($sp) #Guardado el valor de ra
	sw $a0, 0($sp) #Guardosmos los valores con los que cuenta n
	addi $a0, $a0, -1 #n--;
	jal PotenciaDeDos #Volver a comparar hasta que n = 1
	lw $a0, 0($sp) #Tomamos del stack el primer valor a multiplicar
	lw $ra, 4($sp) #Tomamos del stack el valor de la siguiente dirección que fue guardada en ra
	addi $sp, $sp, 8 #Limpiamos los espacios reservados del Stack
	mul $v0, $a1 , $v0  #Multiplicación principal para obtener 2 potencia n
	jr $ra #rRegresar a PotenciaDeDos
exit: