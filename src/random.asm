#Funcion que retorna un numero aleatorio entre 0 y 99
.text

.globl random

random:
    
    li $a1, 99 
    li $v0, 42 
    syscall
    
    move $v0, $a0
    
    jr $ra