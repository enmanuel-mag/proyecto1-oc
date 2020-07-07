.data
wel: .asciiz "Bienvenido al sistema de combates Pokemon:\n"

.text
.globl main

main:
	la $a0, wel
	jal printLn
	
	#SE TERMINO EL PROGRAMA POR FIN
	li, $v0, 10
	syscall
	
