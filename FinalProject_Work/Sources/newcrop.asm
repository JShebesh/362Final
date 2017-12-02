    XDEF newcrop
    XREF gamestate,drawDL,display_string,Keyboard,err2,err3,sub2,drawscreen,disp,__SEG_END_SSTACK
		
newcrop:
    ldab gamestate
    cmpb #2
    lbeq error1
    movw #25,drawDL  
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
	 lbne error2
     ldy #32
     ldx #disp
     
 
pl2:
     ldaa #46
     staa 1,X+
     ldd #disp
     jsr drawscreen
     dey
     beq endplant
     cpy #9
     beq space
     cpy #25
     beq space
     bra pl2
endplant: 
     movb #$02,gamestate
     cli
     movw #100,drawDL
     rts
     
space:
     ldaa #32
     staa 1,x+
     ldd #disp
     jsr drawscreen
     dey
     ldaa #32
     staa 1,x+
     ldd #disp
     jsr drawscreen
     dey
     bra pl2
    
    
    
plow:
     ldy #32
     ldx #disp
     
pl1:
     ldaa #35
     staa 1,X+
     ldd #disp
     jsr drawscreen
     dey
     beq endplow
     cpy #9
     beq space2
     cpy #25
     beq space2
     bra pl1
endplow:
     movb #$01,gamestate
     jmp klp
space2:
     ldaa #32
     staa 1,x+
     ldd #disp
     jsr drawscreen
     dey
     ldaa #32
     staa 1,x+
     ldd #disp
     jsr drawscreen
     dey
     bra pl1
    
error1:
    ldd #err2
    jsr drawscreen
    rts
error2:
	ldd #err3
	jsr drawscreen
	jmp klp
	