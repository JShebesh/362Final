    XDEF newcrop
    XREF gamestate,display_string,Keyboard,err2,sub2,drawscreen,disp,__SEG_END_SSTACK
		
newcrop:
    ldab gamestate
    cmpb #1
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
     ldy #32
     ldd #disp
     jsr drawscreen
     ldx #disp
     ldaa #46
     staa 1,X+
     dey
     bne plant
     movb #1,gamestate
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
     bra klp
    
error1:
    ldd #err2
    jsr drawscreen
    rts