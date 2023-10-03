.data # Especificações de algumas variáveis. Lida com dados na memória principal.
	msg: .asciiz  "Artur Amaral!" # Declara ascii que termina em EOS e atribui valor.

 
.text # Instruções em si.
	li $v0, 4 # Instrução para impressão de string
	la $a0, msg # Atribui o valor de msg para $a0
	syscall # Imprime o que estiver no registrador $a0 (Só difere pra ponto flutuante)
	