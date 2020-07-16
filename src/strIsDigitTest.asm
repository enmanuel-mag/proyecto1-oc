.data
	userInput:	.space 20
.text
	main:
		# Getting text from the user
		li $v0, 8
		la $a0, userInput
		li $a1, 20
		syscall
		
		jal strIsDigit
		
		move $t7, $v0
		li $v0, 1
		move $a0, $t7
		syscall	
	end:	
		# Tell the system this is the end of the main
		li $v0, 10
		syscall

