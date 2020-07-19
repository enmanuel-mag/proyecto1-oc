#Imprime los elementos de un buffer
#incluido un salto de linea
#$a0 direccion del buffer
#$a1 cantidad de elementos #funciona bien no se toca
#$a2 item inicio -----------empieza en 0

.globl printWordsInBuffer

printWordsInBuffer:

	addi $sp, $sp, -32
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $a0, 16($sp)
	sw $a1, 20($sp)
	sw $a2, 24($sp)
	sw $ra, 28($sp)
	
#	sll $t0, $a2, 5
#	add $a0, $a0, $t0

	li $t0, 0 #elementos impresos
	li $t2, 0 #puntero del buffer
	la $t3, ($a0)
	printLoop: 
		slt $t1, $t0, $a1
		bne $t1, 1, todosImpresos 
	if: 
		sll $t2, $t0, 6
		add $a0, $t3, $t2
		
		slt $t1, $t0, $a2 #comparacion por piso
		beq $t1, 1, fueraRango
		slt $t1, $a1, $t0#comparacion por techo
		beq $t1, 1, fueraRango
		
		li $v0, 4
		syscall
		jal printLn

	fueraRango:		
		addi $t0, $t0, 1
		j printLoop
	todosImpresos:
		la $v0, ($a0)
		lw $t0, 0($sp)
		lw $t1, 4($sp)
		lw $t2, 8($sp)
		lw $t3, 12($sp)
		lw $a0, 16($sp)
		lw $a1, 20($sp)
		lw $a2, 24($sp)
		lw $ra, 28($sp)
		addi $sp, $sp, 32
		jr $ra	
