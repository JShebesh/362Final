	XDEF flowctrl
	XREF port_t,drawDL,exitflg,drawscreen,Keyboard,SWstatus,fertDC,wtrDC,menuNum,sub1,sub2,mainmenu,display_string,wtrctrldisp,fertctrldisp,
	 
	
flowctrl:
	movb #$00,SWstatus
	movb #$01,exitflg
	ldaa port_t
	anda #%00000011
	cmpa #$01
	beq wtrctrl
	cmpa #$02
	lbeq fertctrl
	lbra endflow
	
	
wtrctrl:
	ldd #wtrctrldisp
	movw #250,drawDL
	jsr drawscreen
	ldaa port_t
    cmpa #%00000001
    lbne endflow
	jsr Keyboard
	cmpa #10
	beq increase
	cmpa #11
	beq decrease
	ldaa port_t
	;brclr port_t,#%00000011,endflow
	bra wtrctrl
	
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
    bra wtrctrl    
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
	bra wtrctrl
maxi:
	movb #'1',wtrctrldisp+28
	movb #'0',wtrctrldisp+29
	movb #'0',wtrctrldisp+30	
	movb #'%',wtrctrldisp+31
	lbra wtrctrl
	

decrease:
	clra
	clrb
	ldab wtrDC
	cmpb #30
	bne dec
    movb #'M',wtrctrldisp+29
    movb #'I',wtrctrldisp+30
    movb #'N',wtrctrldisp+31
    lbra wtrctrl    
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
	lbra wtrctrl
	

fertctrl:
	ldd #fertctrldisp
	movw #250,drawDL
	jsr drawscreen
	ldaa port_t
    cmpa #%00000010
    lbne endflow
	jsr Keyboard
	cmpa #10
	beq increase1
	cmpa #11
	beq decrease1
	ldaa port_t
	;brclr port_t,#%00000011,endflow
	bra fertctrl

increase1:
	clra
	clrb
	ldab fertDC
	cmpb #30
	bne inc1
    movb #'M',fertctrldisp+29
    movb #'A',fertctrldisp+30
    movb #'X',fertctrldisp+31
    bra fertctrl    
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
	bra fertctrl
	
	

decrease1:
	clra
	clrb
	ldab fertDC
	cmpb #6
	bne dec1
    movb #'M',wtrctrldisp+29
    movb #'I',wtrctrldisp+30
    movb #'N',wtrctrldisp+31
    bra fertctrl    
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
	lbra fertctrl
	

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