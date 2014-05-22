.PROGRAM morz_pc_gen()
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
	
	.morz_m_angle = 0
	.morz_m_radius = 30
	.morz_m_dangle = 0.1
	.morz_r_angle = 0
	.morz_r_radius = 5
	.morz_r_dangle = 1
	.morz_circ = 360
	.morz_wait = 0.1
	.morz_count = 0
	.morz_v_const = 50
	
	DECOMPOSE .morz_m_c[0] = morz_m_cen

	; POINT morz_horizontal = (1.507,402.609,-160.561,-90.214,179.999,89.784,-134217728.000)

	; TODO: we could use the function DISTANCE in some way to get the distance
	; between two transformation values.
	WHILE TRUE DO
        DECOMPOSE .morz_old_val[0] = HERE
		
        ;; 
		; Creating the point on the circumference, taking the morz_horizontal
		; point as its center.
		; CIRCLE
		.morz_new_x = .morz_m_radius * COS( .morz_m_angle ) + .morz_m_c[0] + .morz_m_radius / 2 * SIN( .morz_m_angle * 7 )
		.morz_new_y = .morz_m_radius * SIN( .morz_m_angle ) + .morz_m_c[1] + .morz_m_radius / 2 * COS( .morz_m_angle * 7 )
		.morz_new_z = .morz_m_radius * COS( .morz_m_angle * 21 ) + .morz_m_c[2]
		
		; SINUSOID
		;.morz_new_x = .morz_radius * COS( 2 * .morz_angle ) + DX( morz_m_cen )
		;.morz_new_y = .morz_radius * .morz_angle / 360 - .morz_radius + DY( morz_m_cen )

		; Calculating the velocity for this point: we have to take in account
		; that these values will have a sign!
		; TODO I'm not taking in account the time, so what I'm saying is that
		; velocity = space. Maybe amplifying could be useful.
		morz_vx = ( .morz_new_x - .morz_old_val[0] ) * .morz_v_const
		morz_vy = ( .morz_new_y - .morz_old_val[1] ) * .morz_v_const
        morz_vz = ( .morz_new_z - .morz_old_val[2] ) * .morz_v_const
		; Creating the rotation values for Kiwi
		; morz_rx = .morz_x_angle - .morz_center
		; morz_ry = morz_rx
		; morz_rz = morz_rx
		
		.morz_new_rx = .morz_r_radius * COS( .morz_r_angle ) + .morz_m_c[3]
		.morz_new_ry = .morz_r_radius * SIN( .morz_r_angle ) + .morz_m_c[4]
		.morz_new_rz = .morz_r_radius * SIN( .morz_r_angle ) + .morz_m_c[5]
		
		morz_rx = .morz_new_rx - .morz_old_val[3]
		morz_ry = .morz_new_ry - .morz_old_val[4]
		morz_rz = .morz_new_rz - .morz_old_val[5]
		
		; Notify of the new info
		SIGNAL morz_sig
		
		; Incrementing the angle of the circle, depending on the update time
		.morz_count = ( .morz_count + 1 ) MOD ( 0.1 / .morz_wait )
		
		IF .morz_count == 0 THEN
			.morz_m_angle = ( .morz_m_angle + .morz_m_dangle ) MOD .morz_circ
			.morz_r_angle = ( .morz_r_angle + .morz_r_dangle ) MOD .morz_circ
		END

		; PRINT "Catch me: ", .morz_angle, ",\tvx = ", morz_vx, ",\tvy = ", morz_vy, ",\tvz = ", morz_vz
		TWAIT .morz_wait
	END
.END
