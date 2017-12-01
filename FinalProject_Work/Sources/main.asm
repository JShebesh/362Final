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
            XDEF Entry,timer,drawDL,rtiCtrl,port_t,RTI_ISR,CRGFLG,tON,fertscreen, wtrscreen, _Startup, err3, gamestate,Keyboard,err1,err2,sub2,sub1,disp,port_t
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK,display_string,pot_value,read_pot,init_LCD,SendsChr,PlayTone,fertilize,newcrop,drawscreen      ; symbol defined by the linker for the end of the stack
            
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
my_constants: SECTION
welcome dc.b    "    Welcome         Farmtek     ",0
mainmenu  dc.b  "(A)Fertilize    (B)New Crop     ",0
sub2 dc.b       "(A)Plow         (B)Plant        ",0
sub1 dc.b       "(A)Fertilize    (B)Water        ",0
err1 dc.b       "Plant Crop      to Continue     ",0
err2 dc.b       "Crop Already    Planted         ",0
err3 dc.b 		"Field not       Plowed          ",0
fertscreen dc.b "Fertilizing                     ",0
wtrscreen dc.b  "Watering                        ",0
ledpat dc.b $24,$81,$18,$FF,$00
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
 

; code section
MyCode:     SECTION
Entry:
_Startup:
           movw #100,drawDL
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
    movb #$00,Counter
    movb #$80,CRGINT
    movb #$40,RTICTL
    movb #$00,gamestate
    bset t_DDR,#%00101000
    movb #$F0,$26A
    movb #$F0,$26D
    movb #$0F,$26C
    movb #$FF,s_DDR
    bclr port_s,#%11111111
 	LDS #__SEG_END_SSTACK
 	jsr init_LCD
    ldd #welcome
	jsr display_string
	ldy #5
    ldx #ledpat
nextpat:
    ldab 1,X+
    stab port_s
    ldaa #100
setup:
    jsr delay    
    deca
    bne setup
    dey
    bne nextpat 
    ;jingle goes here
        
    ;Display Main Menu
    ldd #mainmenu
    jsr display_string




start:
     jsr Keyboard
     cmpa #10
     bne b1
     jsr fertilize
    b1:
     cmpa #11
     bne nxt
     jsr newcrop
nxt:
     staa port_s
     ldd #mainmenu
     jsr display_string
     bra start	

Keyboard:
rst:    ldx #Kseq
scan:    
    ldaa 1,X+
    cmpa #$FF
    beq rst
    staa port_u
    jsr delay
    ldaa port_u
    ldab port_u
    anda #%00001111
    cmpa #$0F
    beq scan
    jsr Search
end:rts        

Search:
		ldx #table;loads address of first value of table
		ldaa #0
top:
		cmpb 1,X+  ;checks to see if val is equal to first value in table
		beq match ;if there is a match move to load the index into a
		inca ;checks to see if the table has been cycled through
		bne top ;if it is not equal then return to the start
check:     
        jsr delay
        ldaa port_u
        anda #$0F
        cmpa #$0F
        bne check
match:	rts

delay:
      pshy
      ldy #10000
loop: dey
      bne loop
      puly
      rts





RTI_ISR:
        ldaa rtiCtrl
        cmpa #1
        beq DCmtr
timing:
        ldd timer
        clc
        incb
        bne nocarry1
        inca
nocarry1:
        std timer        
        cpd #$03E8
        bne  endrti
        movw #$0000,timer
        ldd seconds
        clc
        incb
        bne nocarry2
        inca
nocarry2: 
        std seconds
endrti:
        movb #$80,CRGFLG
        RTI




DCmtr:
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
        bra timing
        s1:
           bset port_t,#%00001000
           bra timing
        s2:
           bclr port_t,#%00001000
           bra timing

