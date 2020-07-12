.data
wel: .asciiz "Bienvenido al sistema de combates Pokemon:"
pokeTypePath: .asciiz "C:\\Users\\Josue\\Documents\\Organizacion Proyecto\\proyecto1-oc\\src\\pokeTypes.txt"
pokeTypeBuffer: .space 1821
pokeTypesArray: .space 3456

onlyTypesPath: .asciiz "C:\\Users\\Josue\\Documents\\Organizacion Proyecto\\proyecto1-oc\\src\\types.txt"
onlyTypeBuffer: .space 577
onlyTypeArray: .space 1000

.text
.globl main

main:
	#funciona lectura
	la $a0, onlyTypesPath
	la $a1, onlyTypeBuffer
	li $a2, 1000
	jal read
	
	#funciona escritura
	la $a0, onlyTypeBuffer
	la $a1, onlyTypeArray
	li $a2, '\n' 
	li $a3, 18
	jal stringSplitBy
	
	#prubea del array 
	#la $t0, onlyTypeArray
	#addi $a0, $t0, 32
	#li $v0, 4
	#syscall
	
	#funciona la impresion
	la $a0, onlyTypeArray
	li $a1, 18 #elemento final
	li $a2, 8 #elemento inicial
	jal printWordsInBuffer

	#la $t0, pokeTypesArray
	#addi $t2, $t0, 32
	#la $a0, ($t2)
	#li $v0, 4
	#syscall
	
	#la $a0, pokeTypesArray
	#la $a1, tipo
	#jal strIndexOf
	
	la $a0, pokeTypePath
	la $a1, pokeTypeBuffer
	li $a2, 1821
	jal read
	
	jal random
	move $t0, $v0
	
	la $a0, pokeTypesArray
	addi $t1, $t0, 10
	move $a1, $t1
	move $a2, $t0
	jal printWordsInBuffer
		
	#SE TERMINO EL PROGRAMA POR FIN
	li, $v0, 10
	syscall
