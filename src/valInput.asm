.globl valInput
#$a0 -> numero menor que 10 y mayor que 0
valInput: 

  addi $sp, $sp, -16
  sw $a0, 0($sp)
  sw $t0, 4($sp)
  sw $ra, 8($sp)
  sw $t1, 12($sp)

  la $t1, ($a0)

  jal strIsDigit
  beq $v0, 0, returnZero

  jal stringToInt
  beq $v0, 0, returnZero

  addi $t0, $v0, -10

  blez $t0, valGZ
  j returnZero

valGZ:
  bgtz $t1, returnOne
  j returnZero

returnZero:
  li $v0, 0
  j exit

returnOne:
  li $v0, 1
  j exit

exit:
  
  lw $a0, 0($sp)
  lw $t0, 4($sp)
  lw $ra, 8($sp)
  lw $t1, 12($sp)
  addi $sp, $sp, 16
  jr $ra
