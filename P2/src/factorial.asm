.data
result:	.space 4096



.text
main:
li $v0, 5
syscall
move $s0, $v0			# $s0 = n
li $s1, 1			# $s1 = digit
li $t0, 1
sw $t0, result($0)
li $s2, 2
cal_loop:			# $s2 = num
bgt $s2, $s0, cal_done
	move $a0, $s2
	jal mul
	addi $s2, $s2, 1
	j cal_loop	
cal_done:
sub $t0, $s1, 1
print_loop:
blt $t0, 0, print_done
	sll $t1, $t0, 2
	lw $a0, result($t1)
	li $v0, 1
	syscall
	addi $t0, $t0, -1
	j print_loop
print_done: 
li $v0, 10
syscall


mul:
li $s3, 0			# $s3 = carry
li $t0, 0
mul_loop1:
bge $t0, $s1, mul_loop1_done
	sll $t1, $t0, 2
	lw $t2, result($t1)
	mult $a0, $t2		
	mflo $t2			
	add $t2, $t2, $s3	# $t2 = result[i] * num + carry
	li $t3, 10
	divu $t2, $t3
	mfhi $t3		
	sw $t3, result($t1)	# result[i] = prod % 10
	mflo $s3			# carry = prod / 10
	addi $t0, $t0, 1	
	j mul_loop1	
mul_loop1_done:
carry_loop:
ble $s3, $0, carry_loop_done
	li $t0, 10
	divu $s3, $t0
	sll $t0, $s1, 2
	mfhi $t2
	sw $t2, result($t0)
	mflo $s3
	addi $s1, $s1, 1
	j carry_loop
carry_loop_done:
	jr $ra




