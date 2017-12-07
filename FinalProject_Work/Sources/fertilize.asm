    XDEF fertilize
    XREF gamestate,port_s,cropstats,fertDC,menuNum,wtrDC,drawDL,rtiCtrl,port_t,tON,fertscreen,wtrscreen,display_string,Keyboard,err1,sub1,drawscreen
		
fertilize:
    movb #01,menuNum
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
	  ldaa fertDC
	  staa tON
	  ;movb #08,tON
	  bset rtiCtrl,#%10000001
	  movw #2000,drawDL
	  ldd #fertscreen
    jsr drawscreen
    bclr port_t,#%00001000
    bclr rtiCtrl,#%10000001
    bset cropstats,#%00000001
    movb #$00,port_s
    rts

wtr:
    ldaa wtrDC
    staa tON
   	;movb #32,tON
   	bset rtiCtrl,#%00000001
   	movw #2000,drawDL
    ldd #wtrscreen
   	jsr drawscreen
    bclr rtiCtrl,#%10000001
   	bclr port_t,#%00001000
   	bset cropstats,#%00000010
   	movb #$00,port_s
    rts
    
error:
    ldd #err1
    jsr drawscreen
    rts