	XDEF flowctrl
	XREF port_t,ferterr,lastscreen,err1,gamestate,wtrerr,wtrdisp,fertdisp,drawDL,cropstats,exitflg,drawscreen,Keyboard,SWstatus,fertDC,wtrDC,menuNum,sub1,sub2,mainmenu,display_string,wtrctrldisp,fertctrldisp,
	 
	
flowctrl:
	movb #$00,SWstatus
	movb #$01,exitflg
	ldaa gamestate
	cmpa #02
	bge contflw
	ldd #err1
	jsr drawscreen
	lbra endflow
contflw:
	ldaa port_t
	anda #%00000011
	cmpa #$01
	beq wtrctrl
	cmpa #$02
	lbeq fertctrl
	lbra endflow
	
	
wtrctrl:
    ldaa cropstats
    anda #%00000010
    beq notwatered
    ldd #wtrerr
    jsr drawscreen
    lbra endflow
notwatered:
    ldd #wtrdisp
    jsr drawscreen
wtrlp:
	ldd #wtrctrldisp
	movw #2500,drawDL
	std lastscreen
	jsr drawscreen
	ldaa port_t
    bita #%00000001
    lbeq endflow
	jsr Keyboard
	cmpa #10
	beq increase
	cmpa #11
	beq decrease
	ldaa port_t
	bra wtrlp
	
increase:
	clra
	clrb
	ldab wtrDC
	cmpb #60
	bne inc
	movb #' ',wtrctrldisp+28
    movb #'M',wtrctrldisp+29
    movb #'A',wtrctrldisp+30
    movb #'X',wtrctrldisp+31
    bra wtrlp    
inc:
	addb #6
	stab wtrDC
	ldx #6
	idiv
	clra
	clrb
	xgdx
	addb #48
	ldaa wtrDC
	cmpa #60
	beq maxi
	movb #' ',wtrctrldisp+28
	stab wtrctrldisp+29
	movb #'0',wtrctrldisp+30
	movb #'%',wtrctrldisp+31
	lbra wtrlp
maxi:
	movb #'1',wtrctrldisp+28
	movb #'0',wtrctrldisp+29
	movb #'0',wtrctrldisp+30	
	movb #'%',wtrctrldisp+31
	lbra wtrlp
	

decrease:
	clra
	clrb
	ldab wtrDC
	cmpb #30
	bne dec
    movb #'M',wtrctrldisp+29
    movb #'I',wtrctrldisp+30
    movb #'N',wtrctrldisp+31
    lbra wtrlp    
dec:
	subb #6
	stab wtrDC
	ldx #6
	idiv
	clra
	clrb
	xgdx
	addb #48
	movb #' ',wtrctrldisp+28
	stab wtrctrldisp+29
	movb #'0',wtrctrldisp+30
	movb #'%',wtrctrldisp+31
	lbra wtrlp
	

fertctrl:
    ldaa cropstats
    anda #%00000001
    beq notfert
    ldd #ferterr
    jsr drawscreen
    lbra endflow
notfert:
    ldd #fertdisp
    jsr drawscreen
fertlp:
	ldd #fertctrldisp
	std lastscreen
	movw #2500,drawDL
	jsr drawscreen
	ldaa port_t
    bita #%00000010
    lbeq endflow
	jsr Keyboard
	cmpa #10
	beq increase1
	cmpa #11
	beq decrease1
	ldaa port_t
	;brclr port_t,#%00000011,endflow
	bra fertlp

increase1:
	clra
	clrb
	ldab fertDC
	cmpb #30
	bne inc1
    movb #'M',fertctrldisp+29
    movb #'A',fertctrldisp+30
    movb #'X',fertctrldisp+31
    bra fertlp    
inc1:
	addb #6
	stab fertDC
	ldx #6
	idiv
	clra
	clrb
	xgdx
	addb #48
	stab fertctrldisp+29
	movb #'0',fertctrldisp+30
	movb #'%',fertctrldisp+31
	bra fertlp
	
	

decrease1:
	clra
	clrb
	ldab fertDC
	cmpb #6
	bne dec1
    movb #'M',wtrctrldisp+29
    movb #'I',wtrctrldisp+30
    movb #'N',wtrctrldisp+31
    lbra fertlp    
dec1:
	subb #6
	stab fertDC
	ldx #6
	idiv
	clra
	clrb
	xgdx
	addb #48
	stab fertctrldisp+29
	movb #'0',fertctrldisp+30
	movb #'%',fertctrldisp+31
	lbra fertlp
	

endflow:
	movb #00,exitflg
	ldaa menuNum
    beq mainMen
    cmpa #2
    blt fertMen
    ldd #sub2
    jsr drawscreen
    movb #$01,SWstatus
    rts
    
mainMen:
    ldd #mainmenu
    jsr drawscreen
    movb #$01,SWstatus
    rts
    
fertMen:
    ldd #sub1
    jsr drawscreen
    movb #$01,SWstatus
    rts