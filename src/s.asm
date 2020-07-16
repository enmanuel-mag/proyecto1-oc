.globl applyFactorToBuffer
#Funcion inplace
#solo funciona con buffer de floats
#$a0 -> Direccion inicial del buffer de flotantes
#$a1 -> Indice del elemento flotante
#$f0 -> Direccion inicial del factor flotante
#Retorno
#solo por debugg 
#$f2 -> Direccion inical del producto realizado
applyFactorToBuffer:
	
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	
	sll $t0, $a1, 2 #en t0 guardo la multiplicacion del indice * 4
	add $a0, $a0, $t0 #muevo el puntero al float deseado
	l.s $f1 ($a0)# cargo el float deseado
	mul.s $f2, $f1, $f0  #realizo el producto
	s.s $f2, ($a0) #guardo en la misma posicion el flotante actualizado
	
	lw $t0, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	#mul.s
