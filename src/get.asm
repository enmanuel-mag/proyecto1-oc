.globl get
#$a0 Direccion buffer
#$a1 index del buffer

get:

	addi $sp, $sp, -20
	sw $t0, 0($sp)
	sw $ra, 4($sp)
  sw $a1, 8($sp)
  sw $a2, 12($sp)
  sw $t0, 16($sp)

  
  addi $t0, $a1, -1
  add $a2, $a2, $t0

  

  jal printWordsInBuffer
  
	lw $t0, 0($sp)
	lw $ra, 4($sp)
  lw $a1, 8($sp)
  lw $a2, 12($sp)
  lw $t0, 16($sp)
	addi $sp, $sp, 20
	jr $ra