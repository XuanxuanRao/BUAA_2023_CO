.text
ori $t0, 6
tag1:
	beq $t0, $0, done
	add $a0, $t0, $0
	jal tag2
	add $t4, $t0, $t0
	add $t4, $t4, $t4
	lb $s1, 2($t4)
	ori $t3, $0, 2	
	sub $t0, $t0, $t3
	jal tag1	
done:
beq $t0, $0, finish
tag2:
lui $s2, 0x1234
add $t1, $a0, $a0
add $t1, $t1, $t1
ori $t4, $t4, 2
add $t1, $t1, $t4
sw $s2, -2($t1)
jr $ra
finish:
