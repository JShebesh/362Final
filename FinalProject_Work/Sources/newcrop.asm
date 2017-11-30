    XDEF newcrop
    XREF gamestate,display_string,Keyboard,err2,err3,sub2,drawscreen,disp,__SEG_END_SSTACK
		
newcrop:
    ldab gamestate
    cmpb #2
    beq error1  
klp:
    ldd #sub2
    jsr display_string
    jsr Keyboard
    cmpa #10
    beq plow
    cmpa #11
    beq plant
    bne klp
    
    
plant:
	 ldaa gamestate
	 cmpa #$01
	 bne error2
     ldy #32
     ldx #disp
     
pl2:
     ldaa #46
     staa 1,X+
     ldd #disp
     jsr drawscreen
     dey
     bne pl2
     movb #$02,gamestate
     rts
    
    
    
plow:
     ldy #32
     ldx #disp
     
pl1:
     ldaa #35
     staa 1,X+
     ldd #disp
     jsr drawscreen
     dey
     bne pl1
     movb #$01,gamestate
     bra klp
    
error1:
    ldd #err2
    jsr drawscreen
    rts
error2:
	ldd #err3
	jsr drawscreen
	bra klp
	