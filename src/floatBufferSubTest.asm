#Funcion inplace
#solo funciona con buffer de floats
#$a0 -> Direccion inicial del buffer de flotantes(Minuendo)
#$a1 -> Direccion inicial del buffer de flotantes(Sustraendo)
#$a2 -> Longitud de los buffer(Igual longitud)
#$a3 -> Direccion del valor minimo aceptado (0 por defecto)
#Retorno
#solo por debugg 
#$v0 -> Direccion inical del buffer a0 (una vez realizada la resta)
#.globl floatBufferSub
.data
arr: .float 14.5, 15.31
arr1: .float 15.6, 15.3
minimo: .float 0.0
.text
main:
	la $a0, arr
	la $a1, arr1
	li $a2, 2
	la $a3, minimo
	jal floatBufferSub
	
	la $a0, arr
	li $t0, 4
	add $t0, $a0, $t0
	l.s $f12, ($t0)
	
	li $v0, 2
	syscall
	
	li $v0, 10
	syscall

floatBufferSub:
	
	addi $sp, $sp, -48
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $t0, 12($sp)
	sw $t1, 16($sp)
	sw $t2, 20($sp)
	sw $t3, 24($sp)
	s.s $f0, 28($sp)
	s.s $f1, 32($sp)
	s.s $f2, 36($sp)
	s.s $f3, 40($sp)
	sw $ra, 44($sp)
	
	li $t0, 0
	l.s $f3, ($a3)
	for:
		slt $t1, $t0, $a2
		bne $t1, 1, endFor
		
		sll $t2, $t0, 2 #en t2 guardo la multiplicacion del indice * 4
		sll $t3, $t0, 2 #en t3 guardo la multiplicacion del indice * 4
		
		add $a0, $a0, $t2 #muevo el puntero al float deseado
		add $a1, $a1, $t3 #muevo el puntero al float deseado
		
		l.s $f0 ($a0)# cargo el float deseado
		l.s $f1 ($a1)# cargo el float deseado
		
		sub.s $f2, $f0, $f1  #realizo el producto
		c.lt.s $f2, $f3 #guarda en coproc un bit true o false
		bc1f saveNewValue #move to saveNewValue if coproc is true
		 
		mov.s $f2, $f3 #guardo en f2 el limite inferior 
		saveNewValue:
		s.s $f2, ($a0) #guardo en la misma posicion el flotante actualizado
		addi $t0, $t0, 1
		j for
	 endFor: 
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $t0, 12($sp)
	lw $t1, 16($sp)
	lw $t2, 20($sp)
	lw $t3, 24($sp)
	l.s $f0, 28($sp)
	l.s $f1, 32($sp)
	l.s $f2, 36($sp)
	l.s $f3, 40($sp)
	lw $ra, 44($sp)
	addi $sp, $sp, 48
	jr $ra
