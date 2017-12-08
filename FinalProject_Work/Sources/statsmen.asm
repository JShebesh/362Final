	XDEF statsmen
	XREF drawscreen,scoredisp,harvests,pests,fertwtr,drawDL

statsmen:
	ldab harvests
	ldaa #32
	mul
    clra
	jsr hextoascii
	staa scoredisp+9
	stab scoredisp+10
	xgdx
	stab scoredisp+11
	clra
	ldab pests
	jsr hextoascii
	stab scoredisp+22
	xgdx
	stab scoredisp+23
	clra
	ldab fertwtr
	jsr hextoascii
	staa scoredisp+29
	stab scoredisp+30
	xgdx
	stab scoredisp+31
	ldd #scoredisp
	movw #3000,drawDL
	jsr drawscreen
	rts
	
hextoascii:
	ldx #10
	idiv
	xgdx
	pshb
	xgdx
	ldx #10
	idiv
	xgdx
	pshb
	pula
	pulb
	adda #48
	addb #48
	xgdx
	addb #48
	xgdx
	rts
	
	
	