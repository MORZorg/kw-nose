.PROGRAM morz_follow()
	; Program which tries to follow some points in the space, knowing the speed
	; to reach them.
	;
	; Created: 8 May 2014
	; Last edited: 15 May 2014
	;
	; Authors:
	;   Maddiona Marco
	;   Orizio Riccardo
	;   Rizzini Mattia
	;   Zucchelli Maurizio

	; TODO: we could try to estimate this value looking at how many data we receive.
	morz_dist = 10
	morz_move_sig = 2042
	morz_data_sig = 2048
	morz_reset_sig = 2050

    morz_r_scale = 50
	
	; POINT #morz_hor_appro = {0.214,25.965,-110.200,0.000,-43.840,-45.214}
	; POINT #morz_horizontal = {0.214,28.684,-110.738,0.000,-40.579,-45.216}

	ACCURACY 500 ALWAYS
	ACCEL 100 ALWAYS
	DECEL 100 ALWAYS
	SPEED 10 ALWAYS
	CP ON
	TOOL globalpinza

	HOME 2
	; JMOVE #morz_hor_appro
	; JMOVE #morz_horizontal
	; JMOVE #morz_rotational
	JMOVE #morz_isengard
	; JMOVE #morz_wood_hor
	BREAK
	
	ONE morz_returne
	
	WHILE TRUE DO
		DECOMPOSE .morz_current[0] = HERE
	
		morz_vx = 0
		morz_vy = 0
		morz_vz = 0
		
		CALL morz_euler_transform( morz_sens_vx, morz_sens_vy, morz_sens_vz, -.morz_current[3], -.morz_current[4], -.morz_current[5], morz_vx, morz_vy, morz_vz )
		
		; morz_vx = morz_vx * 1000
		; morz_vy = morz_vy * 1000
		; morz_vz = morz_vz * 1000
		; morz_sens_vrx = morz_sens_vrx * 1000
		; morz_sens_vry = morz_sens_vry * 1000
		; morz_sens_vrz = morz_sens_vrz * 1000
		
		; Calculating the velocity that will be used for the speed of the Kiwi.
		morz_v = SQRT( morz_vx ^ 2 + morz_vy ^ 2 + morz_vz ^ 2 )
		;morz_dist = morz_v / 10
		
		; We need this value with the sign to know the correct direction in
		; which we have to move.
		; TODO: Check if gives the angle in the correct way, if is restricted
		; in some range or not. (Should be right.)
		IF morz_v == 0 THEN
			morz_dx = 0
			morz_dy = 0
			morz_dz = 0
			morz_v = 50
		ELSE
			CALL morz_acos( morz_vz / morz_v, .morz_theta )
			.morz_phi = ATAN2( morz_vy, morz_vx )

			; Estimating the end point
			morz_dx = morz_dist * SIN( .morz_theta ) * COS( .morz_phi )
			morz_dy = morz_dist * SIN( .morz_theta ) * SIN( .morz_phi )
			morz_dz = morz_dist * COS( .morz_theta )
		END

        morz_rx = morz_sens_vrx / morz_r_scale
        morz_ry = morz_sens_vry / morz_r_scale
        morz_rz = morz_sens_vrz / morz_r_scale
		
		if SIG( morz_data_sig ) THEN
			; Calibrating and moving.
			morz_v = SQRT( morz_v )
			SPEED morz_v MM/S
			SIGNAL -morz_data_sig
			PULSE morz_move_sig, ( morz_dist / morz_v ) / 2
			XMOVE ( SHIFT( HERE BY morz_dx, morz_dy, morz_dz ) + RX( morz_rx ) + RY( morz_ry ) + RZ( morz_rz ) ) TILL - morz_move_sig
			; XMOVE ( HERE + RX( morz_rx ) + RY( morz_ry ) + RZ( morz_rz ) ) TILL morz_sig
		ELSE
			IF SIG( morz_reset_sig ) THEN
				CALL morz_reset_speed
			END
		END

		; PRINT "Follower:\tdx = ", morz_dx, ",\tdy = ", morz_dy, ",\tdz = ", morz_dz
	END
.END

.PROGRAM morz_acos( .morz_x, .morz_result )
	.morz_result = 2 * ATAN2( SQRT( 1 - .morz_x ^ 2 ), 1 + .morz_x )
.END

.PROGRAM morz_returne()
	CLOSEI
	TWAIT 0.1
	OPENI
	TwAIT 0.2
	ONE morz_returne
	RETURNE
.END

.PROGRAM morz_reset_speed()
	morz_sens_vx = 0
	morz_sens_vy = 0
	morz_sens_vz = 0
	morz_sens_vrx = 0
	morz_sens_vry = 0
	morz_sens_vrz = 0
	
	SIGNAL -morz_reset_sig
.END

.PROGRAM morz_euler_transform( .morz_from_x, .morz_from_y, .morz_from_z, .morz_alpha, .morz_beta, .morz_gamma, .morz_to_x, .morz_to_y, .morz_to_z )
      .morz_to_x = ( COS(.morz_alpha)*COS(.morz_beta)*COS(.morz_gamma) - SIN(.morz_alpha)*SIN(.morz_gamma) ) * .morz_from_x + ( -COS(.morz_alpha)*COS(.morz_beta)*SIN(.morz_gamma) - SIN(.morz_alpha)*COS(.morz_gamma) ) * .morz_from_y + ( COS(.morz_alpha)*SIN(.morz_beta) ) * .morz_from_z;
      
      .morz_to_y = ( SIN(.morz_alpha)*COS(.morz_beta)*COS(.morz_gamma) + COS(.morz_beta)*SIN(.morz_gamma) ) * .morz_from_x + ( -SIN(.morz_alpha)*COS(.morz_beta)*SIN(.morz_gamma) + COS(.morz_alpha)*COS(.morz_gamma) ) * .morz_from_y + ( SIN(.morz_alpha)*SIN(.morz_beta) ) * .morz_from_z;
      
      .morz_to_z = ( -SIN(.morz_beta)*COS(.morz_gamma) ) * .morz_from_x + ( SIN(.morz_beta)*SIN(.morz_gamma) ) * .morz_from_y + ( COS(.morz_beta) ) * .morz_from_z;
.END
