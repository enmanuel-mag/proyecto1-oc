
.data
wel: .asciiz "Bienvenido al sistema de combates Pokemon:"
salida: .asciiz "11.Salir"
input: .asciiz "Ingrese un numero para el primer Pokemon (del 1 al 10)"
bufferInput: .space 64
input2: .asciiz "Ingrese un numero para el segundo Pokemon (del 1 al 10)"
bufferInput2: .space 64
inputError: .asciiz "Error, por favor ingrese un numero valido (1 al 11):"
combatientesStr0: .asciiz "Combatientes: "
combatientesStr1: .asciiz " vs. "
combateStr2: .asciiz " ataca a "
combateStr3: .asciiz "Resultado del ataque:\n"
combateStr4: .asciiz " es el ganador!"

onlyTypesPath_j: .asciiz "C:\\Users\\Josue\\Documents\\Organizacion Proyecto\\proyecto1-oc\\src\\data\\types.txt"
onlyTypesPath: .asciiz "C:\\code\\oc\\proyecto1-oc\\src\\data\\types.txt"
onlyTypeBuffer: .space 130
onlyTypeArray: .space 1152

pokeTypePath_j: .asciiz "C:\\Users\\Josue\\Documents\\Organizacion Proyecto\\proyecto1-oc\\src\\data\\pokeTypes.txt"
pokeTypePath: .asciiz "C:\\code\\oc\\proyecto1-oc\\src\\data\\pokeTypes.txt"
pokeTypeBuffer: .space 1821
pokeTypeArray: .space 6912

pokeSelected1: .space 128 
pokeSelected2: .space 128 
attacksPoke: .float 2.0, 2.0
lifesPoke: .float 5.0, 5.0
valorMinimo: .float 0.0 

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
	
	la $a0, onlyTypesPath_j
	la $a1, onlyTypeBuffer
	li $a2, 130
	jal read
	
	la $a0, onlyTypeBuffer
	la $a1, onlyTypeArray
	li $a2, '\n'
	li $a3, 18
	jal stringSplitBy
	
	la $a0, pokeTypePath_j
	la $a1, pokeTypeBuffer
	li $a2, 1821
	jal read
	
	la $a0, pokeTypeBuffer
	la $a1, pokeTypeArray
	li $a2, '\n'
	li $a3, 108
	jal stringSplitBy
	
	la $a0, wel
	li $v0, 4
	syscall
	jal printLn
	
	jal random
	move $a0, $v0
	
	la $t0, valImportantes
	addi $t0, $t0, 0
	sw $a0, 0($t0)
	
	la $t0, valImportantes #obtengo el random 
	lw $t0, 0($t0) #limite inferior
	addi $t1, $a0, 10 #limite superior
	
	la $a0, pokeTypeArray
	la $a1, ($t1)
	la $a2, ($t0)
	jal printWordsInBufferNum
	la $a0, salida
	li $v0, 4
	syscall
	jal printLn
	
	la $a0, input
	li $v0, 4
	syscall
	jal printLn
	
loop:
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
	
	la $a0, bufferInput
	jal stringToInt
	beq $v0, 11, exit
	
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
	beq $v0, 11, exit
	j continue2
loopMsg2:
	la $a0, inputError
	li $v0, 4
	syscall
	jal printLn
	j loop2
	
continue2:
	
	la $a0, bufferInput2
	jal stringToInt
	beq $v0, 11, exit

	la $a0, bufferInput
	jal stringToInt
	
	la $t0, valImportantes
	lw $t1, 0($t0) 
	addi $t2, $v0, -1 
	add $t2, $t1, $t2 
	
	sw $t2, 4($t0)
	
	la $a0, bufferInput2
	jal stringToInt
	
	la $t0, valImportantes
	lw $t1, 0($t0) 
	addi $t2, $v0, -1 
	add $t2, $t1, $t2 
	
	sw $t2, 8($t0)
	
	la $t0, valImportantes
	
	la $a0, combatientesStr0
	li $v0, 4
	syscall
	
	la $a0, valImportantes
	lw $a1, 4($a0) #cargo indice
	la $a0, pokeTypeArray #direccion de buffer
	li $a2, 64 #bytes de separacion
	jal strBufferGet
	la $a0, ($v0)
	li $v0, 4
	syscall
	
	la $a0, combatientesStr1
	li $v0, 4
	syscall
	
	la $a0, valImportantes
	lw $a1, 8($a0) 
	la $a0, pokeTypeArray #direccion de buffer
	li $a2, 64 
	jal strBufferGet
	la $a0, ($v0)
	li $v0, 4
	syscall
	
	la $a0, valImportantes
	lw $a1, 4($a0) 
	la $a0, pokeTypeArray 
	li $a2, 64 
	jal strBufferGet
	la $a0, ($v0)
	la $a1, pokeSelected1
	li $a2, ','
	li $a3, 2
	jal stringSplitBy
	
	la $a0, pokeSelected1 
	li $a1, 1
	li $a2, 64 
	jal strBufferGet
	
	la $a0, onlyTypeArray
	la $a1, ($v0)
	jal strIndexOf
	
	la $a0, valImportantes
	sw $v0, 12($a0)#Guardo el indice donde se encuentra el tipo del primer pokemon
	
	la $a0, valImportantes
	lw $a1, 8($a0) 
	la $a0, pokeTypeArray 
	li $a2, 64 
	jal strBufferGet
	la $a0, ($v0)
	la $a1, pokeSelected2
	li $a2, ','
	li $a3, 2
	jal stringSplitBy
	
	la $a0, pokeSelected2 
	li $a1, 1
	li $a2, 64 
	jal strBufferGet
	
	la $a0, onlyTypeArray
	la $a1, ($v0)
	jal strIndexOf
	
	la $a0, valImportantes
	sw $v0, 16($a0)
	
	la $a0, valImportantes
	lw $a1, 12($a0)
	lw $a2, 16($a0)
	la $a0, matriz
	jal getFactor
	la $a0, attacksPoke
	la $a1, 0
	mov.s $f0, $f10
	jal applyFactorToBuffer
	
	la $a0, valImportantes
	lw $a1, 16($a0)
	lw $a2, 12($a0)
	la $a0, matriz
	jal getFactor
	
	la $a0, attacksPoke
	la $a1, 1
	mov.s $f0, $f10
	jal applyFactorToBuffer
	
	li $t0, 0 
	jal printLn
	golpes:
		la $a0, pokeSelected1
		la $a1, lifesPoke
		la $a2, attacksPoke
		li $a3, 0
		jal printPokeStats
		
		la $a0, combateStr2
		li $v0, 4
		syscall
		
		la $a0, pokeSelected2
		la $a1, lifesPoke
		la $a2, attacksPoke
		li $a3, 1
		jal printPokeStats
		jal printLn
		
		la $a0, lifesPoke
		la $a1, attacksPoke
		move $a2, $t0
		jal floatBufferSub
		la $a0, combateStr3
		li $v0, 4
		syscall
		
		la $a0, pokeSelected1
		la $a1, lifesPoke
		la $a2, attacksPoke
		li $a3, 0
		jal printPokeStats
		jal printLn
		
		la $a0, pokeSelected2
		la $a1, lifesPoke
		la $a2, attacksPoke
		li $a3, 1
		jal printPokeStats
		jal printLn
		jal printLn
		
		bne $t0, 0, turnZero
		li $t0, 1
		j continueTo
		turnZero:
		li $t0, 0
		continueTo:
		
		la $a0, lifesPoke
		jal someoneHasDied
		bne $v0, 1, golpes
		
		declaroGanador:
		
		beq $v1, 1, ganoElSegundo
		la $a0, pokeSelected1
		li $v0, 4
		syscall
		
		la $a0, combateStr4
		li $v0, 4
		syscall
		j exit
		ganoElSegundo:
		la $a0, pokeSelected2
		li $v0, 4
		syscall
		
		la $a0, combateStr4
		li $v0, 4
		syscall
	
		exit:
		li, $v0, 10
		syscall