.PROGRAM morz_pc_mgen()
	; Program which simulates points on a circumference, creating velocity to
	; reach them.
	;
	; Created: 8 May 2014
	; Last edited: 15 May 2014
	;
	; Authors:
	;   Maddiona Marco
	;   Orizio Riccardo
	;   Rizzini Mattia
	;   Zucchelli Maurizio

	morz_sig = 2048
	
	.morz_angle = 0
	.morz_radius = 30
	.morz_dangle = 0.1
	.morz_circ = 360
	.morz_v_const = 50
	.morz_wait = 0.1
	.morz_count = 0
	
	DECOMPOSE .morz_m_c[0] = morz_m_cen

	; POINT morz_horizontal = (1.507,402.609,-160.561,-90.214,179.999,89.784,-134217728.000)

	; TODO: we could use the function DISTANCE in some way to get the distance
	; between two transformation values.
	WHILE TRUE DO
        ;; 
		; Creating the point on the circumference, taking the morz_horizontal
		; point as its center.
		; CIRCLE
		.morz_new_x = .morz_radius * COS( .morz_angle ) + .morz_m_c[0] + .morz_radius / 2 * SIN( .morz_angle * 7 )
		.morz_new_y = .morz_radius * SIN( .morz_angle ) + .morz_m_c[1] + .morz_radius / 2 * COS( .morz_angle * 7 )
		.morz_new_z = .morz_radius * COS( .morz_angle * 21 ) + .morz_m_c[2]
		
		; SINUSOID
		;.morz_new_x = .morz_radius * COS( 2 * .morz_angle ) + DX( morz_m_cen )
		;.morz_new_y = .morz_radius * .morz_angle / 360 - .morz_radius + DY( morz_m_cen )

        DECOMPOSE .morz_old_val[0] = HERE
        .morz_old_x = .morz_old_val[0]
        .morz_old_y = .morz_old_val[1]
		.morz_old_z = .morz_old_val[2]

		; Calculating the velocity for this point: we have to take in account
		; that these values will have a sign!
		; TODO I'm not taking in account the time, so what I'm saying is that
		; velocity = space. Maybe amplifying could be useful.
		morz_vx = ( .morz_new_x - .morz_old_x ) * .morz_v_const
		morz_vy = ( .morz_new_y - .morz_old_y ) * .morz_v_const
        morz_vz = ( .morz_new_z - .morz_old_z ) * .morz_v_const
		
		; Notify of the new info
		SIGNAL morz_sig
		
		; Incrementing the angle of the circle, depending on the update time
		.morz_count = ( .morz_count + 1 ) MOD ( 0.1 / .morz_wait )
		
		IF .morz_count == 0 THEN
			.morz_angle = ( .morz_angle + .morz_dangle ) MOD .morz_circ
		END

		; PRINT "Catch me: ", .morz_angle, ",\tvx = ", morz_vx, ",\tvy = ", morz_vy, ",\tvz = ", morz_vz
		TWAIT .morz_wait
	END
.END
