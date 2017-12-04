	XDEF flowctrl
	XREF port_t,Keyboard,SWstatus,flowctrlerr,fertDC,wtrDC,menuNum,sub1,sub2,mainmenu,display_string,wtrctrldisp,fertctrldisp,
	 
	
flowctrl:
	movb #$00,SWstatus
	ldaa port_t
	anda #%00000011
	cmpa #$01
	beq wtrctrl
	cmpa #$02
	beq fertctrl
	bra SWerr
	
	
wtrctrl:
	ldd #wtrctrldisp
	jsr display_string
	jsr Keyboard
	cmpa #10
	beq increase
	cmpa #11
	beq decrease
	brclr port_t,#%00000011,endflow
	bra wtrctrl
	
increase:
	ldaa wtrDC
	cmpa #60
	bne inc
    movb #'M',wtrctrldisp+29
    movb #'A',wtrctrldisp+30
    movb #'X',wtrctrldisp+31
    bra wtrctrl    
inc:
	adda #6
	staa wtrDC
	ldx #6
	idiv
	xgdx
	addb #48
	stab wtrctrldisp+29
	movb #'0',wtrctrldisp+30
	movb #'%',wtrctrldisp+31
	bra wtrctrl
	
	
	

decrease:
	ldaa wtrDC
	cmpa #30
	bne dec
    movb #'M',wtrctrldisp+29
    movb #'I',wtrctrldisp+30
    movb #'N',wtrctrldisp+31
    bra wtrctrl    
dec:
	suba #6
	staa wtrDC
	ldx #6
	idiv
	xgdx
	addb #48
	stab wtrctrldisp+29
	movb #'0',wtrctrldisp+30
	movb #'%',wtrctrldisp+31
	bra wtrctrl
	

fertctrl:
	ldd #fertctrldisp
	jsr display_string
	jsr Keyboard
	cmpa #10
	beq increase1
	cmpa #11
	beq decrease1
	brclr port_t,#%00000011,endflow
	bra fertctrl

increase1:
	ldaa fertDC
	cmpa #30
	bne inc1
    movb #'M',fertctrldisp+29
    movb #'A',fertctrldisp+30
    movb #'X',fertctrldisp+31
    bra fertctrl    
inc1:
	adda #6
	staa fertDC
	ldx #6
	idiv
	xgdx
	addb #48
	stab fertctrldisp+29
	movb #'0',fertctrldisp+30
	movb #'%',fertctrldisp+31
	bra fertctrl
	
	
	

decrease1:
	ldaa fertDC
	cmpa #6
	bne dec1
    movb #'M',wtrctrldisp+29
    movb #'I',wtrctrldisp+30
    movb #'N',wtrctrldisp+31
    bra fertctrl    
dec1:
	suba #6
	staa fertDC
	ldx #6
	idiv
	xgdx
	addb #48
	stab fertctrldisp+29
	movb #'0',fertctrldisp+30
	movb #'%',fertctrldisp+31
	bra fertctrl
	

SWerr:
	ldd #flowctrlerr
	jsr drawscreen
	bra endflow
	

endflow:
	ldaa menuNum
    beq mainMen
    cmpa #2
    blt fertMen
    ldd #sub2
    jsr drawscreen
    movb #$01,SWstatus
    rts
    
mainMenu:
    ldd #mainmenu
    jsr drawscreen
    movb #$01,SWstatus
    rts
    
fertMenu:
    ldd #sub1
    jsr drawscreen
    movb #$01,SWstatus
    rts