    XDEF growth
    XREF seconds,disp,gamestate
    
growth:
           cpd #20
           beq growing
           cpd #40
           lbeq matured
           cpd #60
           lbeq harvest
           RTS
           


growing:
           movb #'*',disp
           movb #'*',disp+1
           movb #'*',disp+2
           movb #'*',disp+3
           movb #'*',disp+4
           movb #'*',disp+5
           movb #'*',disp+6
           movb #' ',disp+7
           movb #' ',disp+8
           movb #'*',disp+9
           movb #'*',disp+10
           movb #'*',disp+11
           movb #'*',disp+12
           movb #'*',disp+13
           movb #'*',disp+14
           movb #'*',disp+15
           movb #'*',disp+16
           movb #'*',disp+17
           movb #'*',disp+18
           movb #'*',disp+19
           movb #'*',disp+20
           movb #'*',disp+21
           movb #'*',disp+22
           movb #' ',disp+23
           movb #' ',disp+24
           movb #'*',disp+25
           movb #'*',disp+26
           movb #'*',disp+27
           movb #'*',disp+28
           movb #'*',disp+29
           movb #'*',disp+30
           movb #'*',disp+31
           movb #0,disp+32
           movb #3,gamestate
           rts
matured:
           movb #'@',disp
           movb #'@',disp+1
           movb #'@',disp+2
           movb #'@',disp+3
           movb #'@',disp+4
           movb #'@',disp+5
           movb #'@',disp+6
           movb #' ',disp+7
           movb #' ',disp+8
           movb #'@',disp+9
           movb #'@',disp+10
           movb #'@',disp+11
           movb #'@',disp+12
           movb #'@',disp+13
           movb #'@',disp+14
           movb #'@',disp+15
           movb #'@',disp+16
           movb #'@',disp+17
           movb #'@',disp+18
           movb #'@',disp+19
           movb #'@',disp+20
           movb #'@',disp+21
           movb #'@',disp+22
           movb #' ',disp+23
           movb #' ',disp+24
           movb #'@',disp+25
           movb #'@',disp+26
           movb #'@',disp+27
           movb #'@',disp+28
           movb #'@',disp+29
           movb #'@',disp+30
           movb #'@',disp+31
           movb #0,disp+32
           movb #4,gamestate
           rts
harvest:  
           movb #5,gamestate
           rts