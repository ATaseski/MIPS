# Ex.2: Da se napise programa vo MIPS koja ke obraboti dadena niza so pocetna adresa smestena vo registerot $s0 i broj na elementi vo nizata smesteni vo $s1. Najprvo da se napravi procedura koja ke proveruva dali daden broj ima ostatok 5 pri delenje so nekoj broj smesten vo $s2. Potoa da se iskoristi ovaa proceduda za da se najde brojot na elementi od nizata koi go zadovoluvaat toj uslov i dokolku istiot e pogolem ili ednakov od 8 da se smesti na memoriska lokacija dadena vo register $s3, a vo sprotiva na memoriska lokacija dadena vo register $s7.

# dadeni registri:
# $s0 - pocetna adresa na nizata 
# $s1 - golemina na nizata  
# $s2 - nekoj daden broj (delitel)
# $s3 - adresata na koja treba da se zachuva brojot na elementi koi go ispolnuvaat uslovot (ako toj e >= 8)
# $s7 - adresata na koja treba da se zachuva brojot na elementi koi go ispolnuvaat uslovot (ako toj e < 8)

# dopolnitelno potrebni ke se: 
# $t1 - broj na izminati/obraboteni elementi od nizata
# $t2 - element od nizata 
# $t3 - broj na elementi od nizata koi go zadovoluvaat uslovot 
# verojatno i nekoi drugi..
# --------------------------------------------------------------------------------

# inicijalizacija 
add $t1, $zero, $zero     # brojacIzminati = 0
add $t3, $zero, $zero 	    # brojacIspolnetUslov = 0 

ciklusZaIzminuvanjeNaElementite:
	# proveri dali se izminati site elementi
	beq $t1, $s1, zapisiRezultat      # ako (brojacIzminati == $s1) skokni na labela zapisiRezultat		
	lw $t2, 0($s0) 	             # $t2 <- tekovniot element od nizata 
	# podgotovka na vlezni argumenti za procedurata 
	add $a0, $t2, $zero    # $a0 <- tekovniot element (prv argument)
	add $a1, $s2, $zero    # $a1 <- dadeniot broj t.e. delitelot (vtor argument)
	jal procedura	             # povik na procedurata 
	# obrabotka na izleznite argumenti od procedurata
	add $t3, $t3, $v0        # brojacIspolnetUslov += izlezot od procedurata 
	addi $t1, $t1, 1           # brojacIzminati ++ 
	addi $s0, $s0, 4          # $s0 <- adresata na sledniot element od nizata 
	j ciklusZaIzminuvanjeNaElementite   # skokni bezuslovno na labela ciklusZaIzminuvanjeNaElementite  
	
zapisiRezultat:	
	slti $s4, $t3, 8           # ako (brojacIspolnetUslov < 8) $s4 = 1, vo sprotivno $s4 = 0
	addi $s5, $zero, 1    # $s5 <- 1  
	beq $s4, $s5, pomalEodOsum      # ako $s4 = 1 skokni na labelata pomalEodOsum
	sw $t3, 0($s3)	          # brojacIspolnetUslov zapisi go na adresata koja se naoga vo $s3
	j kraj
pomalEodOsum:
	sw $t3, 0($s7)	          # brojacIspolnetUslov zapisi go na adresata koja se naoga vo $s7
kraj:
	# potreben e sistemski povik za izlez od programot... nebitno (ostavete prazno)
procedura:
	div $a0, $a1	           # podeli go tekovniot element so dadeniot broj 
	mfhi $t4                      # $t4 <- $a0 % $a1 t.e. ostatokot
	addi $t5, $zero, 5      # $t5 <- brojot 5
	bne $t4, $t5, ostatokotNeEpet
	addi $v0, $zero, 1     # vrati edinica kako izlezen parameter
	j izlezOdProcedura   # skokni na izlezOdProcedura 
	ostatokotNeEpet:
		addi $v0, $zero, 0     # vrati nula kako izlezen parameter
	izlezOdProcedura:
		jr $ra
