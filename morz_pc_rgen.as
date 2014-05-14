.PROGRAM morz_pc_rgen()
	; Program which simulates points on a circumference, creating velocity to
	; reach them.
	;
	; Created: 14 May 2014
	; Last edited: 14 May 2014
	;
	; Authors:
	;   Maddiona Marco
	;   Orizio Riccardo
	;   Rizzini Mattia
	;   Zucchelli Maurizio

	morz_sig = 2048
	
	.morz_angle = 0
	.morz_x_angle = 0
	.morz_y_angle = 0
	.morz_z_angle = 0
	.morz_dangle = 1
	.morz_circ = 20
	.morz_center = .morz_circ / 2
	.morz_radius = 10
	.morz_wait = 0.1
	.morz_count = 0

	; POINT morz_horizontal = (1.507,402.609,-160.561,-90.214,179.999,89.784,-134217728.000)

	
	WHILE TRUE DO
		; Creating the rotation values for Kiwi
		; morz_rx = .morz_x_angle - .morz_center
		; morz_ry = morz_rx
		; morz_rz = morz_rx
		
		morz_rx = .morz_radius * COS( .morz_angle )
		morz_ry = .morz_radius * SIN( .morz_angle )
		morz_rz = .morz_radius * SIN( .morz_angle )
		
		; Velocities
		morz_vx = 0
		morz_vy = 0
		morz_vz = 0
		
		; Notify of the new info
		SIGNAL morz_sig
		
		; Incrementing the angle of the circle, depending on the update time
		.morz_count = ( .morz_count + 1 ) MOD ( 0.1 / .morz_wait )
		
		IF .morz_count == 0 THEN
			.morz_angle = ( .morz_angle + .morz_dangle ) MOD 360
			.morz_z_angle = ( .morz_z_angle + .morz_dangle ) MOD .morz_circ 
			; PRINT "Catch me: x = ", morz_rx, "\ty = ", morz_ry, "\tz = ", morz_rz
		END
		
		TWAIT .morz_wait
	END
.END
