.globl stringCompare

#$a0 -> direccion string 1
#$a1 -> direccion string 2
#$v0 -> 1 equals; 0 else
stringCompare:
	addi $sp, $sp, -20
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $t0, 8($sp)
	sw $t1, 12($sp)
	sw $ra, 16($sp)
# string compare loop (just like strcmp)
	cmploop:
	lb      $t0,($a0)                   # get next char from str1
	lb      $t1,($a1)                   # get next char from str2
	bne     $t0,$t1,cmpne               # are they different? if yes, fly
	
	beq     $t1,$zero,cmpeq             # at End Of String? yes, fly (strings equal)
	
 	addi    $a0,$a0,1                   # point to next char
	addi    $a1,$a1,1                   # point to next char
	j cmploop	
# strings are _not_ equal -- send message
	cmpne:
	li $v0, 0
	j endStringCompare
# strings _are_ equal -- send message
	cmpeq:
	li $v0, 1

	endStringCompare:
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr $ra
