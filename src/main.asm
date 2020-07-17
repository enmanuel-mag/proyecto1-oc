
.data
wel: .asciiz "Bienvenido al sistema de combates Pokemon:"
input: .asciiz "Ingrese un numero para el primer Pokemon (del 1 al 10)"
bufferInput: .space 64
input2: .asciiz "Ingrese un numero para el segundo Pokemon (del 1 al 10)"
bufferInput2: .space 64
inputError: .asciiz "Solo un numero del 1 al 10"
combatientesStr0: .asciiz "Combatientes: "
combatientesStr1: .asciiz " vs. "

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

pokeSelected1: .space 128 #[<nombre1>, <tipo1>]
pokeSelected2: .space 128 #[<nombre1>, <tipo1>]
#nombresPoke: .space 128 #dado de baja
#typesPoke: .space 128  #dado de baja 
attacksPoke: .float 2.0, 2.0
lifesPoke: .float 5.0, 5.0

valImportantes: .word 0,0,0,0,0
#valImportantes[0] -> randomNumber
#valImportantes[1] -> index 1st pokemon in pokeTypeArray
#valImportantes[2] -> index 2st pokemon in pokeTypeArray
#valImportantes[3] -> index 1st type pokemon in onlyTypeArray
#valImportantes[4] -> index 2st type pokemon in onlyTypeArray

matriz: .asciiz "1,1,1,1,1,0.5,1,0,0.5,1,1,1,1,1,1,1,1,1;2,1,0.5,0.5,1,2,0.5,0,2,1,1,1,1,0.5,2,1,2,0.5;1,2,1,1,1,0.5,2,1,0.5,1,1,2,0.5,1,1,1,1,1;1,1,1,0.5,0.5,0.5,1,0.5,0,1,1,2,1,1,1,1,1,2;1,1,0,2,1,2,0.5,1,2,2,1,0.5,2,1,1,1,1,1;1,0.5,2,1,0.5,1,2,1,0.5,2,1,1,1,1,2,1,1,1;1,0.5,0.5,0.5,1,1,1,0.5,0.5,0.5,1,2,1,2,1,1,2,0.5;0,1,1,1,1,1,1,2,1,1,1,1,1,2,1,1,0.5,1;1,1,1,1,1,2,1,1,0.5,0.5,0.5,1,0.5,1,2,1,1,2;1,1,1,1,1,0.5,2,1,2,0.5,0.5,2,1,1,2,0.5,1,1;1,1,1,1,2,2,1,1,1,2,0.5,0.5,1,1,1,0.5,1,1;1,1,0.5,0.5,2,2,0.5,1,0.5,0.5,2,0.5,1,1,1,0.5,1,1;1,1,2,1,0,1,1,1,1,1,2,0.5,0.5,1,1,0.5,1,1;1,2,1,2,1,1,1,1,0.5,1,1,1,1,0.5,1,1,0,1;1,1,2,1,2,1,1,1,0.5,0.5,0.5,2,1,1,0.5,2,1,1;1,1,1,1,1,1,1,1,0.5,1,1,1,1,1,1,2,1,0;1,0.5,1,1,1,1,1,2,1,1,1,1,1,2,1,1,0.5,0.5;1,2,1,0.5,1,1,1,1,0.5,0.5,1,1,1,1,1,2,2,1"

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
	move $a0, $v0
	#guardo el aleatorio en el buffer datos importantes, en la posicion 0 
	la $t0, valImportantes
	addi $t0, $t0, 0
	sw $a0, 0($t0)
	#se puede comentar las sgts 3 lines(solo sirven de debugg)
	li $v0, 1
	syscall
	
	la $t0, valImportantes #obtengo el random 
	lw $t0, 0($t0) #limite inferior
	addi $t1, $a0, 10 #limite superior
	
	#Se imprime un rango al azar de pokemones
	la $a0, pokeTypeArray
	la $a1, ($t1)
	la $a2, ($t0)
	jal printWordsInBuffer
	#Se imprime mensaje que invita al usuario a seleccionar un pokemon
	la $a0, input
	li $v0, 4
	syscall
	jal printLn
	
loop:
	#Pide por pantalla un string(proximo a validar)
	la $a0, bufferInput
	li $a1, 64
	li $v0, 8
	syscall
	
	la $a0, bufferInput
	jal valInput
	
	beq $v0, 0, loopMsg
	j continue
loopMsg:
	la $a0, inputError
	li $v0, 4
	syscall
	jal printLn
	j loop
continue:
	la $a0, input2
	li $v0, 4
	syscall
	jal printLn
loop2:

	la $a0, bufferInput2
	li $a1, 64
	li $v0, 8
	syscall
	
	la $a0, bufferInput2
	jal valInput
	
	beq $v0, 0, loopMsg2
	j continue2
loopMsg2:
	la $a0, inputError
	li $v0, 4
	syscall
	jal printLn
	j loop2
	
continue2:
	#hasta este punto bufferInput2 y bufferInput
	#se guardan con exito y son direcciones a string 
	
	#<<<<<<<<<<Obtengo pokemon 1>>>>>>>>>>>>>>>>>>>>
	#tomo lo que esta en el buffer1 validado y lo convierto a entero
	la $a0, bufferInput
	jal stringToInt
	#preparo el valor calculado de la posicion del pokemon 1 seleccionado
	#accedo al random generado 
	la $t0, valImportantes
	lw $t1, 0($t0) #accedo al valor random guardado
	addi $t2, $v0, -1 #guardo en t2 la resta del valor seleccinado con 1
	add $t2, $t1, $t2 #guardo en t2, la suma de la resta anterior con el random
	#en t2 queda el indice correspondiente al pokemon seleccionado
	sw $t2, 4($t0)#guardo en valImportantes
	#indexo t2 en 
	#la $a0, pokeTypeArray
	#move $a1, $t2
	#li $a2, 64
	#jal strBufferGet
	#la $t6, ($v0)
	
	#<<<<<<<<<<<<<<<Guardo en t6 el pokemito 1>>>>>>>>>
	
	#<<<<<<<<<<Obtengo pokemon 2>>>>>>>>>>>>>>>>>>>>
	#tomo lo que esta en el buffer1 validado y lo convierto a entero
	la $a0, bufferInput2
	jal stringToInt
	#preparo el valor calculado de la posicion del pokemon 1 seleccionado
	#accedo al random generado 
	la $t0, valImportantes
	lw $t1, 0($t0) #accedo al valor random guardado
	addi $t2, $v0, -1 #guardo en t2 la resta del valor seleccinado con 1
	add $t2, $t1, $t2 #guardo en t2, la suma de la resta anterior con el random
	#en t2 queda el indice correspondiente al pokemon seleccionado
	sw $t2, 8($t0)#guardo en valImportantes
	
	#indexo t3 en pokeTypeArray
	#la $a0, pokeTypeArray
	#move $a1, $t2
	#li $a2, 64
	#jal strBufferGet
	#la $t7, ($v0)
	
	#<<<<<<<<<<<<<<<Guardo en t7 el pokemito 2>>>>>>>>>
	#-------Presento a los combatientes----------------
	la $t0, valImportantes
	#Imprimo la palabra "Combatientes: "
	la $a0, combatientesStr0
	li $v0, 4
	syscall
	#imprimo el 1er pokemon
	la $a0, valImportantes
	lw $a1, 4($a0) #cargo indice
	la $a0, pokeTypeArray #direccion de buffer
	li $a2, 64 #bytes de separacion
	jal strBufferGet
	la $a0, ($v0)
	li $v0, 4
	syscall
	#imprimo vs.
	la $a0, combatientesStr1
	li $v0, 4
	syscall
	#imprimo el 2do pokemon
	la $a0, valImportantes
	lw $a1, 8($a0) #cargo indice
	la $a0, pokeTypeArray #direccion de buffer
	li $a2, 64 #bytes de separacion
	jal strBufferGet
	la $a0, ($v0)
	li $v0, 4
	syscall
	#---------Fin presentar combatientes
	
	#<<<<<<<<< Obtengo los indices y los guardo en valImportantes >>>>>>>>>>>>>>
	#Guardo en pokeSelected1 el nombre y el tipo del primer pokemon
	#jal printLn
	la $a0, valImportantes
	lw $a1, 4($a0) #cargo indice
	la $a0, pokeTypeArray #direccion de buffer
	li $a2, 64 #bytes de separacion
	jal strBufferGet
	la $a0, ($v0)
	la $a1, pokeSelected1
	li $a2, ','
	li $a3, 2
	jal stringSplitBy
	#obtengo el tipo del primero pokemon
	la $a0, pokeSelected1 #direccion de buffer
	li $a1, 1
	li $a2, 64 #bytes de separacion
	jal strBufferGet
	#busco el tipo del primero pokemon en onlyTypeArray
	la $a0, onlyTypeArray
	la $a1, ($v0)
	jal strIndexOf
	#guardo el indice encontrado previamente
	la $a0, valImportantes
	sw $v0, 12($a0)#Guardo el indice donde se encuentra el tipo del primer pokemon
	
	
	#Guardo en pokeSelected2 el nombre y el tipo del primer pokemon
	#jal printLn
	la $a0, valImportantes
	lw $a1, 8($a0) #cargo indice
	la $a0, pokeTypeArray #direccion de buffer
	li $a2, 64 #bytes de separacion
	jal strBufferGet
	la $a0, ($v0)
	la $a1, pokeSelected2
	li $a2, ','
	li $a3, 2
	jal stringSplitBy
	#obtengo el tipo del primero pokemon
	la $a0, pokeSelected2 #direccion de buffer
	li $a1, 1
	li $a2, 64 #bytes de separacion
	jal strBufferGet
	#busco el tipo del primero pokemon en onlyTypeArray
	la $a0, onlyTypeArray
	la $a1, ($v0)
	jal strIndexOf
	#guardo el indice encontrado previamente
	la $a0, valImportantes
	sw $v0, 16($a0)#Guardo el indice donde se encuentra el tipo del segundo pokemon
	
	
	#<<<<<<<<<FIN Obtengo los indices y los guardo en valImportantes >>>>>>>>>>>>>>
	
	#-------------------------
	#Prueba de que los indices (fila y columna) se muestran correctamente
	#Solo para comprobar que filas y columnas se cargan correctamente
	#la $a0, valImportantes
	#lw $a0, 12($a0)
	#li $v0, 1
	#syscall
	#la $a0, valImportantes
	#lw $a0, 16($a0)
	#li $v0, 1
	#syscall
	
	#jal printLn
	
	#saco el factor de ataque del primer pokemito
	la $a0, valImportantes
	lw $a1, 12($a0)
	lw $a2, 16($a0)
	la $a0, matriz
	jal getFactor #-> $f10
	#multiplico el factor por el ataque
	la $a0, attacksPoke
	la $a1, 0
	mov.s $f0, $f10
	jal applyFactorToBuffer
	
	#saco el factor de ataque del segundo pokemito
	la $a0, valImportantes
	lw $a1, 16($a0)
	lw $a2, 12($a0)
	la $a0, matriz
	jal getFactor #-> $f10
	#multiplico el factor por el ataque
	la $a0, attacksPoke
	la $a1, 1
	mov.s $f0, $f10
	jal applyFactorToBuffer
	#--------------------------------
	# En este punto el arreglo fe ataques ya está con el factor y listo para usarse
	la $a0, attacksPoke
	l.s $f12, 0($a0)
	li $v0, 2
	syscall
	jal printLn
	la $a0, attacksPoke
	l.s $f12, 4($a0)
	li $v0, 2
	syscall
	
	
	#SE TERMINO EL PROGRAMA POR FIN
	li, $v0, 10
	syscall