.data
.text
	li $s0,1 #counter = 1;
	li $s1,0 #variable = 0;
dowhile:
	jal suma #saltamos a suma
	div $s1,$s0,4 #variable = counter / 4;
	slti $t1,$s1,20 #variable < 20
	beqz $t1,exit #Terminar ciclo while si la condición no es cumplida
	j dowhile #Reiniciar el ciclo
suma:
	add $s0,$s0,$s0 #counter = suma(counter, counter); 
	jr $ra #salto al valor almacenado en ra, en este caso la línea 7
exit:
