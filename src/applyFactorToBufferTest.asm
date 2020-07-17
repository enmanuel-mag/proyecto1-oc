
#solo funciona con buffer de floats
#$a0 -> Direccion inicial del buffer de flotantes
#$a1 -> Indice del elemento flotante
#$f0 -> Direccion inicial del factor flotante
#Retorno
#solo por debugg 
#$f2 -> Direccion inical del producto realizado

#.globl applyFactorToBuffer
.data
arr: .float 4.5, 1.3

factor: .float 2.3
.text
main2: 
	la $a0, arr
	li $a1, 1
	l.s $f0, factor
	jal applyFactorToBuffer
	
	
	la $a0, arr
	li $t0, 4
	add $t0, $a0, $t0
	l.s $f12, ($t0)
	
	li $v0, 2
	syscall
	
	li $v0, 10
	syscall
	

	