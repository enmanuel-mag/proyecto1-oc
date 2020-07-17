.globl strBufferGet
#a0-> buffer direction
#a1-> valor del indice que se busca
#a2-> bytes de separacion
#v0-> direccion del string encontrado

strBufferGet:
    addi $sp, $sp, -16
    sw $t0, 0($sp)
    sw $a1, 4($sp)
    sw $a2, 8($sp)
    sw $ra, 12($sp)

    mul $t0, $a1, $a2
    add $v0, $a0, $t0
    
    lw $t0, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
