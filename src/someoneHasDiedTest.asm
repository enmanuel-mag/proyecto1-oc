#Funcion inplace
#solo funciona con buffer de floats
#$a0 -> Direccion inicial del buffer de flotantes (Vida)
#$v0 -> If any value in buffe is 0 return 1 else 0
#$V1 -> Index of the non dead pokemon
.data
	zero: .float 0.0
	arr: .float 0.0, 1.0
#.globl someoneHasDied

.text
main:
	la $a0, arr
	jal someoneHasDied
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	move $a0, $v1
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

someoneHasDied:
	addi $sp, $sp, -24
	sw $t0, 0($sp)
	sw $a0, 4($sp)
	s.s $f0, 8($sp)
	s.s $f1, 12($sp)
	s.s $f3, 16($sp)
	sw $ra, 20($sp)
	
	l.s $f3, zero
	
	l.s $f0 ($a0)# cargo el float deseado
	li $t0, 1
	sll $t0, $t0, 2 #en t0 guardo la multiplicacion del indice * 4
	add $a0, $a0, $t0 #muevo el puntero al float deseado
	l.s $f1 ($a0)# cargo el float deseado
	
	c.eq.s $f0, $f3 #guarda en coproc un bit true o false
	bc1t firstPokeHasDied #move to saveNewValue if coproc is true
	c.eq.s $f1, $f3 #guarda en coproc un bit true o false
	bc1t secondPokHasDied #move to saveNewValue if coproc is true
	li $v0, 0
	li $v1, -1
	j exit
	firstPokeHasDied:
	li $v0, 1
	li $v1, 0
	j exit
	secondPokHasDied:
	li $v0, 1
	li $v1, 1
	exit: 
	lw $t0, 0($sp)
	lw $a0, 4($sp)
	l.s $f0, 8($sp)
	l.s $f1, 12($sp)
	l.s $f3, 16($sp)
	lw $ra, 20($sp)
	addi $sp, $sp, -24
	jr $ra
