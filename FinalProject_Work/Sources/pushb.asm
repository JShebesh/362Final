    xdef    pushb
    xref    gamestate,disp,drawscreen,tth


pushb: 
    
    pshd
    ldd gamestate
    cpd #5
    beq fin 
    ldd disp ;gamestate1-4
    jsr drawscreen
    rts

    
fin:    ;gamestate5
    ldd tth
    jsr drawscreen

    
