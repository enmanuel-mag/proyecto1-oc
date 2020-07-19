#Imprime un nuevo salto de linea
.globl printLn

printLn:
	addi $sp, $sp, -8
	sw $v0, 0($sp)
	sw $a0, 4($sp)
	
	li $v0, 11
	la $a0, '\n'      
    	syscall
    	
    	lw $v0, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
    	jr $ra