#Retorna el indice donde se encuentra el string dentro del buffer
#a0-> Direccion del buffer(String)
#a1-> Direcion del string
#v0-> Indice del elemento encontrado
#v1-> Direccion del string encontrado

.globl strIndexOf
strIndexOf:

	addi $sp, $sp, -20
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $a0, 12($sp)
	sw $ra, 16($sp)

	li $t0, 0 
	li $t2, 0 
	la $t1, ($a0)
Loop: 
		
		sll $t2, $t0, 6
		add $a0, $t1, $t2
		    
    	jal stringCompare
    	beq $v0, 1, endLoop

		addi $t0, $t0, 1
		j Loop
endLoop:
    	move $v0, $t0
    	la $v1, ($a0)

		lw $t0, 0($sp)
		lw $t1, 4($sp)
		lw $t2, 8($sp)
		lw $a0, 12($sp)
		lw $ra, 16($sp)
		addi $sp, $sp, 20
		jr $ra	
	

