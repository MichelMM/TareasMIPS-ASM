 .text
	li $s0,0 #int selector = 0; //registro s0
	li $s1,5 #int a = 5; //registro s1
	li $s2,3 #int b = 3; //registro s2
	li $s4,0 #int c = 0; //registro s3
	
	beq $s0,1,suma #case 1
	beq $s0,2,resta #case 2
	beq $s0,3,multiplica #case 3
	j andBitwise #default Case
	
suma:
	add $s4,$s1,$s2 #c = a + b;
	j exit
resta:
	sub $s4,$s1,$s2 #c = a - b;
	j exit
multiplica:
	mul $s4,$s1,$s2 #c = a * b;
	j exit
andBitwise:
	and $s4,$s1,$s2 #c = a & b;
	j exit
exit: #En el caso del código en C creamos una variable nueva c cada que entra en un función, pero debido a que al saltar a una función en el ISA no se pierde el valor del dato podemos cargar automaticamente el valor requerido, en el caso del código en C podríamos inicializar c como una variable global para evirtar declararla al entrar en cada función
