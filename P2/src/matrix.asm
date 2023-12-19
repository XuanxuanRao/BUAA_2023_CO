.data
matrix1:    .space  256
matrix2:    .space  256
space:      .asciiz " "
line:       .asciiz "\n"


.macro printInt(%int)
    addi $sp, $sp, -8
    sw $a0, 4($sp)
    sw $v0, 0($sp)
    move $a0, %int
    li $v0, 1
    syscall
    lw $v0, 0($sp)
    lw $a0, 4($sp)
    addi $sp, $sp, 8
.end_macro


.macro getOffset(%ans, %row, %col)
    sll %ans, %row, 3
    add %ans, %ans, %col
    sll %ans, %ans, 2
.end_macro

.text
li $v0, 5
syscall
move $s0, $v0       # $s0 = n

li $t0, 0
input_loop1_i:
    bge $t0, $s0, input_loop1_i_done
    li $t1, 0
    input_loop1_j:
        bge $t1, $s0, input_loop1_j_done
        li $v0, 5
        syscall
        getOffset($t2, $t0, $t1)
        sw $v0, matrix1($t2)
        addi $t1, $t1, 1
        j input_loop1_j
    input_loop1_j_done:
    addi $t0, $t0, 1
    j input_loop1_i
input_loop1_i_done:

li $t0, 0
input_loop2_i:
    bge $t0, $s0, input_loop2_i_done
    li $t1, 0
    input_loop2_j:
        bge $t1, $s0, input_loop2_j_done
        li $v0, 5
        syscall
        getOffset($t2, $t0, $t1)
        sw $v0, matrix2($t2)
        addi $t1, $t1, 1
        j input_loop2_j
    input_loop2_j_done:
    addi $t0, $t0, 1
    j input_loop2_i
input_loop2_i_done:


li $t0, 0
cal_loop_i:
    bge $t0, $s0, cal_loop_i_done
    li $t1, 0
    cal_loop_j:
        bge $t1, $s0, cal_loop_j_done
        li $t2, 0                       # k
        li $t3, 0                       # $t3 = ans
        cal_loop_k:
            bge $t2, $s0, cal_loop_k_done
            getOffset($t4, $t0, $t2)
            lw $t4, matrix1($t4)        # $t4 = matrix1[i][k]
            getOffset($t5, $t2, $t1)
            lw $t5, matrix2($t5)        # $t5 = matrix2[k][j]
            mult $t4, $t5
            mflo $t4
            add $t3, $t3, $t4
            addi $t2, $t2, 1
            j cal_loop_k
        cal_loop_k_done:
        printInt($t3)
        la $a0, space
        li $v0, 4
        syscall
        addi $t1, $t1, 1
        j cal_loop_j
    cal_loop_j_done:
    la $a0, line
    li $v0, 4
    syscall
    addi $t0, $t0, 1
    j cal_loop_i
cal_loop_i_done:

li $v0, 10
syscall
