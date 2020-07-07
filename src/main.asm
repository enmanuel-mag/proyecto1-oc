.data
wel: .asciiz "Bienvenido al sistema de combates Pokemon:"

.text
.globl main

main:
	la $a0, wel #MAIN
	jal printLn
	
	jal random
	move $a0, $v0
	li $v0, 1
	syscall
	
	#SE TERMINO EL PROGRAMA POR FIN
	li, $v0, 10
	syscall
	
