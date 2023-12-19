.data
str:    .space  40

.macro printInt(%int)
	addi $sp, $sp, -8
    sw $v0, 4($sp)
    sw $a0, 0($sp)
    move $a0, %int
    li $v0, 1    
    syscall
    lw $v0, 4($sp)
    lw $a0, 0($sp)
    addi $sp, $sp, 8
.end_macro


.text
li $v0, 5
syscall
move $s0, $v0       # $s0 = n
li $t0, 0
input_loop:
    bge $t0, $s0, input_loop_done
    li $v0, 12
    syscall
    sb $v0, str($t0)
    addi $t0, $t0, 1
    j input_loop
input_loop_done:
la $a0, str
jal strlen

li $s2, 0           # $s2 = i
addi $s3, $v0, -1   # $s3 = j
li $s4, 1           # $s4 = result
check_loop:
    bge $s2, $s3, check_loop_done
    lb $t0, str($s2)
    lb $t1, str($s3)
    beq $t0, $t1, else
        li $s4, 0
        j check_loop_done
    else:
    addi $s2, $s2, 1
    addi $s3, $s3, -1
    j check_loop
check_loop_done:
printInt($s4)
li $v0, 10
syscall



strlen:
    li $v0, 0
    lb $t0, 0($a0)
    strlen_loop:
        beq $t0, $0, strlen_loop_done
        addi $v0, $v0, 1
        addi $a0, $a0, 1
        lb $t0, 0($a0)
        j strlen_loop
    strlen_loop_done:
    jr $ra
