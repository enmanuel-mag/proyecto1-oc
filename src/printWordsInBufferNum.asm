#Imprime los elementos de un buffer con numeración
#$a0 direccion del buffer
#$a1 cantidad de elementos
#$a2 indice inicio(0)
.data
sep: .asciiz ". "
bufferPrint: .space 64
.text
.globl printWordsInBufferNum

printWordsInBufferNum:

	addi $sp, $sp, -44
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)
	sw $t6, 24($sp)
	sw $a0, 28($sp)
	sw $a1, 32($sp)
	sw $a2, 36($sp)
	sw $ra, 40($sp)

	li $t0, 0 
	li $t2, 0 
	li $t5, 1
	la $t3, ($a0)
	move $t4, $a1
	move $t7, $a2
	printLoop: 
		slt $t1, $t0, $t4
		bne $t1, 1, todosImpresos 
	if: 
		sll $t2, $t0, 6
		add $a0, $t3, $t2
		
		slt $t1, $t0, $t7
		beq $t1, 1, fueraRango
		slt $t1, $t4, $t0
		beq $t1, 1, fueraRango
		
		
		move $a0, $t5
		li $v0, 1
		syscall

		la $a0, sep
		li $v0, 4
		syscall

		add $a0, $t3, $t2
		la $a1, bufferPrint
		li $a2, ','
		jal stringSection
		#la $a0, ($t5)
		la $a0, ($v0)
		li $v0, 4
		syscall
		jal printLn
		addi $t5, $t5, 1

	fueraRango:		
		addi $t0, $t0, 1
		
		j printLoop
	todosImpresos:
		la $v0, ($a0)
		lw $t0, 0($sp)
		lw $t1, 4($sp)
		lw $t2, 8($sp)
		lw $t3, 12($sp)
		lw $t4, 16($sp)
		lw $t5, 20($sp)
		lw $t6, 24($sp)
		lw $a0, 28($sp)
		lw $a1, 32($sp)
		lw $a2, 36($sp)
		lw $ra, 40($sp)
		addi $sp, $sp, 44
		jr $ra	
