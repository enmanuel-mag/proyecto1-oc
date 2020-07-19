# Retorna 1 ó 0 si el string del parámetro esta compuesto por digitos 
#$a0 -> direccion de string
#$v0 -> 1 si todo el string esta compuesto por digitos, 0 caso contrario.

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
    	
		add $t1, $t3, $t0
    	lb $t1, 0($t1)
    	beq $t1, 13, endStr
    	beq $t1, 10, endStr
    	
    	move $a0, $t1  	
    while:
    	jal isDigit
    	and $t2, $t2, $v0
    	beq $v0, 0, endStrIsDigit
    	
    	addi $t3, $t3, 1
    	j do
    endStr:
    	bne $t3, 0, endStrIsDigit
    	andi $t2, $t2, 0
    	
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
