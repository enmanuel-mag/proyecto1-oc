.data
lineMatriz: .space 18
columnMatriz: .space 18
uno: .asciiz "1"
cero: .asciiz "0"
medio: .asciiz "0.5"
dos: .asciiz "2"

.globl getMatriz
#$a0 -> Direccion de la matriz
#$a1 -> index de la fila
#$a2 -> index de la columna
#retorno
#$l0 -> numero flotante correspondiente a la posicion indexada

getMatriz:
	addi $sp, $sp, -44
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 12($sp)
	sw $t1, 16($sp)
	sw $t2, 20($sp)
	sw $t3, 24($sp)
	sw $t4, 28($sp)
	sw $t5, 32($sp)
	sw $t6, 36($sp)
	sw $ra, 40($sp)
	
	li $t1, $a1
	li $t2, $a2
	
	la $a1, lineMatriz
	li $a2, ';'
	li $a3, 18
	jal stringSplitBy
	
	la $a0, lineMatriz
	li $a1, $t1 
	li $a2, 64
	jal strBufferGet
	
	la $a0, ($v0)
	la $a1, columnMatriz
	li $a2, ','
	li $a3, 18
	jal stringSplitBy
	
	la $a0, columnMatriz
	li $a1, $t2 
	li $a2, 64
	jal strBufferGet
	
	la $t0, ($v0)
	
	la $t3, cero
	la $t4, uno
	la $t5, medio
	la $t6, dos
	
	la $a0, ($v0)
	
	la $a1, cero
	jal stringCompare
	beq $v0, 1, returnCero
	
	la $a1, medio
	jal stringCompare
	beq $v0, 1, returnMedio
	
	la $a1, uno
	jal stringCompare
	beq $v0, 1, returnUno
	
	la $a1, dos
	jal stringCompare
	beq $v0, 1, returnDos
	
returnCero:
	l.s 0.0
	j exit
returnMedio:
	l.s 0.5
	j exit
returnUno:
	l.s 1.0
	j exit
returnDos:
	l.s 2.0
	j exit
	
exit:
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 12($sp)
	lw $t1, 16($sp)
	lw $t2, 20($sp)
	lw $t3, 24($sp)
	lw $t4, 28($sp)
	lw $t5, 32($sp)
	lw $t6, 36($sp)
	sw $ra, 40($sp)
	addi $sp, $sp, 44
	
