#Retorna un entero equivalente del string pasado por parametro
#a0 direccion del string
#v0 entero equivalente

.globl stringToInt
stringToInt:
	addi $sp, $sp, -44
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)
	sw $t6, 24($sp)
	sw $t7, 28($sp)
	sw $a0, 32($sp)
	sw $a1, 36($sp)
	sw $ra, 40($sp)

	la $t3, ($a0)
	li $t2, 0
	li $t7, 0 
	contarCaracteres:
		li $t0, 0 
		loop:	
			add $t2, $t0, $t3 
			lb $t1, ($t2)
			move $a0, $t1
			jal isDigit
			
			beq $v0, $0, acumulando
			addi $t0, $t0, 1
			j loop
	acumulando:
		addi $t0, $t0, -1
		li $t1, 0 
		li $t2, 10
		move $a2, $t0 
		loop2:	
			slt $t4, $a2, $t1 
			beq $t4, 1, endStringToInt
			
			add $t5, $t1, $t3 
			lb $t6, ($t5)
			addi $t6, $t6, -48 
			
			move $a0, $t2
			move $a1, $t0
			jal powerOf
			
			mul $t4, $v0, $t6
			add $t7, $t7, $t4 
			
			addi $t1, $t1, 1
			addi $t0, $t0, -1
			j loop2
	endStringToInt:
		move $v0, $t7
		
		lw $t0, 0($sp)
		lw $t1, 4($sp)
		lw $t2, 8($sp)
		lw $t3, 12($sp)
		lw $t4, 16($sp)
		lw $t5, 20($sp)
		lw $t6, 24($sp)
		lw $t7, 28($sp)
		lw $a0, 32($sp)
		lw $a1, 36($sp)
		lw $ra, 40($sp)
		addi $sp, $sp, 44
		jr $ra
			
isDigit:
		addi $sp, $sp, -12  
    	sw $t0, 0($sp)
    	sw $a0, 4($sp)
    	sw $ra, 8($sp)
	
	li  $t0, '0'
	bltu   $a0 ,$t0, notdig
	li $t0, '9'
	bltu   $t0 ,$a0, notdig
	
	li $t0, 1
    	move $v0, $t0
	j endIsDigit
    notdig:
	li $t0, 0
    	move $v0, $t0
    endIsDigit:
    	lw $t0, 0($sp)
    	lw $a0, 4($sp)
    	lw $ra, 8($sp)
    	addi $sp, $sp, 12
    	jr $ra
    	
#a0 -> base
#a1 -> exponente
#v0 -> potencia
powerOf:
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $t1, 12($sp)
	li $t1, 1
	bne $a1, 0, while
	
	j exit 
	
	while:
		slt $t0, $0, $a1
		bne $t0, 1, fin
		mul $t1, $t1, $a0  
		addi $a1, $a1, -1
		j while
	fin:
		
	exit:
		move $v0, $t1
		lw $t0, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $t1, 12($sp)
		addi $sp, $sp, 16
		jr $ra