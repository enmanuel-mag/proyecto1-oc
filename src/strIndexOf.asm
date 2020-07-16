.globl strIndexOf

#a0-> buffer de string
#a1-> dirrecion del string
#v0-> indice
#v1-> direccion donde encuentra el objetivo dle buffer


#$a0 direccion del buffer
#$a1 cantidad de elementos
#$a2 item inicio -----------empieza en 0



strIndexOf:

	addi $sp, $sp, -20
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $a0, 12($sp)
	sw $ra, 16($sp)

	li $t0, 0 #elementos impresos
	li $t2, 0 #indice el buffer
	la $t1, ($a0)
Loop: 
		#slt $t1, $t0, $a0
		#bne $t1, 1, endLoop 

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
	

