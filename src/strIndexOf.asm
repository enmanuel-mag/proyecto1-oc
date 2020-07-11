.globl strIndexOf

#a0-> buffer de string
#a1-> dirrecion del string
#v0-> indice
#v1-> direccion donde encuentra el objetivo dle buffer


#$a0 direccion del buffer
#$a1 cantidad de elementos
#$a2 item inicio -----------empieza en 0



strIndexOf:

	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $t2, 4($sp)
	sw $a0, 8($sp)
	sw $ra, 12($sp)

	li $t0, 0 #elementos impresos
	li $t2, 0 #indice el buffer

Loop: 
		#slt $t1, $t0, $a0
		#bne $t1, 1, endLoop 

		sll $t2, $t0, 5
		add $a0, $a0, $t2
		    
    jal stringCompare
    beq $v0, 1, endLoop

		addi $t0, $t0, 1
		
		j Loop

endLoop:
    move $v0, $t0
    la $v1, ($a0)

		lw $t0, 0($sp)
		lw $t2, 4($sp)
		lw $a0, 8($sp)
		lw $ra, 12($sp)
		addi $sp, $sp, 16
		jr $ra	
	
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
