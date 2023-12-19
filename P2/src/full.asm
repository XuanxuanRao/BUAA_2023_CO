.data
path:       .space  40
visited:    .space  40
line:       .asciiz "\n"
space:      .asciiz " "


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

.macro printStr(%str)
    addi $sp, $sp, -8
    sw $v0, 4($sp)
    sw $a0, 0($sp)
    move $a0, %str
    li $v0, 4    
    syscall
    lw $v0, 4($sp)
    lw $a0, 0($sp)
    addi $sp, $sp, 8
.end_macro


.text
li $v0, 5
syscall
move $s0, $v0       # $s0 = n
li $s1, 0           # $s1 = pathSize
jal permute
li $v0, 10
syscall




permute:
bne     $s1, $s0, else
# print ans stored in array-path
li $t0, 0
output_loop:
    bge $t0, $s0, output_loop_done
    sll $t1, $t0, 2
    lw $t1, path($t1)
    printInt($t1)
    la $a0, space
    printStr($a0)
    addi $t0, $t0, 1
    j output_loop
output_loop_done:
la $a0, line
printStr($a0)
jr $ra


else:
li $a0, 0
permute_loop:
    bge $a0, $s0, permute_loop_done
    sll $t0, $a0, 2             # offset of visited[i]
    lw  $t0, visited($t0)
    bne $t0, $0, continue
        addi $t0, $a0, 1
        sll $t1, $s1, 2         # offset of path[pathSize]
        sw $t0, path($t1)       # path[pathSize] = i + 1
        li $t0, 1           
        sll $t1, $a0, 2         # offset of visited[i]
        sw $t0, visited($t1)    # visited[i] = 1
        addi $s1, $s1, 1        # pathSize++

        # push into stack
        addi $sp, $sp, -8
        sw $ra, 4($sp)
        sw $a0, 0($sp)
        jal permute
        # pop from stack
        lw $a0, 0($sp)
        lw $ra, 4($sp)
        addi $sp, $sp, 8

        addi $s1, $s1, -1       # pathSize--
        sll $t1, $a0, 2         # offset of visited[i]
        sw $0, visited($t1)    # visited[i] = 0
    continue:
    addi $a0, $a0, 1
    j permute_loop
permute_loop_done:
jr $ra
