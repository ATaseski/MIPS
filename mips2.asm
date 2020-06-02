# Ex.3: Da se napise MIPS programa koja za dadena niza, cija sto adresa na pocetniot element se naoga vo register $s1, ke go presmeta zbirot na parnite broevi. Nizata ima elementi vo vrednost razlicni od nukla. Za proverka dali daden broj e paren da se kreira procedura koja ke vraka 1 dokolku brojot e paren i 0 dokolku brojot e neparen. Zbirot na parnite broevi da se zacuva vo register $s3.

# dadeni registri:
# $s1 - pocetna adresa na nizata 
# $s3 - zbirot na parnite broevi od nizata

# dopolnitelno potrebni ke se: 
# $t1 - broj na izminati/obraboteni elementi od nizata
# $t2 - element od nizata 
# verojatno i nekoi drugi..
# ----------------------------------------------------------------------

# inicijalizacija 
add $t1, $zero, $zero 	   # brojacIzminati = 0
add $s3, $zero, $zero    # zbirParni = 0 

ciklusZaIzminuvanjeNaElementite:
	lw $t3, 0($s1)              # $t3 <- tekovniot element od nizata 
	# proveri dali se izminati site elementi (t.e. proveri dali elementot > 0)
	beq $t3, $zero, kraj    # ako (elementot == 0) skokni na labela kraj		
	# podgotovka na vlezni argumenti za procedurata 
	add $a0, $t3, $zero    # $a0 <- tekovniot element (prv argument)
	jal procedura	             # povik na procedurata 
	# obrabotka na izleznite argumenti od procedurata
	beq $v0, $zero, neEparen
	addi $s3, $s3, $t3       # zbirParni += elementot
	neEparen:
		addi $t1, $t1, 1     # brojacIzminati++ 
		addi $s1, $s1, 4     # $s1 <- adresata na sledniot element od nizata 
	j ciklusZaIzminuvanjeNaElementite    # skokni bezuslovno na labela ciklusZaIzminuvanjeNaElementite
kraj:
	# izlez od programot

procedura:  
	addi $t4, 2    	       # $t4 <- 2
	div $a0, $t4     	       # podeli go elementot so 2
	mfhi $t5                  # $t5 <- elementot % 2 
	bne $t5, $zero, neEparen     # ako ($t5 != 0) skokni na neEparen
 	addi $v0, $zero, 1                   # podgotvi edinica kako izlezen parametar 
	j izlezOdProcedura
	neEparen:
		addi $v0, $zero, 0      # podgotvi nula kako izlezen parametar 
	izlezOdProcedura:
		jr $ra
