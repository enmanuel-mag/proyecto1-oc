#$a0 -> direccion string 
#$a1 -> Copybuffer
#$a2 -> Caracter hasta el cual buscar: caracteres $zero -> \0 ; \n
#$v0 -> direccion del string copiado
#$v1 -> direccion despues de haber encontrado el separdor 
.globl stringSection

stringSection:####################No se puede copiar un string de exceda la capacidad de un registro
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
		lb      $t0,($a0)                   # get next char from str1
		
		beq     $t0,$a2,separadorEncontrado    # encontro el separador
		beq     $t0,$t2,finalDeLinea           # enter caracter (0d)
		beq     $t0,$zero,separadorEncontrado  # final del string (0) nunca debe salir
		
		sb      $t0, ($a1)                   # store next char to $t1
	
	 	addi    $a0,$a0,1                   # point to next char
	 	addi    $a1,$a1,1                   # point to next char
		j copyCharLoop
	finalDeLinea:
		addi    $a0,$a0,1	
		
	separadorEncontrado:
		addi    $a0,$a0,1       # me salto el nullo y entrego la nueva direccion
		sb      $0, ($a1)       # store 0\ fin de string
		la $v0, ($t1)		#retorna la direccion del string coppia
		la $v1, ($a0)		#retorna la direccion del string original avanzado 1 caracter
	
		lw $a0, 0($sp)
		lw $a1, 4($sp)
		lw $a2, 8($sp)
		lw $t0, 12($sp)
		lw $t1, 16($sp)
		lw $t2, 20($sp)
		lw $ra, 24($sp)
		addi $sp, $sp, 28
		jr $ra
