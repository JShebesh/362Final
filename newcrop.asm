    XDEF newcrop
    XREF gamestate,cropstats,menuNum,rtiCtrl,STPcnt,PlantLED,PlowLED,drawDL,port_s,display_string,Keyboard,err2,err3,sub2,drawscreen,disp,__SEG_END_SSTACK
		
newcrop:
    movb #02,menuNum
    ldab gamestate
    cmpb #2
    lbge error1  
klp:
    ldd #sub2
    jsr display_string
    jsr Keyboard
    cmpa #10
    lbeq plow
    cmpa #11
    beq plant
    bne klp
    
    
plant:
	 ldaa gamestate
	 cmpa #$01
	 lbne error2
	 movw #250,drawDL
	 movb #$02,gamestate
   ldaa #32
   ldy #PlantLED
   ldx #disp
   movb #00,STPcnt
   bset rtiCtrl,#%00001000
   bset cropstats,#%00000100
   psha
     
pl2:
     ldab 1,Y+
     stab port_s    
     ldaa #46
     staa 1,X+
     ldd #disp
     jsr drawscreen
     movw #250,drawDL
     pula
     deca
     psha
     beq endplant1
     cmpa #9
     beq space
     cmpa #25
     beq space
     bra pl2
endplant1:
     pula
     bclr rtiCtrl,#%00001000
     bclr port_s,$FF
     rts  
space:
     ldab 1,Y+
     stab port_s
     ldaa #32
     staa 1,X+
     ldd #disp
     movw #250,drawDL
     jsr drawscreen
     pula
     deca
     psha
     ldab 1,Y+
     stab port_s
     ldaa #32
     staa 1,X+
     ldd #disp
     movw #250,drawDL
     jsr drawscreen
     pula
     deca
     psha
     movw #250,drawDL
     bra pl2    
    
plow:
     movw #250,drawDL
     ldaa #32
     ldx #disp
     ldy #PlowLED
     bset rtiCtrl,#%00000100
     psha
pl1: 
     ldab 1,Y+
     stab port_s    
     ldaa #35
     staa 1,X+
     ldd #disp
     jsr drawscreen
     movw #250,drawDL
     pula
     deca
     psha
     beq endplow2
     cmpa #9
     beq space2
     cmpa #25
     beq space2
     bra pl1
     
endplow2:
     pula     
     bclr rtiCtrl,#%00000100
     bclr port_s,$FF
     movb #$01,gamestate
     lbra klp
space2:
     ldab 1,Y+
     stab port_s
     ldaa #32
     staa 1,X+
     ldd #disp
     movw #250,drawDL
     jsr drawscreen
     pula
     deca
     psha
     ldab 1,Y+
     stab port_s
     ldaa #32
     staa 1,X+
     ldd #disp
     movw #250,drawDL
     jsr drawscreen
     pula
     deca
     psha
     movw #250,drawDL
     bra pl1    
error1:
    ldd #err2
    jsr drawscreen
    rts
error2:
	ldd #err3
	jsr drawscreen
	jmp klp
	