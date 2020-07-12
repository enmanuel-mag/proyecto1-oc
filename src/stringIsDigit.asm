.globl strIsDigit

strIsDigit:
	addi $sp, $sp, -24  #(6*4)
    	sw $t0, 0($sp)
    	sw $t1, 4($sp)
    	sw $t2, 8($sp)
    	sw $t3, 12($sp)
    	sw $a0, 16($sp)
    	sw $ra, 20($sp)
    
    	la $t0, ($a0) #copio la direccion de a0
    	li $t3, 0 #indice del char iterado
    	li $t2, 1 #de entrada asumo que es digit
    do:
    	# obtener el valor
    	add $t1, $t3, $t0
    	lb $t1, 0($t1)
    	move $a0, $t1  	
    while:
    	jal isDigit
    	and $t2, $t2, $v0
    	beq $v0, 0, endStrIsDigit
    	
    	addi $t3, $t3, 1
    	j do
    endStrIsDigit:
    	move $v0, $t2
    	
    	lw $t0, 0($sp)
    	lw $t1, 4($sp)
    	lw $t2, 8($sp)
    	lw $t3, 12($sp)
    	lw $a0, 16($sp)
    	lw $ra, 20($sp)
    	addi $sp, $sp, 24
    	
    	jr $ra
 
isDigit:
	#Reservar memoria
    	addi $sp, $sp, -12  #(1*4)
    	sw $t0, 0($sp)
    	sw $a0, 4($sp)
    	sw $ra, 8($sp)
	
	li  $t0, '0'
	bltu   $a0 ,$t0, notdig        # Jump if char < '0'
	li $t0, '9'
	bltu   $t0 ,$a0, notdig       # Jump if '9' < char
	
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