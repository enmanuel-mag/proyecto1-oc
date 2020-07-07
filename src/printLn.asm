.data
	salto: .asciiz "\n"	
.text
.globl printLn

printLn:

	li $v0, 4  
	syscall
	li $v0, 4
	la $a0, salto      
	syscall 
	jr $ra
