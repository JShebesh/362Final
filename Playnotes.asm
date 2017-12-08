;	xdef	Playnotes
;	xref	loc,SendsChr,PlayTone,rtiCtrl														   
;Playnotes:		;have flag go to play
;	ldx		loc
;	ldaa	0,x	;b has value of sound
;	cmpa	#255	;any rest value
;	beq		Rest
;	cmpa	#00	;end of array
;	beq		Reset
;	psha
;	jsr		SendsChr	;send character
;	pula
;	jsr		Note
;	jsr		PlayTone	;send tone to speaker
;	inx		;increment the array counter
;	stx		loc	;store next location
;Leave:	
;	rts
	
;Reset:	
;	ldaa	%01000000
;;	eora	rtiCtrl
;	rts
;Note:
;	pshy
;	ldy	#7500	;7.5 ms delay
;	dbne y,Reset	;delay until rest is over
;	puly
;	rts
;Rest:
;	ldy	#7500	;7.5 ms delay
;	dbne	y,Reset	;delay until rest is over
;	puly
;	inx	;increment array counter
;	stx	loc	;store next location
;	bra Leave