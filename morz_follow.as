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

	; TODO: 3 dimension, include the z-axis (or whatever dimension we are not
	; using now).

	; TODO: we could try to estimate this value looking at how many data we receive.
	morz_dist = 50
	
	; POINT #morz_hor_appro = {0.214,25.965,-110.200,0.000,-43.840,-45.214}
	; POINT #morz_horizontal = {0.214,28.684,-110.738,0.000,-40.579,-45.216}

	ACCURACY 500 ALWAYS
	ACCEL 100 ALWAYS
	DECEL 100 ALWAYS
	SPEED 10 ALWAYS
	CP ON
	TOOL globalpinza

	HOME 2
	;JMOVE #morz_hor_appro
	;JMOVE #morz_horizontal
	
	JMOVE #morz_rotational 
	BREAK
	
	ONE morz_returne
	
	WHILE TRUE DO
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
			; IF -INRANGE( SHIFT( HERE BY morz_dx, morz_dy, morz_dz ) ) THEN
			; 	morz_dx = 0
			; 	morz_dy = 0
			; 	morz_dz = 0
			; END
		END
		
		; IF INRANGE( SHIFT( HERE BY morz_dx, morz_dy, morz_dz ) + RX( morz_rx ) + RY( morz_ry ) + RZ( morz_rz ) ) THEN
		; 	morz_rx = 0
		; 	morz_ry = 0
		; 	morz_rz = 0
		; END
		
		; Calibrating and moving.
		SPEED morz_v MM/S
		SIGNAL -morz_sig
		XMOVE ( SHIFT( HERE BY morz_dx, morz_dy, morz_dz ) + RX( morz_rx ) + RY( morz_ry ) + RZ( morz_rz ) ) TILL morz_sig

		; PRINT "Follower:\tv = ", morz_v, ",\ttheta = ", .morz_theta, ",\tphi = ", .morz_phi
	END
.END

.PROGRAM morz_acos( .morz_x, .morz_result )
	.morz_result = 2 * ATAN2( SQRT( 1 - .morz_x ^ 2 ), 1 + .morz_x )
.END

.PROGRAM morz_returne()
	CLOSEI
	TWAIT 0.05
	OPENI
	TwAIT 0.05
	ONE morz_returne
	RETURNE
.END
