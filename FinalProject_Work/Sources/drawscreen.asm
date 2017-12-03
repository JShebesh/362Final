    XDEF drawscreen
    XREF display_string,drawDL,rtiCtrl
 
drawscreen:
    pshy
    pshx
    jsr display_string
    bset rtiCtrl,#%00000010
RTILP:
    ldx drawDL
    bne RTILP
    bclr rtiCtrl,#%00000010
    movw #1000,drawDL
    pulx
    puly
    rts