    XDEF fertilize
    XREF gamestate,display_string,Keyboard,err1,sub1,drawscreen
		
fertilize:
    ldab gamestate
    beq error
    ldd #sub1
    jsr display_string
    jsr Keyboard
    rts
    
error:
    ldd #err1
    jsr drawscreen
    rts