.data
wel: .asciiz "Bienvenido al sistema de combates Pokemon:"
pokeTypePath: .asciiz "C:\\code\\oc\\proyecto1-oc\\src\\pokeTypes.txt"
onlyTypesPath: .asciiz "C:\\Users\\Josue\\Documents\\Organizacion Proyecto\\proyecto1-oc\\src\\types.txt"
pokeTypeBuffer: .space 1821
pokeTypesArray: .space 3456
tipo: .asciiz "normal"
.text
.globl main

main:
	la $a0, onlyTypesPath
	la $a1, pokeTypeBuffer
	li $a2, 1821
	jal read
	
	la $a0, pokeTypeBuffer
	la $a1, pokeTypesArray
	li $a2, '\n'
	li $a3, 18
	jal stringSplitBy
	
	la $a0, pokeTypesArray
	addi $t1, $t0, 10
	li $a1, 18
	li $a2, 0
	jal printWordsInBuffer
		

	la $a0, pokeTypesArray
	li $v0, 4
	syscall
	
	la $a0, pokeTypesArray
	la $a1, tipo	
	
	jal stringCompare
	
	jal strIndexOf
	
	la $a0, ($v1)
	li $v0, 4
	syscall
	
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
