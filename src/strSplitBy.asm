#Retorna un buffer con copias de elementos encontrados 
#dividos por un separador 
#$a0 -> Direccion del string
#$a1 -> direccion del buffer para los elementos(quemado)
#$a2 -> separator char
#$a3 -> numero de elementos a copiar
#retorno
#$v0 -> direccion del buffer lleno
#$v1 -> elementos copiados

.globl stringSplitBy
stringSplitBy:

	addi $sp, $sp, -36
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $t0, 16($sp)
	sw $t1, 20($sp)
	sw $t2, 24($sp)
	sw $t3, 28($sp)
	sw $ra, 32($sp)
	
	li $t0, 0 #cantidad de elemetnos copiados
	li $t2, 0 #indice del buffer
	la $t3, ($a1) #respaldo la direccion del buffer
	while:
		slt $t1, $t0, $a3
		beq $t1, $0, elementosCopiados
		
		sll $t2, $t0, 6 	#nuevo indice del buffer (multiplo de 4)
		add $a1, $t3, $t2	#preparo la nueva direccion
		jal stringSection
		#preparo la sgt llamda
		la $a0, ($v1)	#avanza la direccion del string
		addi $t0, $t0, 1 #aumento en 1 los elementos copiados
		#addi $t2, $t2, 1 #avanza el indice del buffer
		j while
	elementosCopiados:
		la $v0, ($t3) #direccion del buffer donde estan todos los elementos
		move $v1, $t0 #total de elementos copiados 
		
		lw $a0, 0($sp)
		lw $a1, 4($sp)
		lw $a2, 8($sp)
		lw $a3, 12($sp)
		lw $t0, 16($sp)
		lw $t1, 20($sp)
		lw $t2, 24($sp)
		lw $t3, 28($sp)
		lw $ra, 32($sp)
		addi $sp, $sp, 36
		jr $ra
	
