#Archivo que nos ayuda a hacer depuración a la función referida
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