.data
wel: .asciiz "Bienvenido al sistema de combates Pokemon:"
input: .asciiz "Ingrese un número del 1 al 10"
inputError: .asciiz "LO ACABO DE ESPECIFICAR ARRIBA NO SEA IMBECIL!"

onlyTypesPath_j: .asciiz "C:\\Users\\Josue\\Documents\\Organizacion Proyecto\\proyecto1-oc\\src\\data\\types.txt"
onlyTypesPath: .asciiz "C:\\code\\oc\\proyecto1-oc\\src\\data\\types.txt"
onlyTypeBuffer: .space 130
onlyTypeArray: .space 1152

pokeMatrixPath: .asciiz "C:\\code\\oc\\proyecto1-oc\\src\\data\\matriz.txt"
pokeMatrixBuffer: .space 790
pokeMatrixArray: .space 1152

pokeTypePath: .asciiz "C:\\code\\oc\\proyecto1-oc\\src\\data\\pokeTypes.txt"
pokeTypeBuffer: .space 1821
pokeTypeArray: .space 6912



tipo: .asciiz "fight"

.text
.globl main

main:
	#Lectura del archivo de solo los tipos
	la $a0, onlyTypesPath
	la $a1, onlyTypeBuffer
	li $a2, 130
	jal read
	#Creacion del array con el contenido de solo los tipos
	la $a0, onlyTypeBuffer
	la $a1, onlyTypeArray
	li $a2, '\n'
	li $a3, 18
	jal stringSplitBy
	
	#Lectura del archivo matrix
	la $a0, pokeMatrixPath
	la $a1, pokeMatrixBuffer
	li $a2, 790
	jal read
	#Creacion del array con el contenido de la matrix
	la $a0, pokeMatrixBuffer
	la $a1, pokeMatrixArray
	li $a2, '\n'
	li $a3, 18
	jal stringSplitBy
	
	#Lectura del archivo pokeTypes
	la $a0, pokeTypePath
	la $a1, pokeTypeBuffer
	li $a2, 1821
	jal read
	#Creacion del array con el contenido de pokeTypes
	la $a0, pokeTypeBuffer
	la $a1, pokeTypeArray
	li $a2, '\n'
	li $a3, 108
	jal stringSplitBy
	
	jal random
	move $t0, $v0
	addi $t1, $t0, 10
	
	la $a0, pokeTypeArray
	move $a1, $t1
	move $a2, $t0
	jal printWordsInBuffer
	
	
	la $a0, input
	jal printLn
	
loop:
	li $v0, 5
	syscall
	move $a0, $v0
	jal valInput
	beq $v0, 0, loopMsg
	j continue
loopMsg:
	la $a0, inputError
	jal printLn
	j loop
continue:
			
	#SE TERMINO EL PROGRAMA POR FIN
	li, $v0, 10
	syscall
