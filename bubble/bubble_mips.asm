.data
	a: .word 9, 8, 6, 5, 1, 2, 3, 4, 32, 50 # int[] a = {9, 8, 6, 5, 1, 2, 3, 4}
	space: .asciiz " "
	newLine: .asciiz "\n"
	n: .word 10 # tamanho do int[] a
	unsortedArrayText: .asciiz "Array não ordenado: "
	sortedArrayText: .asciiz "Array ordenado: "
	swapCountText: .asciiz "Contagem de Trocas: "
.text

main:
		# imprime Array não ordenado:
		li $v0, 4
		la $a0, unsortedArrayText
		syscall
		jal printArray # printArray() --> imprime o array não ordenado
		
		la $a0, a # args0 --> endereço do int a[]
		lw $a1, n # args1 --> n = 8
		jal sort # sort(int[] a, int n)
		
		# imprime Contagem de Trocas:
		li $v0, 4
		la $a0, swapCountText
		syscall
		
		# imprime o valor da swapCount calculado na função sort
		li $v0, 1
		addi $a0, $s0, 0
		syscall
		
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
     	
		
sort: # segue o Algoritmo Bubble Sort

	# $t0 = j 
	# $t1 = i 
	# $t2 = n-1
	# $t3 = endereço de int[] a 
	# $t4 = iMin
	# $t5 = n
	# $s0 = swapCount 
	
	addi $t4, $zero, 0 # iMin = 0
	addi $t5, $a1, 0 # $ t5 = n
	addi $s0, $zero, 0 # swapCount = 0;
	
	add $t0, $zero, 0 # $t0 --> j = 0
	subi $t2, $a1, 1 # $t2 --> (n - 1)
	addi $t3, $a0, 0 # $ t3 --> endereço de int[] a
	
	for_loop_1:
		bge $t0, $t2, return_swap_count # j >= (n-1) FAIL --> sair do loop externo, retornar swapCount
		addi $t4, $t0, 0 # iMin = j
		addi $t1, $t0, 1 # $t1 --> i = j + 1
		
		for_loop_2:
			bge $t1, $t5, exit_for_loop_2 # i >= n --> FAIL, sair do loop interno
			
			sll $t6, $t1, 2 # i * 2^2
			addu $t6, $t6, $t3 # endereço de a[i]
			lw $s1, 0($t6) # $s1 --> a[i]
			
			sll $t7, $t4, 2 # iMin * 2^2
			addu $t7, $t7, $t3 # a[iMin]
			lw $s2, 0($t7) # $s2 --> a[iMin]
			
			bge $s1, $s2, increment_for_loop_2 # a[i] >= a[iMin] --> FAIL, sair do loop interno
			
			addi $t4, $t1, 0 # iMin = i
			
			addi $t1, $t1, 1 # i++
			j for_loop_2
		
		increment_for_loop_2:
			addi $t1, $t1, 1
			j for_loop_2
			
		exit_for_loop_2:
			beq $t4, $t0, exit_if_cond # iMin == j --> FAIL, sair se condição
			
			addi $sp, $sp, -4 # Alocar pilha
			sw $ra, 0($sp) # armazenar endereço de retorno
			
			addi $a0, $t3, 0 # args0 --> endereço de int[]a
			addi $a1, $t0, 0 # args1 --> j
			add $a2, $t4, 0 # args2 --> iMin
			jal swap # swap(a, j, iMin)
			
			lw $ra, 0($sp) # recuperar endereço de retorno
			addi $sp, $sp, 4 # Desalocar pilha
			
			addi $s0, $s0, 1 # swapCount++
			addi $t0, $t0, 1 # j++ 
			j for_loop_1
			
		exit_if_cond:
			addi $t0, $t0, 1 # j++
			j for_loop_1
		
	return_swap_count:
		jr $ra # endereço de retorno