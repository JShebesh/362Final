    XDEF drawscreen
    XREF display_string,drawDL
 
drawscreen:
    pshy
    pshx
    jsr display_string
    ldx drawDL
lp2:
    ldy #10000
lp1:
    dey
    bne lp1
    dex
    bne lp2
    pulx
    puly
    rts