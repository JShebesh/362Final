    XDEF drawscreen
    XREF display_string
 
drawscreen:
    pshy
    pshx
    jsr display_string
    ldx #100
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