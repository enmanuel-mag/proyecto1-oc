#$a0->cadena de texto a imprimir por pantalla
.text
.globl print

print:
    
	li $v0, 4 
	syscall 
	jr $ra