.data
wel: .asciiz "Bienvenido al sistema de combates Pokemon:"
input: .asciiz "Ingrese un numero para el primer Pokemon (del 1 al 10)"
input2: .asciiz "Ingrese un numero para el segundo Pokemon (del 1 al 10)"
inputError: .asciiz "Solo un numero del 1 al 10"

onlyTypesPath_j: .asciiz "C:\\Users\\Josue\\Documents\\Organizacion Proyecto\\proyecto1-oc\\src\\data\\types.txt"
onlyTypesPath: .asciiz "C:\\code\\oc\\proyecto1-oc\\src\\data\\types.txt"
onlyTypeBuffer: .space 130
onlyTypeArray: .space 1152

pokeMatrixPath_j: .asciiz "C:\\Users\\Josue\\Documents\\Organizacion Proyecto\\proyecto1-oc\\src\\data\\matriz.txt"
pokeMatrixPath: .asciiz "C:\\code\\oc\\proyecto1-oc\\src\\data\\matriz.txt"
pokeMatrixBuffer: .space 790
pokeMatrixArray: .space 1152

pokeTypePath_j: .asciiz "C:\\Users\\Josue\\Documents\\Organizacion Proyecto\\proyecto1-oc\\src\\data\\pokeTypes.txt"
pokeTypePath: .asciiz "C:\\code\\oc\\proyecto1-oc\\src\\data\\pokeTypes.txt"
pokeTypeBuffer: .space 1821
pokeTypeArray: .space 6912

nombresPoke: .space 128
typesPoke: .space 128
attacksPoke: .space 128
lifesPoke: .space 128

.text
.globl main

main:
	#Lectura del archivo de solo los tipos
	la $a0, onlyTypesPath_j
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
	la $a0, pokeMatrixPath_j
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
	la $a0, pokeTypePath_j
	la $a1, pokeTypeBuffer
	li $a2, 1821
	jal read
	#Creacion del array con el contenido de pokeTypes
	la $a0, pokeTypeBuffer
	la $a1, pokeTypeArray
	li $a2, '\n'
	li $a3, 108
	jal stringSplitBy
	
	#Se obtiene el número aleatorio
	jal random
	move $t0, $v0
	li $a0, 0
	add $a0, $a0, $t0
	li $v0, 1
	syscall
	
	addi $t1, $t0, 10
	
	#Se imprime un rango al azar de pokemones
	la $a0, pokeTypeArray
	la $a1, ($t1)
	la $a2, ($t0)
	jal printWordsInBuffer
	#Se imprime mensaje que invita al usuario a seleccionar un pokemon
	la $a0, input
	jal printLn
	
loop:
	#Pide por pantalla un entero
	li $v0, 5
	syscall
	
	la $s1, ($v0)
	li $a0, 0
	add $a0, $a0, $s1
	jal valInput
	beq $v0, 0, loopMsg
	j continue
loopMsg:
	la $a0, inputError
	jal printLn
	j loop
continue:
	la $a0, input2
	jal printLn
loop2:
	li $v0, 5
	syscall
	move $s2, $v0
	li $a0, 0
	add $a0, $a0, $s2
	jal valInput
	beq $v0, 0, loopMsg2
	j continue2
loopMsg2:
	la $a0, inputError
	jal printLn
	j loop2
	
continue2:
	
	li $t2, 0
	add $t2, $t2, $t0
	add $t2, $t2, $s1
	
	la $a0, pokeTypeArray
	move $a1, $t2	
	jal get
	
	la $a0, ($v0)
	li $v0, 4
	syscall
	
	#la $a1, pokeTypeArray
	#jal get
	


	
	#SE TERMINO EL PROGRAMA POR FIN
	li, $v0, 10
	syscall
