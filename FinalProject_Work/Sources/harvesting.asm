  XDEF harvesting
  XREF gamestate,wtrctrldisp,fertctrldisp,disp,seconds,timer,rtiCtrl,drawscreen,drawDL,harv

harvesting:
     ldd #harv
     jsr drawscreen
     ldy #32
     ldx #disp
     bset rtiCtrl,#%00010000
hv1:
     ldaa #32
     staa 1,X+
     ldd #disp
     movw #250,drawDL
     jsr drawscreen
     dey
     bne hv1
     bclr rtiCtrl,#%00010000
     movb #$00,gamestate
     movw #$00,timer
     movw #$00,seconds
     movb #$00,rtiCtrl
     movb #'1',fertctrldisp+29
     movb #'0',fertctrldisp+30
     movb #'%',fertctrldisp+31
     movb #' ',wtrctrldisp+28
     movb #'5',wtrctrldisp+29
     movb #'0',wtrctrldisp+30
     movb #'%',wtrctrldisp+31
     rts
     
    