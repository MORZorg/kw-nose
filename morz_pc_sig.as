.PROGRAM morz_pc_sig()
	; 
	;
	; Created: 21 May 2014
	; Last edited: 21 May 2014
	;
	; Authors:
	;   Maddiona Marco
	;   Orizio Riccardo
	;   Rizzini Mattia
	;   Zucchelli Maurizio

	morz_on_move = 2042
	morz_move_time = 10
	
	WHILE TRUE DO
		IF SIG( morz_on_move ) THEN
			TWAIT morz_move_time
			SIGNAL -morz_on_move
		END
	END
.END
