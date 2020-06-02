# da se napise programa vo MIPS koja ke opredeli NZS za dva broja 

.data
.text
li $v0, 5 # podgotovka za chitanje integer
syscall 
addi $t0, $v0, 0 # prviot vnesen broj ke go iskopirame vo $t0

li $v0, 5 # podotovka za chitanje drug integer 
syscall 
addi $t1, $v0, 0 # vtoriot vnesen broj ke go iskopirame vo %t1 

# $t2 - ke go sodrzi pogolemiot od dvata vneseni broja 
# $t3 - ke go sodrzi pomaliot od dvata vneseni broja 

beq $t0, $t1, istiSe
bgt $t0, $t1, pogolemEprviot
j pogolemEvtoriot

pogolemEprviot:   
addi $t2, $t0, 0 # vo $t2 iskopiraj go prviot (pogolemiot) broj
addi $t3, $t1, 0 # vo $t3 iskopiraj go vtoriot (pomaliot) broj
j labelaFaktor 

pogolemEvtoriot:
addi $t2, $t1, 0 # vo $t2 iskopiraj go vtoriot (pogolemiot) broj
addi $t3, $t0, 0 # vo $t3 iskopiraj go prviot (pomaliot) broj
j labelaFaktor 

istiSe:
addi $t2, $t0, 0 # vo $t2 iskopiraj go prviot broj
addi $t3, $t1, 0 # vo $t3 iskopiraj go vtoriot broj 

labelaFaktor:
addi $t5, $t2, 0  # $t5 - faktor od pogolemiot broj 

presmetka:
div $t5, $t3 
mfhi $t4 # $t4 - ostatokot od delenjeto na faktorot od pogolemiot so pomaliot broj 
beq $t4, $zero, kraj
add $t5, $t5, $t2 # $t5 <- $t5 + $t2 
j presmetka

kraj:
addi $a0, $t5, 0 # vo $a0 iskopiraj ja vrednosta od $t5 (t.e. NZS od dvata broja)
li $v0, 1 # podgotovka za pechatenje na integer 
syscall # NZS-to ke se ispechati na ekran
 
li $v0, 10 
syscall # kraj na programot   
