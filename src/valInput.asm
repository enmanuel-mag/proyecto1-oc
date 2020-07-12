.globl valInput
#$a0 -> numero menor que 10 y mayor que 0
valInput: 

  addi $sp, $sp, -8
  sw $a0, 0($sp)
  sw $t0, 4($sp)

  addi $t0, $a0, -10

  blez $t0, valGZ
  j returnZero

valGZ:
  bgtz $a0, returnOne
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
  addi $sp, $sp, 8
  jr $ra
