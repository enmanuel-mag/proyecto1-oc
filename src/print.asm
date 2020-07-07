.text
.globl print

print:
    
	li $v0, 4  #PRINT
	syscall 
	jr $ra