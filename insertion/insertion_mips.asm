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
	
	# $t0 -> i 
	# $t1 -> j
	# $t2 -> n
	# $t3 -> & a
	# $t5 -> key
	
	addi $t0, $zero, 1 # i = 1
	subi $t2, $a1, 1 # $t2 --> (n - 1) Fim do for
	addi $t3, $a0, 0 # $ t3 --> endereço de int[] a
	
	for: # for (int i = 0; i < n; i++)
		bgt $t0, $t2, exit_for # Se i >= n, encerra for

		# j = i - 1	
		add $t1, $zero, $t0 	# j = 0 + i
		subi $t1, $t1, 1 	# j = j -1
		
		# key = a[i]; ($t5 recebe a[i])
		sll $t4, $t0, 2
		add $t4, $t4, $t3
		lw $t5, 0($t4)
		
		li $v0, 1
		move $a0, $t0
		syscall
		move $a0, $t1
		syscall
        	move $a0, $t5
		syscall	
		
		# key -> $t5
		# a[j] -> $s0
		sll $s7, $t1, 2
		add $s7, $s7, $t3
		lw $s0, 0($s7)
		
		move $a0, $s0
		syscall	
		
		# while (j >= 0 && arr[j] > key) 
		while_sort:
			# Verifica (j >= 0)
			blt $t1, $zero, end_while # se j <= 0
			
			# Print j
			move $a0, $t1
			syscall
			
			# TODO: arr[j + 1] = arr[j];
			subi $t1, $t1, 1 # j--;
			
			j while_sort
			
		end_while:
		
		# TODO: arr[j + 1] = key;
		
		add $t0, $t0, 1 # i++
		j for
		
	exit_for:
	
end_sort:
	jr $ra
	







