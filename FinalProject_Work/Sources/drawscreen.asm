    XDEF drawscreen
    XREF display_string,drawDL,rtiCtrl,lastscreen,pstdtct,pestdetect
 
drawscreen:
    pshy
    pshx
    std lastscreen
    jsr display_string
    bset rtiCtrl,#%00000010
RTILP:
	brset pstdtct,#%00000001,PST
    ldx drawDL
    bne RTILP
    bclr rtiCtrl,#%00000010
    movw #10000,drawDL
    pulx
    puly
    rts

PST:
	jsr pestdetect
	bra RTILP