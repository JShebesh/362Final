;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry,temp,scoredisp,fertwtr,pests,harvests,IRQ_ISR,lastscreen,pesterr,pestdisp,ferterr,wtrerr,wtrdisp,fertdisp,menuNum,cropstats,exitflg,wtrctrldisp,fertctrldisp,SWstatus,start,port_p,sub1,sub2,mainmenu,harv,harvesting,tth,tth2,timer,seconds,STPcnt,PlantLED,wtrDC,fertDC,drawDL,rtiCtrl,port_t,RTI_ISR,CRGFLG,tON,fertscreen, wtrscreen, _Startup,port_s, err3,PlowLED, gamestate,Keyboard,err1,err2,sub2,sub1,disp,port_t
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK,statsmen,growth,flowctrl,harvesting,pushb,display_string,pot_value,read_pot,init_LCD,SendsChr,PlayTone,fertilize,newcrop,drawscreen      ; symbol defined by the linker for the end of the stack
            
            ; LCD References
	         

            ; Potentiometer References
          



; variable/data section
my_variable: SECTION
disp:	ds.b 33
menuNum: ds.b 1
gamestate: ds.b 1
timer ds.w 1
seconds ds.w 1
Counter ds.b 1
tON ds.b 1
rtiCtrl ds.b 1
drawDL ds.w 1
fertDC ds.b 1
wtrDC ds.b 1
STPcnt ds.b 1
SWstatus ds.b 1
wtrctrldisp ds.b 33
fertctrldisp ds.b 33
pestdisp ds.b 33
exitflg ds.b 1
cropstats ds.b 1
temp ds.b 1
keyflg ds.b 1
gametime ds.w 1
lastscreen ds.w 1
scoredisp ds.b 33
harvests ds.b 1
pests ds.b 1
fertwtr ds.b 1
pestctrl ds.b 1
my_constants: SECTION 
harv dc.b       "   Harvesting                   ",0
welcome dc.b    "    Welcome         Farmtek     ",0
mainmenu  dc.b  "(A)F/W(B)NewCrop(F)Stats        ",0
sub2 dc.b       "(A)Plow         (B)Plant        ",0
sub1 dc.b       "(A)Fertilize    (B)Water        ",0
err1 dc.b       "Plant Crop      to Continue     ",0
err2 dc.b       "Crop Already    Planted         ",0
err3 dc.b 		"Field not       Plowed          ",0
fertscreen dc.b "Fertilizing                     ",0
wtrscreen dc.b  "Watering                        ",0
tth       dc.b  "Time to         Harvest         ",0
tth2      dc.b  "Press Button    To Harvest      ",0
ferterr dc.b    "Crop Fertile                    ",0
wtrerr dc.b     "Crop Watered                    ",0
fertdisp dc.b   "Crop Infertile                  ",0
wtrdisp dc.b    "Crop Not Watered                ",0
pesterr dc.b    "Pest Detected!  Spraying Field  ",0
ledpat dc.b $24,$81,$18,$FF,$00
PlantLED dc.b $80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01,$80,$40,$20,$10,$08,$04,$02,$01
PlowLED dc.b $7F,$BF,$DF,$EF,$F7,$FB,$FD,$FE,$7F,$BF,$DF,$EF,$F7,$FB,$FD,$FE,$7F,$BF,$DF,$EF,$F7,$FB,$FD,$FE,$7F,$BF,$DF,$EF,$F7,$FB,$FD,$FE
fertLED dc.b $A5,$00
wtrLED dc.b  $AA,$55
port_s equ $248
s_DDR equ  $24A
port_u equ $268
u_DDR equ $24A
PSR_u equ $24D
PUDE equ $24C
port_t equ $240
t_DDR equ $242
Kseq dc.b $70,$B0,$D0,$E0,$FF
table dc.b $eb,$77,$7b,$7d,$b7,$bb,$bd,$d7,$db,$dd,$e7,$ed,$7e,$be,$de,$ee
port_p equ $258
p_DDR equ $25A
seq dc.b %00001010,%00010010,%00010100,%00001100
 

; code section
MyCode:     SECTION
Entry:
_Startup:  
		   movb #$00,pestctrl
		   movb #'H',scoredisp
           movb #'a',scoredisp+1
           movb #'r',scoredisp+2
           movb #'v',scoredisp+3
           movb #'e',scoredisp+4
           movb #'s',scoredisp+5
           movb #'t',scoredisp+6
           movb #'s',scoredisp+7
           movb #':',scoredisp+8
           movb #' ',scoredisp+9
           movb #' ',scoredisp+10
           movb #' ',scoredisp+11
           movb #' ',scoredisp+12
           movb #' ',scoredisp+13
           movb #' ',scoredisp+14
           movb #' ',scoredisp+15
           movb #'P',scoredisp+16
           movb #'e',scoredisp+17
           movb #'s',scoredisp+18
           movb #'t',scoredisp+19
           movb #'s',scoredisp+20
           movb #':',scoredisp+21
           movb #' ',scoredisp+22
           movb #' ',scoredisp+23
           movb #' ',scoredisp+24
           movb #'W',scoredisp+25
           movb #'/',scoredisp+26
           movb #'F',scoredisp+27
           movb #':',scoredisp+28
           movb #' ',scoredisp+29
           movb #' ',scoredisp+30
           movb #' ',scoredisp+31
           movb #0,pestdisp+32 
           movb #00,keyflg
           movb #' ',pestdisp
           movb #'S',pestdisp+1
           movb #'p',pestdisp+2
           movb #'r',pestdisp+3
           movb #'a',pestdisp+4
           movb #'y',pestdisp+5
           movb #'i',pestdisp+6
           movb #'n',pestdisp+7
           movb #'g',pestdisp+8
           movb #' ',pestdisp+9
           movb #'P',pestdisp+10
           movb #'e',pestdisp+11
           movb #'s',pestdisp+12
           movb #'t',pestdisp+13
           movb #' ',pestdisp+14
           movb #' ',pestdisp+15
           movb #' ',pestdisp+16
           movb #' ',pestdisp+17
           movb #' ',pestdisp+18
           movb #' ',pestdisp+19
           movb #' ',pestdisp+20
           movb #'P',pestdisp+21
           movb #'B',pestdisp+22
           movb #' ',pestdisp+23
           movb #'t',pestdisp+24
           movb #'o',pestdisp+25
           movb #' ',pestdisp+26
           movb #'e',pestdisp+27
           movb #'x',pestdisp+28
           movb #'i',pestdisp+29
           movb #'t',pestdisp+30
           movb #'!',pestdisp+31
           movb #0,pestdisp+32
		   movb #'(',fertctrldisp
           movb #'A',fertctrldisp+1
           movb #')',fertctrldisp+2
           movb #'I',fertctrldisp+3
           movb #'n',fertctrldisp+4
           movb #'c',fertctrldisp+5
           movb #'F',fertctrldisp+6
           movb #'e',fertctrldisp+7
           movb #'r',fertctrldisp+8
           movb #'t',fertctrldisp+9
           movb #'i',fertctrldisp+10
           movb #'l',fertctrldisp+11
           movb #'i',fertctrldisp+12
           movb #'z',fertctrldisp+13
           movb #'e',fertctrldisp+14
           movb #'r',fertctrldisp+15
           movb #'(',fertctrldisp+16
           movb #'B',fertctrldisp+17
           movb #')',fertctrldisp+18
           movb #'D',fertctrldisp+19
           movb #'e',fertctrldisp+20
           movb #'c',fertctrldisp+21
           movb #' ',fertctrldisp+22
           movb #' ',fertctrldisp+23
           movb #' ',fertctrldisp+24
           movb #' ',fertctrldisp+25
           movb #' ',fertctrldisp+26
           movb #' ',fertctrldisp+27
           movb #' ',fertctrldisp+28
           movb #'1',fertctrldisp+29
           movb #'0',fertctrldisp+30
           movb #'%',fertctrldisp+31
           movb #0,fertctrldisp+32    ;string terminator, acts like '\0'
		   movb #'(',wtrctrldisp
           movb #'A',wtrctrldisp+1
           movb #')',wtrctrldisp+2
           movb #'I',wtrctrldisp+3
           movb #'n',wtrctrldisp+4
           movb #'c',wtrctrldisp+5
           movb #' ',wtrctrldisp+6
           movb #' ',wtrctrldisp+7
           movb #' ',wtrctrldisp+8
           movb #' ',wtrctrldisp+9
           movb #'W',wtrctrldisp+10
           movb #'a',wtrctrldisp+11
           movb #'t',wtrctrldisp+12
           movb #'e',wtrctrldisp+13
           movb #'r',wtrctrldisp+14
           movb #' ',wtrctrldisp+15
           movb #'(',wtrctrldisp+16
           movb #'B',wtrctrldisp+17
           movb #')',wtrctrldisp+18
           movb #'D',wtrctrldisp+19
           movb #'e',wtrctrldisp+20
           movb #'c',wtrctrldisp+21
           movb #' ',wtrctrldisp+22
           movb #' ',wtrctrldisp+23
           movb #' ',wtrctrldisp+24
           movb #' ',wtrctrldisp+25
           movb #' ',wtrctrldisp+26
           movb #' ',wtrctrldisp+27
           movb #' ',wtrctrldisp+28
           movb #'5',wtrctrldisp+29
           movb #'0',wtrctrldisp+30
           movb #'%',wtrctrldisp+31
           movb #0,wtrctrldisp+32    ;string terminator, acts like '\0'
           movb #00,cropstats
           movb #$00,STPcnt
           MOVB #%00011110,p_DDR
           movb #6,fertDC
           movb #30,wtrDC
           movw #1000,drawDL
           movb #%00000000,rtiCtrl
           movb #' ',disp
           movb #' ',disp+1
           movb #' ',disp+2
           movb #' ',disp+3
           movb #' ',disp+4
           movb #' ',disp+5
           movb #' ',disp+6
           movb #' ',disp+7
           movb #' ',disp+8
           movb #' ',disp+9
           movb #' ',disp+10
           movb #' ',disp+11
           movb #' ',disp+12
           movb #' ',disp+13
           movb #' ',disp+14
           movb #' ',disp+15
           movb #' ',disp+16
           movb #' ',disp+17
           movb #' ',disp+18
           movb #' ',disp+19
           movb #' ',disp+20
           movb #' ',disp+21
           movb #' ',disp+22
           movb #' ',disp+23
           movb #' ',disp+24
           movb #' ',disp+25
           movb #' ',disp+26
           movb #' ',disp+27
           movb #' ',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,disp+32    ;string terminator, acts like '\0'
           movb #$00,Counter
           movw #0000,timer
           movw #0000,seconds
           movb #5,tON
           movb #1,SWstatus
           movb #0,pests
           movb #0,harvests
           movb #0,fertwtr
    movb #$00,Counter
    movb #$80,CRGINT
    movb #$40,RTICTL
    movb #$00,gamestate
    bset t_DDR,#%00101000
    movb #$F0,$26A
    movb #$F0,$26D
    movb #$0F,$26C
    movb #$FF,s_DDR
    movb #00,exitflg
    bclr port_s,#%11111111
 	LDS #__SEG_END_SSTACK
 	jsr init_LCD
    ldd #welcome
    std lastscreen
	jsr display_string
	cli
	ldaa #5
    ldx #ledpat
nextpat:
    ldab 1,X+
    stab port_s
setup:
    ldy gametime
    cpy #1000
    blt setup
    movw #00,gametime
    deca
    bne nextpat 
    ;jingle goes here
        
    ;Display Main Menu
    movb #$40,INTCR
    ldd #mainmenu
    jsr drawscreen




start:
     movb #00,menuNum
     jsr Keyboard
     cmpa #10
     bne b1
     jsr fertilize
    b1:
     cmpa #11
     bne b2
     jsr newcrop
    b2:
     cmpa #15
     bne nxt
     jsr statsmen
nxt:
     ldd #mainmenu
     jsr drawscreen
     bra start	

Keyboard:
rst:    ldx #Kseq
		brset port_t,#%00000001,SW
		brset port_t,#%00000010,SW
scan:
    brclr port_p,#%00100000,PB
    ldaa exitflg
    bne swcheck    
scanSW:
    ldaa 1,X+
    cmpa #$FF
    beq rst
    staa port_u
hold1:
    brset keyflg,#$FF,hold1
hold2:
    brclr keyflg,#$FF,hold2
    ;jsr delay
    ldaa port_u
    ldab port_u
    anda #%00001111
    cmpa #$0F
    beq scan
    jsr Search
end:rts        
PB:
    jsr pushb
    bra scan
SW:
	ldaa SWstatus
	beq scan
	jsr flowctrl
	bra scan

swcheck:
	ldaa port_t
	anda #%00000011
	beq exitSW
	bra scanSW
exitSW:
	rts			 
Search:
		ldx #table;loads address of first value of table
		ldaa #0
top:
		cmpb 1,X+  ;checks to see if val is equal to first value in table
		beq match ;if there is a match move to load the index into a
		inca ;checks to see if the table has been cycled through
		bne top ;if it is not equal then return to the start     
match:
        psha	
hold11:
        brset keyflg,#$FF,hold11
hold21:
        brclr keyflg,#$FF,hold21
        ldaa port_u
        anda #$0F
        cmpa #$0F
        bne hold11
        pula
        rts

delay:
      pshy
      ldy #30000
loop: dey
      bne loop
      puly
      rts





RTI_ISR:
        ldaa gamestate
        bne setupdone
        ldd gametime
        addd #1
        std gametime
setupdone:        
        ldaa keyflg
        eora #$FF
        staa keyflg
        ldaa rtiCtrl
        bita #%00100000
        bne pestLED
STPtst:
        ldaa rtiCtrl
        bita #%00011100
        beq DCtst
        jsr STPmtr
DCtst:
        ldaa rtiCtrl
        bita #%00000001
        beq timing
        jsr DCmtr
timing:
        ldaa rtiCtrl
        bita #%00000010
        bne drawscreenDL
postDelay:
        ldaa gamestate
        cmpa #2
        blt endrti
        ldd timer
        clc
        incb
        bne nocarry1
        inca
nocarry1:
        std timer        
        cpd #$03E9
        bne  endrti
        movw #$0000,timer
        ldd seconds
        clc
        incb
        bne nocarry2
        inca
nocarry2: 
        std seconds
        jsr growth
endrti:
        movb #$80,CRGFLG
        RTI
	
drawscreenDL:
        ldx drawDL
        dex
        stx drawDL
        bra postDelay
pestLED:
        ldd timer
        cpd #500
        beq active
        bra STPtst
active:
        ldaa port_s
        eora #$FF
        staa port_s
        bra STPtst
DCmtr:
        jsr dcLED
        ldaa Counter
        inca
        staa Counter
        cmpa tON
        ble  s1
        cmpa #60
        ble s2
        ldaa #$00
        staa Counter
        movb #$80,CRGFLG
        rts
        s1:
           bset port_t,#%00001000
           rts
        s2:
           bclr port_t,#%00001000
           rts
STPmtr:
       ldaa rtiCtrl
       bita #%00001000
       bne seeder
       bita #%00010000
       bne harvester
       bra chisel
       
       
       
       
harvester:
       ldab Counter
       incb
       stab Counter
       cmpb #30
       bne endSTP
       movb #00,Counter
       ldab STPcnt
       ldx #seq
       abx
       ldaa 0,X
       staa port_p
       decb
       bmi rstcnt1
       stab STPcnt
       rts
rstcnt1:
       movb #03,STPcnt
       rts
       
seeder:
       ldab Counter
       incb
       stab Counter
       cmpb #30
       bne endSTP
       movb #00,Counter
       ldab STPcnt
       ldx #seq
       abx
       ldaa 0,X
       staa port_p
       incb
       cmpb #04
       beq rstcnt2
       stab STPcnt
       rts
rstcnt2:
       movb #00,STPcnt
       rts

chisel:
       ldab Counter
       incb
       stab Counter
       cmpb #10
       bne endSTP
       movb #00,Counter
       ldab STPcnt
       ldx #seq
       abx
       ldaa 0,X
       staa port_p
       decb
       bmi rstcnt3
       stab STPcnt
       rts
rstcnt3:
       movb #03,STPcnt
       rts

endSTP:
       rts


dcLED:
      ldd timer
      ldx #100
      idiv
      cpd #00
      beq Pattern
      rts
Pattern:
      ldaa rtiCtrl
      bita #%10000000
      bne fert0
      
;water LEDS 
      xgdx
      ldx #2
      idiv
      cpd #00
      bne wtr1
      ldx #wtrLED
      ldaa 0,X
      staa port_s
      rts
wtr1:
      ldx #wtrLED
      ldaa 1,X
      staa port_s
      rts


fert0:
      xgdx
      ldx #2
      idiv
      cpd #00
      bne fert1
      ldx #fertLED
      ldaa 0,X
      staa port_s
      rts
fert1:
      ldx #fertLED
      ldaa 1,X
      staa port_s
      rts      



IRQ_ISR:
		inc pests
		ldaa #$FF
		staa port_s       
read:
		ldaa pestctrl
		eora #%00001000
		staa port_t
        jsr read_pot
        tfr a,b
        clra
        ldx #25
        idiv
        xgdx
        cpd #10
        beq max
        addb #48
        stab pestdisp+16
        movb #'0',pestdisp+17
        movb #'%',pestdisp+18
        ldd #pestdisp
        jsr display_string
        ldaa port_s
        eora #$FF
        staa port_s
        brclr port_p,#%00100000,endpest
        bra read
max:
        movb #'M',pestdisp+16
        movb #'A',pestdisp+17
        movb #'X',pestdisp+18
        ldd #pestdisp
        jsr display_string
        bra read
        
endpest:
	brclr port_p,#%00100000,endpest
	bclr port_t,#%00001000
	bclr port_s,#$FF
	ldd lastscreen
	jsr display_string
	rti
   ; ldaa menuNum
   ; beq mainMen1
   ; cmpa #2
   ; blt fertMen2
   ; ldd #sub2
   ; jsr display_string
    ;rti
    
;mainMen1:
    ;ldd #mainmenu
    ;jsr display_string
    ;rti
    
;fertMen2:
    ;ldd #sub1
   ; jsr display_string
    ;rti
     
