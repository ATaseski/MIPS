# da se napise programa koja ke izvrsi sobiranje na site pozitivni parni 
# broevi od dadena niza i rezultatot ke go socuva vo registerot $S0
# nizata e proizvolna, kako i brojot na elementi (vnesete 10 do 20 elementi)

.data
array: .space 4000   
message1: .asciiz "Vnesete go brojot na elementi za nizata: \n"
message2: .asciiz "Vnesete gi elementite od nizata (sekoj vo nov red): \n"
message3: .asciiz "\nSumata na pozitivnite parni broevi iznesuva: "
 
.text
.global main  

main:
	li $v0, 4    
	la $a0, message1  # print: "Vnesete go brojot na elementi za nizata: "
	syscall     
	
	li $v0, 5      # read input (n - goleminata na nizata)
	syscall         
	move $s2, $v0  # n zacuvaj go vo $S2 
		
	li $v0, 4
	la $a0, message2   # print: "Vnesete gi elementite od nizata (sekoj vo nov red): "
	syscall  
	
	la $s1, array  # nizata so elementi zacuvaja vo $s1 

	LOOPINPUT:
		li $v0, 5    # read input (element od nizata)
		syscall      
		sw $v0, 0($s1)
		addi $s1, $s1, 4  # pomesti na sledna pozicija (1 broj (integer) = 32 bita = 4 bajti)
		addi $t1, $t1, 1  # i++
		bne $t1, $s2, LOOPINPUT # for(t1=0; t1 != n; i++)

		la $s1, array
		sub $t1, $t1, $t1 

	PROVERKA: 
		lw $t3, 0($s1)   
		addi $s1, $s1, 4    
		
		bge $t3, $zero, PAREN  
		j PROVERKA
		
	PAREN:	
		addi $s3, $zero, 2
		div $t3, $s3  # $HI <- $s1 mod $s3
		mfhi $s4   # vo $s4 zacuvaj go ostatokot od delenjeto
		beq $s4, $zero, DODADI  # ako e paren dodadi go na sumata 
		j PROVERKA
		
		
	DODADI:
		add $t4, $t3, $t4   
		addi $t1, $t1, 1    
		bne $t1, $s2, PROVERKA # if(t1 != n) proverka za nareden broj
 		
 		li $v0, 4      
 		la $a0, message3 # print: "Sumata na pozitivnite parni broevi iznesuva: "
 		syscall
 		 		
		move $a0, $t4  # ispecati ja sumata
		li $v0, 1   	
		syscall

li $v0, 10
syscall     
