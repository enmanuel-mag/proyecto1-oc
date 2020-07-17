.data
lineMatriz: .space 1152
columnMatriz: .space 1152

uno: .asciiz "1"
fUno: .float 1.0

cero: .asciiz "0"
fCero: .float 0.0

medio: .asciiz "0.5"
fMedio: .float 0.5

dos: .asciiz "2"
fDos: .float 2.0

.text
.globl getFactor
#$a0 -> Direccion de la matriz
#$a1 -> index de la fila
#$a2 -> index de la columna
#retorno
#$f10 -> numero flotante correspondiente a la posicion indexada

getFactor:
	addi $sp, $sp, -40
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $t1, 12($sp)
	sw $t2, 16($sp)
	sw $t3, 20($sp)
	sw $t4, 24($sp)
	sw $t5, 28($sp)
	sw $t6, 32($sp)
	sw $ra, 36($sp)
	
	
	
	move $t1, $a1
	move $t2, $a2
	
	la $a1, lineMatriz
	li $a2, ';'
	li $a3, 18
	jal stringSplitBy
	
	la $a0, lineMatriz
	move $a1, $t1 
	li $a2, 64
	jal strBufferGet
	
	la $a0, ($v0)
	la $a1, columnMatriz
	li $a2, ','
	li $a3, 18
	jal stringSplitBy
	
	la $a0, columnMatriz
	move $a1, $t2 
	li $a2, 64
	jal strBufferGet
		
	li $t0, 0
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
	l.s $f10, fCero
	j exit
returnMedio:
	l.s $f10, fMedio
	j exit
returnUno:
	l.s $f10, fUno
	j exit
returnDos:
	l.s $f10, fDos
	j exit
	
exit:
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $t1, 12($sp)
	lw $t2, 16($sp)
	lw $t3, 20($sp)
	lw $t4, 24($sp)
	lw $t5, 28($sp)
	lw $t6, 32($sp)
	lw $ra, 36($sp)
	addi $sp, $sp, 40
	jr $ra
	
