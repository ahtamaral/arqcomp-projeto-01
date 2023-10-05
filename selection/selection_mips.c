.data # Especificações de algumas variáveis. Lida com dados na memória principal.

	a: .word 64, 34, 25, 12, 22, 11, 90, 3, 55, 78 # int[] a = {64, 34, 25, 12, 22, 11, 90, 3, 55, 78}
	n: .word 10 # tamanho do int[] a
	
	space: .asciiz " "
	newLine: .asciiz "\n"
	
	unsortedArrayText: .asciiz "Array não ordenado: "
	sortedArrayText: .asciiz "Array ordenado: "
	swapCountText: .asciiz "Contagem de Trocas: "
	
	
.text # Instruções em si.
main:
	# imprime Array não ordenado:
	li $v0, 4
	la $a0, unsortedArrayText
	syscall
	jal printArray # printArray() --> imprime o array não ordenado

	la $a0, a # args0 --> endereço do int a[]
	lw $a1, n # args1 --> n = 8
	jal sort # sort(int[] a, int n)

	# imprime nova linha
	li $v0, 4
	la $a0, newLine
	syscall
		
	# imprime Array ordenado:
	li $v0, 4
	la $a0, sortedArrayText
	syscall
	jal printArray # imprime o array ordenado
	
	# Fim do Programa
	li $v0, 10
	syscall



 printArray: # imprime o array não ordenado e ordenado
	la $t1, a # endereço do int a[]
	lw $t3, n # n 
	addi $t0, $zero, 0 # i = 0
	
	while: 
		bge $t0, $t3, exit # 
		sll $t2, $t0, 2 # i * 2^2
		addu $t2, $t2, $t1 # endereço de a[i]
		
		# imprime o número atual em int[] a
		li $v0, 1
		lw $a0, 0($t2)
		syscall
		
		# imprime " "
		li $v0, 4
		la $a0, space
		syscall
		
		addi $t0, $t0, 1 # i++
		j while 
	exit: 
		# imprime nova linha
		li $v0, 4
		la $a0, newLine
		syscall
		
		jr $ra # endereço de retorno

swap: # função para trocar elementos em a, j, iMin (código citado de http://www-inst.eecs.berkeley.edu/~cs61c/sp13/disc/04/Disc4Soln.pdf)
	sll $a1, $a1, 2
     	sll $a2, $a2, 2
     	addu $a1, $a0, $a1
     	addu $a2, $a0, $a2
     	lw $t8, 0($a1)
     	lw $t9, 0($a2) 	
     	sw $t8, 0($a2)
     	sw $t9, 0($a1)
     	jr $ra

sort:
	
	# $t0 -> endereço do array a 
	# $t1 -> n-1 (último índice de a)
	# $t2 -> i
	# $t3 -> j
	# $t4 -> min_idx
	# $t5 -> n
	
	# $t6 -> 
	# $t7 ->
	
	# Carrega variáveis declaradas na seção .data nos registradores $t0 e $t1.
	add $t0, $a0, $zero
	add $t1, $a1, $zero
	subi $t1, $t1, 1 # n = n - 1;
	add $t5, $a1, $zero
	#subi $t5, $t1, 2 # n = n - 2;
	
	# i = 0; j = 0;
	addi $t2, $zero, 0
	addi $t3, $zero, 0
	
	outer_for: # for (i = 0; i < n - 1; i++) {
	
		# Verifica i >= n - 1
		bge $t2, $t1, exit_outer_for
		
		# min_idx = i
		add $t4, $t2, $zero
		
		# printf("%d%d", i, min_idx)
		li $v0, 1
		move $a0, $t2
		syscall
		move $a0, $t4
		syscall
		
		#inner_for: # for (j = i + 1; j < n; j++)
		#	
		#	bge $t3, $t5, exit_inner_for
		#	
			
		#	add $t3, $t3, 1
			#j inner_for		
			
		#exit_inner_for:
		
		addi $t2, $t2, 1
		j outer_for
	
	exit_outer_for:
	
end_sort:
	jr $ra