	XDEF pestdetect
	XREF lastscreen,tON,loc,Alarm,rtiCtrl,display_string,read_pot,pestdisp,pstdtct,port_s,pests,drawDL,pesterr,drawscreen,pestctrl,port_t,port_p
	
pestdetect:
		ldd loc
		pshd	
		ldaa rtiCtrl
		psha
		ldx #Alarm
		stx loc
		movb #00,rtiCtrl
		bset rtiCtrl,#%01100000
		ldd drawDL
		pshd
		movb #00,pstdtct
		ldd lastscreen
		pshd
		inc pests
		ldaa #$FF
		staa port_s
		ldd #pesterr
		movw #30000,drawDL
		jsr drawscreen
		movb #00,tON
		bset rtiCtrl,#%00000001        
read:
		ldx loc
		ldaa 0,X
		cmpa #0
		beq AlarmRst
        jsr read_pot
        clra
        ldx #25
        idiv
        xgdx
        cpd #10
        pshb
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
        pulb
        ldaa #6
        mul
        stab tON
        brclr port_p,#%00100000,endpest
        bra read
max:
        movb #'M',pestdisp+16
        movb #'A',pestdisp+17
        movb #'X',pestdisp+18
        ldd #pestdisp
        jsr display_string
        bra read
AlarmRst:
		ldx #Alarm
		stx loc
		bset rtiCtrl,#%01000000
		bra read      
endpest:
	brclr port_p,#%00100000,endpest
	bclr port_s,#$FF
	puld
	jsr display_string
	puld
	std drawDL
	pula
	staa rtiCtrl
	puld
	std loc
	bclr port_t,#%00001000
	rts	