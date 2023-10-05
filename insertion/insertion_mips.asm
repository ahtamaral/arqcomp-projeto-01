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

sort:
	
	# $t0 -> endereço do array a 
	# $t1 -> n-1 (último índice de a)
	# $t2 -> i
	# $t3 -> j
	# $t4 -> key
	
	# $t5 -> tmp
	# $t6 -> a[j]
	# $t7 ->
	
	# Carrega variáveis declaradas na seção .data nos registradores $t0 e $t1.
	add $t0, $a0, $zero
	add $t1, $a1, $zero
	subi $t1, $t1, 1 # n--;
	
	# i = 1
	addi $t2, $zero, 1
	addi $t3, $zero, 0
	
	for: # for (int i = 0; i < n; i++)

		bgt $t2, $t1, exit_for

		# key = arr[i];
		sll $t5, $t2, 2 
		add $t5, $t5, $t0
		lw $t4, 0($t5)
		
		# j = i - 1
		subi $t3, $t2, 1
	
		while_sort:

			# Verifica j < 0
			blt $t3, $zero, exit_while_sort
		
			# Carrega a[j] em $t6
			sll $t5, $t3, 2
			add $t5, $t5, $t0
			lw $t6, 0($t5)
			
			# Verifica a[j] > key
			ble $t6, $t4, exit_while_sort
		
			# printf("%d%d%d", i,j,key); (Para debug)
			#li $v0, 1
			#move $a0, $t2
			#syscall
			#move $a0, $t3
			#syscall
       			#move $a0, $t4
			#syscall
			#move $a0, $t6
			#syscall
			
			# ------------
			# arr[j + 1] = arr[j];
			# Sei quem é a a[j]. Já foi carregado. Quero apenas dar um store em a[j+1]
			
			# $t5 recebe j + 1
			addi $t5, $t3, 1
			
			# save word a[j] em a[j+1]
			sll $t7, $t5, 2
			add $t7, $t7, $t0
			sw $t6, 0($t7)
			lw $t5, 0($t7)
			
			#move $a0, $t5
			#syscall
			
			# ------------			
			
			# j--;
			subi $t3, $t3, 1
			
			j while_sort
			
		exit_while_sort:
		
		# --------
		# arr[j + 1] = key;
		addi $t5, $t3, 1
		sll $t7, $t5, 2
		add $t7, $t7, $t0
		sw $t4, 0($t7)
		lw $t5, 0($t7)
		
		#move $a0, $t5
		#syscall
		# --------
	
		# i++ }
		addi $t2, $t2, 1
		j for
	
	exit_for:
			
	
end_sort:
	jr $ra