    XDEF fertilize
    XREF gamestate,drawDL,rtiCtrl,port_t,tON,fertscreen,wtrscreen,display_string,Keyboard,err1,sub1,drawscreen
		
fertilize:
    ldab gamestate
    cmpb #$02
    blt error
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
	  movb #08,tON
	  movb #01,rtiCtrl
	  movw #200,drawDL
    jsr drawscreen
    bclr port_t,#%00001000
    movb #00,rtiCtrl
    movw #100,drawDL
    rts

wtr:
   	ldd #wtrscreen
   	movb #32,tON
   	movb #01,rtiCtrl
   	movw #200,drawDL
   	jsr drawscreen
   	movw #00,rtiCtrl
   	bclr port_t,#%00001000
   	movb #100,drawDL
    rts
    
error:
    ldd #err1
    jsr drawscreen
    rts