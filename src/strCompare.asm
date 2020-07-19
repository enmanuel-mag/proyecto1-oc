# Retorna 1 ó 0 si los strings pasados por parametros son iguales
#$a0 -> direccion string 1
#$a1 -> direccion string 2
#$v0 -> 1 ó 0
.globl stringCompare
stringCompare:
	addi $sp, $sp, -20
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $t0, 8($sp)
	sw $t1, 12($sp)
	sw $ra, 16($sp)

	cmploop:
	lb      $t0,($a0)                   
	lb      $t1,($a1)                   
	bne     $t0,$t1,cmpne               
	
	beq     $t1,$zero,cmpeq             
	
 	addi    $a0,$a0,1                   
	addi    $a1,$a1,1                   
	j cmploop	

	cmpne:
	li $v0, 0
	j endStringCompare

	cmpeq:
	li $v0, 1

	endStringCompare:
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr $ra
