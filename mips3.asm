# Ex.4: Da se napise programa vo MIPS koja za dadena  niza od IP adresi smesteni vo $s1 kade prviot element ja pretstavuva goleminata na nizata, ke opredeli kolku adresi pripagaat na mreza smestena vo register $s0. Brojot na IP adresi koi pripagaat na dadena mreza da se smesti vo memorijata na adresa smestena vo $s7. Vo sprotiva da se smesti vrednost 0.

# dadeni registri:
# $s1 - pocetna adresa na nizata 
# $s0 - mreza
# $s7 - adresata na koja treba da se zachuva brojot na adresi koi go ispolnuvaat uslovot

# dopolnitelno potrebni ke se: 
# $t1 - broj na izminati/obraboteni elementi od nizata
# $t2 - goleminata na nizata 
# $t3 - element od nizata 
# $t4 - brojot na adresi koi go ispolnuvaat uslovot 
# verojatno i nekoi drugi..
# ----------------------------------------------------------------------

# inicijalizacija 
add $t1, $zero, $zero 	   # brojacIzminati = 0
add $t4, $zero, $zero    # brojacIspolnetUslov = 0 

lw $t2,0($s1)       # $t2 <- goleminata na nizata
add $s1, $s1, 4    # $s1 <- pocetna adresa na nizata od IP adresi

ciklusZaIzminuvanjeNaElementite:
	# proveri dali se izminati site elementi 
	beq $t1, $t2, kraj        # ako (brojacIzminati == $s1) skokni na labela kraj		
	lw $t3, 0($s1)               # $t3 <- tekovniot element od nizata 
	# podgotovka na vlezni argumenti za procedurata 
	add $a0, $t3, $zero    # $a0 <- tekovniot element (prv argument)
	add $a1, $s0, $zero    # $a1 <- mrezata (vtor argument)
	jal procedura	             # povik na procedurata 
	add $t4, $t4, $v0         # brojacIspolnetUslov += izlezot od procedurata 
	addi $t1, $t1, 1            # brojacIzminati ++ 
	addi $s1, $s1, 4           # $s1 <- adresata na sledniot element od nizata 
	j ciklusZaIzminuvanjeNaElementite      # skokni bezuslovno na labela ciklusZaIzminuvanjeNaElementite  
 
kraj:
	sw $t4, 0($s7)              # brojacIspolnetUslov zapisi go na adresata koja se naoga vo $s7
	# izlez od programot
procedura:
	srl $a0, $a0, 8             # pomesti go elementot (IP adresata) za 8 poziicii vo desno 
	srl $a1, $a1, 8             # pomesti ja mrezata za 8 pozicii vo desno
	xor $t5, $a0, $a1       # ako $t5 != 0, tekovnata IP adresa ne pripaga na dadenata mreza 
	bne $t5, $zero, nePripagaNaMrezata
		addi $v0, $zero, 1    # podgotvi edinica kako izlezen parametar
		j izlezOdProcedura
	nePripagaNaIsMrezata:
		addi $v0, $zero, 0    # podgotvi edinica kako izlezen parametar
	izlezOdProcedura:
		jr $ra
