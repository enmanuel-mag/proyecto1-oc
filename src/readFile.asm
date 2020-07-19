# Lee las lineas de un archivo y las guarda en un buffer
# $a0 
# $a1 -> buf
# $a2 -> tamaño del b
# $v0 -> buffer con el c

.globl read
read:
	addi $sp, $sp, -32
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $a0, 16($sp)
	sw $a1, 20($sp)
	sw $a2, 24($sp)
	sw $ra, 28($sp)

	la $t1, ($a0)
	la $t2, ($a1)
	la $t3, ($a2)
	
  	li $v0, 13        
  	li $a1, 0
  	syscall           

  	move $t0, $v0     
  	li $v0, 14        
  	la $a1, ($t2)    
  	move $a2, $t3    
  	move $a0, $t0     
  	syscall           

 	  
  	li $v0, 16      
  	move $a0, $t0 
  	syscall       

  	la $v0, ($t2)
  	
  	sw $t0, 0($sp)
	  sw $t1, 4($sp)
	  sw $t2, 8($sp)
	  sw $t3, 12($sp)
	  sw $a0, 16($sp)
	  sw $a1, 20($sp)
	  sw $a2, 24($sp)
	  sw $ra, 28($sp)
	  addi $sp, $sp, 32
	
  	jr $ra
