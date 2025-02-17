	.data
msg_before: .asciiz "Antes de ordenar, los números son:\n"
msg_after: .asciiz "Después de ordenar, los números son:\n"
error_msg: .asciiz "Error: El tamaño del arreglo debe ser al menos 1.\n"
space: .asciiz " "
newline: .asciiz "\n"

a:	.word 5, 3, 8, 6, 2, 7, 4, 10, 1, 9
n:	.word 10

	.text
	
	# Cargar el tamaño del arreglo en $t3
	lw $t3, n 
	
	# Si n < 1, imprimir error y salir
	blez $t3, error_exit
	
	# Cargar la dirección del arreglo en $t5
	la $t5, a 
	
	# Imprimir el mensaje antes de ordenar
	li $v0, 4
	la $a0, msg_before
	syscall
	
	# Inicializar i en 0
	li $t0, 0 
	
imprimir_arreglo:
	bge $t0, $t3, fin_impresion # Si i >= n, termina impresión
	
	mul $t1, $t0, 4 # Calcular desplazamiento i * 4
	add $t1, $t5, $t1 # Dirección de a[i]
	lw $a0, 0($t1) # Cargar a[i] en $a0
	
	li $v0, 1 # Syscall para imprimir entero
	syscall
	
	# Imprimir un espacio
	li $v0, 4
	la $a0, space
	syscall
	
	addi $t0, $t0, 1 # i++
	j imprimir_arreglo # Repetir
	
fin_impresion: 
	# Imprimir un salto de linea
	li $v0, 4
	la $a0, newline
	syscall
	
	li $t0, 0 # i
	li $t1, 0 # j
	li $t2, 0 # iMax
	addi $t4, $t3, -1 # n - 1
	
forj:	
	beq $t1, $t4, ordenar_terminado
	move $t2, $t1
	addi $t0, $t1, 1

fori:	
	beq $t0, $t3, final1
	
	move $t6, $t0
	mul $t6, $t6, 4
	add $t6, $t5, $t6
	lw $t6, 0($t6) # a[i]

	move $t7, $t2
	mul $t7, $t7, 4
	add $t7, $t5, $t7
	lw $t7, 0($t7) # a[iMax]
	
	ble $t6, $t7, final3
	move $t2, $t0

final3: 
	addi $t0, $t0, 1
	j fori

final1:
	beq $t2, $t1, final4
	
	# Obtiene a[j]
	move $t6, $t1
	mul $t6, $t6, 4
	add $t6, $t5, $t6
	lw $s0, 0($t6)
	
	# Obtiene a[iMax]
	move $t7, $t2
	mul $t7, $t7, 4
	add $t7, $t5, $t7
	lw $s1, 0($t7)
	
	# Swap
	sw $s0, 0($t7)
	sw $s1, 0($t6)

final4:
	addi $t1, $t1, 1
	j forj

# Cuando termina el ordenamiento
ordenar_terminado:
	# Imprimir el mensaje despues de ordenar
	li $v0, 4
	la $a0, msg_after
	syscall

	# Imprimir el arreglo ordenado
	li $t0, 0	# Inicializar i en 0

imprimir_ordenado:
	bge $t0, $t3, fin_impresion_ordenado # Si i >= n, termina impresión
	
	mul $t1, $t0, 4 # Calcular desplazamiento: i * 4
	add $t1, $t5, $t1 # Dirección de a[i]
	lw $a0, 0($t1) # Cargar a[i] en $a0
	
	li $v0, 1 # Syscall para imprimir entero
	syscall
	
	# Imprimir un space

	li $v0, 4
	la $a0, space
	syscall
	
	addi $t0, $t0, 1 # i++
	j imprimir_ordenado # Repetir
	
fin_impresion_ordenado:
	# Imprimir un salto de linea
	li $v0, 4
	la $a0, newline
	syscall

	# Terminar el programa
	li $v0, 10
	syscall

# Si el tamaño del arreglo es menor que 1, se imprime un mensaje de error y se sale
error_exit:
	# Imprimir mensaje de error
	li $v0, 4
	la $a0, error_msg	# Cargar la dirección del mensaje de error
	syscall
	
	# Salir del programa
	li $v0, 10
	syscall
