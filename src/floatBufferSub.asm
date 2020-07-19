.globl floatBufferSub
#Funcion que resta en cruz el buffer minuendo con el sustraendo(inplace, float)
#$a0 -> Direccion inicial del buffer Vida
#$a1 -> Direccion inicial del buffer Ataque
#$a2 -> Indice el atacante (o | 1)
.data
	zero: .float 0.0
.text
floatBufferSub:
	
	addi $sp, $sp, -52
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $t0, 12($sp)
	sw $t1, 16($sp)
	sw $t2, 20($sp)
	sw $t3, 24($sp)
	sw $t4, 28($sp)
	s.s $f0, 32($sp)
	s.s $f1, 36($sp)
	s.s $f2, 40($sp)
	s.s $f3, 44($sp)
	sw $ra, 48($sp)
	
	la $t4, zero
	l.s $f3, ($t4)
	
		sll $t2, $a2, 2 
		add $a1, $a1, $t2 
		l.s $f0 ($a1)
		
		bne $a2, 0, turnZero
		li $a2, 1
		j continue
		turnZero:
		li $a2, 0
		continue:
		
		sll $t2, $a2, 2 
		add $a0, $a0, $t2 
		l.s $f1 ($a0)
		
		sub.s $f2, $f1, $f0
		c.lt.s $f2, $f3 
		bc1f saveNewValue 
		 
		mov.s $f2, $f3 
		saveNewValue:
		s.s $f2, ($a0) 
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $t0, 12($sp)
	lw $t1, 16($sp)
	lw $t2, 20($sp)
	lw $t3, 24($sp)
	lw $t4, 28($sp)
	l.s $f0, 32($sp)
	l.s $f1, 36($sp)
	l.s $f2, 40($sp)
	l.s $f3, 44($sp)
	lw $ra, 48($sp)
	addi $sp, $sp, 52
	jr $ra
