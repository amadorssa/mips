# Algoritmo de selection sort http://en.wikipedia.org/wiki/Selection_sort

	.data
a:	.word 7, 2, 13, 15, 7, 8, 1, 10
n:	.word 8

	.text
	li $t0, 0 # i
	li $t1, 0 # j
	li $t2, 0 # iMin
	lw $t3, n # n
	addi $t4, $t3, -1 # n - 1
	la $t5, a  # t5 apunta al arreglo
	
forj:	beq $t1, $t4, final2
	move $t2, $t1
	addi $t0, $t1, 1
fori:	beq $t0, $t3, final1
	
	move $t6, $t0
	mul $t6, $t6, 4
	add $t6, $t5, $t6
	lw $t6, 0($t6) # a[i]

	move $t7, $t2
	mul $t7, $t7, 4
	add $t7, $t5, $t7,
	lw $t7, 0($t7) # a[iMin]
	
	bge $t6, $t7, final3
	move $t2, $t0

final3: addi $t0, $t0, 1
	j fori

final1:
	beq $t2, $t1, final4
	
	# obtiene a[j]
	move $t6, $t1
	mul $t6, $t6, 4
	add $t6, $t5, $t6
	lw $s0, 0($t6)
	
	# obtiene a[iMin]
	move $t7, $t2
	mul $t7, $t7, 4
	add $t7, $t5, $t7
	lw $s1, 0($t7)
	
	# swap
	sw $s0, 0($t7)
	sw $s1, 0($t6)

final4:
	addi $t1, $t1, 1
	j forj

final2:
	# stop
	li $v0, 10
	syscall
