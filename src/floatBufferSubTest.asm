#Archivo que nos ayuda a hacer depuración a la función referida
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
