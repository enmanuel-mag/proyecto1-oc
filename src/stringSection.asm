#Retorna la direccion de la copia de un string
#desde el inicio de la direccion hasta la posición de un separador
#$a0 -> direccion string 
#$a1 -> Copybuffer
#$a2 -> Caracter hasta el cual buscar: caracteres $zero -> \0 ; \n
#$v0 -> direccion del string copiado
#$v1 -> direccion despues de haber encontrado el separdor 
.globl stringSection

stringSection:
	addi $sp, $sp, -28
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $t0, 12($sp)
	sw $t1, 16($sp)
	sw $t2, 20($sp)
	sw $ra, 24($sp)
	
	la $t1, ($a1)
	li $t2, 13
	copyCharLoop:
		lb      $t0,($a0)                   
		
		beq     $t0,$a2,separadorEncontrado    
		beq     $t0,$t2,finalDeLinea           
		beq     $t0,$zero,separadorEncontrado  
		
		sb      $t0, ($a1)                   
	
	 	addi    $a0,$a0,1                   
	 	addi    $a1,$a1,1                   
		j copyCharLoop
	finalDeLinea:
		addi    $a0,$a0,1	
		
	separadorEncontrado:
		addi    $a0,$a0,1  
		   
		sb $s0, ($a1)  
		la $v0, ($t1)		
		la $v1, ($a0)		
	
		lw $a0, 0($sp)
		lw $a1, 4($sp)
		lw $a2, 8($sp)
		lw $t0, 12($sp)
		lw $t1, 16($sp)
		lw $t2, 20($sp)
		lw $ra, 24($sp)
		addi $sp, $sp, 28
		jr $ra
