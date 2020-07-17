.globl getMatriz
#$a0 -> Direccion de la matriz
#$a1 -> index de la fila
#$a2 -> index de la columna
#$a3 -> buffer para la fila
#$s0 -> buffer para la columna
#retorno
#$v0 -> direccion del buffer lleno

getMatriz:
	addi $sp, $sp, -36
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp)
	sw $t1, 24($sp)
	sw $t2, 28($sp)
	sw $ra, 32($sp)
	
	la $t1, ($a0)
	la $t2, ($a1)
	
	la $a1, ($a3)
	li $a2, ';'
	li $a3, 18
	jal stringSplitBy
	
	la $a0, matrizArray
	li $a1, $t1 ##Reemplazar esto con un parametro
	li $a2, 64
	jal strBufferGet
	
	la $a0, ($v0)
	la $a1, ($s0)
	li $a2, ','
	li $a3, 18
	jal stringSplitBy
	
	la $a0, lineMatriz
	li $a1, $t2 ##Reemplazar esto con un parametro
	li $a2, 64
	jal strBufferGet
		
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp)
	sw $t1, 24($sp)
	sw $t2, 28($sp)
	sw $ra, 32($sp)
	addi $sp, $sp, 36
	
