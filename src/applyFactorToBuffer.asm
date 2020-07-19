#Multiplica un factor por uno de los elementos en el buffer pasado como parámetro
#$a0 -> Direccion de buffer(float)
#$a1 -> Indice del elemento a multiplicar
#$f0 -> Direccion del factor(float)
#Retorno
#$f2 -> Direccion del producto(float)
.globl applyFactorToBuffer
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
