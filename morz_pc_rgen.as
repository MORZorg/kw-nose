.PROGRAM morz_pc_rgen()
	; Program which simulates points on a circumference, creating velocity to
	; reach them.
	;
	; Created: 14 May 2014
	; Last edited: 15 May 2014
	;
	; Authors:
	;   Maddiona Marco
	;   Orizio Riccardo
	;   Rizzini Mattia
	;   Zucchelli Maurizio

	morz_sig = 2048
	
	.morz_angle = 0
	.morz_radius = 10
	.morz_dangle = 1
	.morz_circ = 360
	.morz_wait = 0.1
	.morz_count = 0

	; POINT morz_horizontal = (1.507,402.609,-160.561,-90.214,179.999,89.784,-134217728.000)

	DECOMPOSE .morz_m_c[0] = morz_m_cen
	
	WHILE TRUE DO
		; Creating the rotation values for Kiwi
		
		; .morz_new_rx = .morz_radius * COS( .morz_angle ) + .morz_m_c[3]
		; .morz_new_ry = .morz_radius * SIN( .morz_angle ) + .morz_m_c[4]
		; .morz_new_rz = .morz_radius * SIN( .morz_angle ) + .morz_m_c[5]
		.morz_new_rx = .morz_m_c[3] + 5
		.morz_new_ry = .morz_m_c[4]
		.morz_new_rz = .morz_m_c[5]
		
        DECOMPOSE .morz_old_val[0] = HERE
        .morz_old_rx = .morz_old_val[3]
        .morz_old_ry = .morz_old_val[4]
		.morz_old_rz = .morz_old_val[5]
		
		morz_rx = .morz_new_rx - .morz_old_rx
		morz_ry = .morz_new_ry - .morz_old_ry
		morz_rz = .morz_new_rz - .morz_old_rz
		
		; Notify of the new info
		SIGNAL morz_sig
		
		; Incrementing the angle of the circle, depending on the update time
		.morz_count = ( .morz_count + 1 ) MOD ( 0.1 / .morz_wait )
		
		IF .morz_count == 0 THEN
			.morz_angle = ( .morz_angle + .morz_dangle ) MOD .morz_circ
			PRINT "Catch me: nrx = ", .morz_new_rx, "\tnry = ", .morz_new_ry, "\tnrz = ", .morz_new_rz
			PRINT "Catch me: orx = ", .morz_old_rx, "\tory = ", .morz_old_ry, "\torz = ", .morz_old_rz
			PRINT "Catch me: rx = ", morz_rx, "\try = ", morz_ry, "\trz = ", morz_rz
		END
		
		TWAIT .morz_wait
	END
.END
