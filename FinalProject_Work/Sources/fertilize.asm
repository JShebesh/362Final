    XDEF fertilize
    XREF gamestate,tON,fertscreen,wtrscreen,display_string,Keyboard,err1,sub1,drawscreen
		
fertilize:
    ldab gamestate
    cmpb #$02
    bne error
    ldd #sub1
    jsr display_string
fl1:
    jsr Keyboard
    cmpa #10
    beq fert
    cmpa #11
    beq wtr
    rts



fert:
	ldd #fertscreen
	movb #$02,tON
	CLI
    jsr drawscreen
    rts

wtr:
   	ldd #wtrscreen
   	movb #$08,tON
   	CLI
   	jsr drawscreen
    rts
    
error:
    ldd #err1
    jsr drawscreen
    rts