.data
f:	.space  1024
h:	.space  1024
space:	.asciiz " "
line:	.asciiz "\n"

.macro getOffset(%ans, %row, %col)
	sll %ans, %row, 4
	add %ans, %ans, %col
	sll %ans, %ans, 2
.end_macro


.text
li $v0, 5
syscall
move $s0, $v0		# $s0 = m1
li $v0, 5
syscall
move $s1, $v0		# $s1 = n1
li $v0, 5		
syscall
move $s2, $v0		# $s2 = m2
li $v0, 5
syscall
move $s3, $v0		# $s3 = n2

li $t0, 0
f_input_i:
	bge $t0, $s0, f_input_i_done
	li $t1, 0
	f_input_j:
		bge $t1, $s1, f_input_j_done
		li $v0, 5
		syscall
		getOffset($t2, $t0, $t1)
		sw $v0, f($t2)
		addi $t1, $t1, 1
		j f_input_j
	f_input_j_done:
	addi $t0, $t0, 1
	j f_input_i
f_input_i_done:

li $t0, 0
h_input_i:
	bge $t0, $s2, h_input_i_done
	li $t1, 0
	h_input_j:
		bge $t1, $s3, h_input_j_done
		li $v0, 5
		syscall
		getOffset($t2, $t0, $t1)
		sw $v0, h($t2)
		addi $t1, $t1, 1
		j h_input_j
	h_input_j_done:
	addi $t0, $t0, 1
	j h_input_i
h_input_i_done:

sub $s4, $s0, $s2
sub $s5, $s1, $s3
li $a0, 0
loop_i:
	bgt $a0, $s4, loop_i_done
	li $a1, 0
	loop_j:
		bgt $a1, $s5, loop_j_done
		jal cal
		addi $sp, $sp, -4
		sw $a0, 0($sp)
		move $a0, $v0
		li $v0, 1
		syscall
		lw $a0, 0($sp)
		addi $sp, $sp, 4
		addi $sp, $sp, -8
		sw $a0, 4($sp)
		sw $v0, 0($sp)
		la $a0, space
		li $v0, 4
		syscall
		lw $v0, 0($sp)
		lw $a0, 4($sp)
		addi $sp, $sp, 8
		addi $a1, $a1, 1
		j loop_j
	loop_j_done:
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $v0, 0($sp)
	la $a0, line
	li $v0, 4
	syscall
	lw $v0, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	addi $a0, $a0, 1
	j loop_i
loop_i_done:
li $v0, 10
syscall


cal:
li $t0, 0
li $v0, 0
cal_i:
	bge $t0, $s2, cal_i_done
	li $t1, 0
	cal_j:
		bge $t1, $s3, cal_j_done
		add $t2, $t0, $a0
		add $t3, $t1, $a1
		getOffset($t2, $t2, $t3)
		lw $t2, f($t2)
		getOffset($t3, $t0, $t1)
		lw $t3, h($t3)
		mult $t2, $t3
		mflo $t2
		add $v0, $v0, $t2
		addi $t1, $t1, 1
		j cal_j
	cal_j_done:
	addi $t0, $t0, 1
	j cal_i
cal_i_done:
	jr $ra