.data 
maze:       .space  256
line:       .asciiz "\n"


.macro getOffset(%ans, %row, %col)
    sll %ans, %row, 3
    add %ans, %ans, %col
    sll %ans, %ans, 2
.end_macro

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
li $v0, 5
syscall
move $s1, $v0       # $s1 = m
li $s2, 0           # $s2 = ans
jal input
li $v0, 5
syscall 
move $a0, $v0       
addi $a0, $a0, -1   # $a0 = startX
li $v0, 5
syscall 
move $a1, $v0       
addi $a1, $a1, -1   # $a1 = startY
li $v0, 5
syscall
move $s3, $v0     
addi $s3, $s3, -1   # $s3 = destX
li $v0, 5
syscall             
move $s4, $v0       
addi $s4, $s4, -1   # $s4 = destY
jal dfs
printInt($s2)
li $v0, 10
syscall




input:
li $t0, 0
input_loop_i:
    bge $t0, $s0, input_loop_i_done
    li $t1, 0
    input_loop_j:
        bge $t1, $s1, input_loop_j_done
        getOffset($t2, $t0, $t1)
        li $v0, 5
        syscall
        sw $v0, maze($t2)
        addi $t1, $t1, 1
        j input_loop_j
    input_loop_j_done:
    addi $t0, $t0, 1
    j input_loop_i
input_loop_i_done:
jr $ra


dfs:
sub $t0, $a0, $s3
sub $t1, $a1, $s4
or $t0, $t0, $t1
bne $t0, 0, elseif
    addi $s2, $s2, 1            # ans++
    jr $ra
elseif:
    blt $a0, $0, done
    blt $a1, $0, done
    bge $a0, $s0, done
    bge $a1, $s1, done
    getOffset($t0, $a0, $a1)
    lw $t0, maze($t0)
    beq $t0, $0, else
    done:
        jr $ra
else:
    getOffset($t0, $a0, $a1)
    li $t1, 1
    sw $t1, maze($t0)
    # dfs(x+1, y)
    addi $sp, $sp, -12
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    sw $ra, 0($sp)
    addi $a0, $a0, 1
    jal dfs
    lw $ra, 0($sp)
    lw $a1, 4($sp)
    lw $a0, 8($sp)
    addi $sp, $sp, 12
    # dfs(x, y+1)
    addi $sp, $sp, -12
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    sw $ra, 0($sp)
    addi $a1, $a1, 1
    jal dfs
    lw $ra, 0($sp)
    lw $a1, 4($sp)
    lw $a0, 8($sp)
    addi $sp, $sp, 12
    # dfs(x-1, y)
    addi $sp, $sp, -12
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    sw $ra, 0($sp)
    addi $a0, $a0, -1
    jal dfs
    lw $ra, 0($sp)
    lw $a1, 4($sp)
    lw $a0, 8($sp)
    addi $sp, $sp, 12
    # dfs(x, y-1)
    addi $sp, $sp, -12
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    sw $ra, 0($sp)
    addi $a1, $a1, -1
    jal dfs
    lw $ra, 0($sp)
    lw $a1, 4($sp)
    lw $a0, 8($sp)
    addi $sp, $sp, 12
    getOffset($t0, $a0, $a1)
    sw $0, maze($t0)
    jr $ra
    
