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
            XDEF Entry, _Startup
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK      ; symbol defined by the linker for the end of the stack
            
            ; LCD References
	         

            ; Potentiometer References
          



; variable/data section
my_variable: SECTION
disp:	ds.b 33



; code section
MyCode:     SECTION
Entry:
_Startup:

;*********************string initializations*********************
           ;intializing string "disp" to be:
           ;"The value of the pot is:      ",0
           movb #'T',disp
           movb #'h',disp+1
           movb #'e',disp+2
           movb #' ',disp+3
           movb #'v',disp+4
           movb #'a',disp+5
           movb #'l',disp+6
           movb #'u',disp+7
           movb #'e',disp+8
           movb #' ',disp+9
           movb #'o',disp+10
           movb #'f',disp+11
           movb #' ',disp+12
           movb #'t',disp+13
           movb #'h',disp+14
           movb #'e',disp+15
           movb #' ',disp+16
           movb #'p',disp+17
           movb #'o',disp+18
           movb #'t',disp+19
           movb #' ',disp+20
           movb #'i',disp+21
           movb #'s',disp+22
           movb #':',disp+23
           movb #' ',disp+24
           movb #' ',disp+25
           movb #' ',disp+26
           movb #' ',disp+27
           movb #' ',disp+28
           movb #' ',disp+29
           movb #' ',disp+30
           movb #' ',disp+31
           movb #0,disp+32    ;string terminator, acts like '\0'    
;*********************string initialization*********************





;**************************************************************
;
;                   Write You Code Here
;
;**************************************************************

