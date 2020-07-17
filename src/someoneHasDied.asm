.globl someoneHasDied
#Funcion inplace
#solo funciona con buffer de floats
#$a0 -> Direccion inicial del buffer de flotantes (Vida)
#$v0 -> If any value in buffe is 0 return 1 else 0
#$V1 -> Index of the winner pokemon
.data
	zero: .float 0.0
.text
someoneHasDied:
	addi $sp, $sp, -24
	sw $t0, 0($sp)
	sw $a0, 4($sp)
	s.s $f0, 8($sp)
	s.s $f1, 12($sp)
	s.s $f3, 16($sp)
	sw $ra, 20($sp)
	
	la  $t0, zero
	l.s $f3, ($t0)
	
	l.s $f0 ($a0)# cargo el float deseado
	l.s $f1 4($a0)# cargo el float deseado
	
	c.le.s $f0, $f3 #guarda en coproc un bit true o false
	bc1t firstPokeHasDied #move to saveNewValue if coproc is true
	c.le.s $f1, $f3 #guarda en coproc un bit true o false
	bc1t secondPokHasDied #move to saveNewValue if coproc is true
	j exit
	firstPokeHasDied:
	li $v0, 1
	li $v1, 1
	j exit
	secondPokHasDied:
	li $v0, 1
	li $v1, 0
	exit: 
	lw $t0, 0($sp)
	lw $a0, 4($sp)
	l.s $f0, 8($sp)
	l.s $f1, 12($sp)
	l.s $f3, 16($sp)
	lw $ra, 20($sp)
	addi $sp, $sp, -24
	jr $ra
