#Imprime el nombre, vida y ataque de un pokemon
#según el formato del proyecto.
#a0-> direccion del buffer de los datos del pokemon
#a1-> direccion del buffer vida
#a2-> direccion del buffer ataque
#a2-> indice del atacante atacante(0|1)
.globl printPokeStats
.data
combateStr0: .asciiz ": Vida: "
combateStr1: .asciiz " Ataque: "
.text
printPokeStats:
    addi $sp, $sp, -16
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)
    sw $a3, 8($sp)
    sw $t0, 8($sp)
    sw $ra, 12($sp)
		
    	#imprimo el nombre del pokemon atacante
		li $v0, 4
		syscall
		#imprimo ": vida: "
		la $a0, combateStr0
		li $v0, 4
		syscall
		#imprimo la vida
		sll $t0, $a3, 2  
		add $a1, $a1, $t0
		l.s $f12, ($a1)
		li $v0, 2
		syscall
		#imprimo ": ataque: "
		la $a0, combateStr1
		li $v0, 4
		syscall
		#imprimo el ataque
		sll $t0, $a3, 2  
		add $a2, $a2, $t0
		l.s $f12, ($a2)
		li $v0, 2
		syscall
    
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    lw $a3, 8($sp)
    lw $t0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra