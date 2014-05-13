.PROGRAM morz_follow()
	; Program which tries to follow some points in the space, knowing the speed
	; to reach them.
	;
	; Created: 8 May 2014
	; Last edited: 9 May 2014
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
	
	ACCURACY 500 ALWAYS
	ACCEL 100 ALWAYS
	DECEL 50 ALWAYS
	SPEED 10 ALWAYS
	CP ON
	TOOL globalpinza

	; HOME 2
	JMOVE #morz_hor_appro
	SPEED 3
	JMOVE #morz_horizontal
	BREAK
	
	.morz_count = 0
	WHILE TRUE DO
		; Calculating the velocity that will be used for the speed of the Kiwi.
		morz_v = SQRT( morz_vx ^ 2 + morz_vy ^ 2 )	
		; morz_dist = morz_v
		
		; We need this value with the sign to know the correct direction in
		; which we have to move.
		; TODO: Check if gives the angle in the correct way, if is restricted
		; in some range or not. (Should be right.)
		.morz_theta = ATAN2( morz_vy, morz_vx )

		; Estimating the end point
		morz_dx = morz_dist * COS( .morz_theta )
		morz_dy = morz_dist * SIN( .morz_theta )
		morz_dz = 0
		
		; Calibrating and moving.
		SPEED morz_v MM/S
		SIGNAL -morz_sig
		XMOVE SHIFT( HERE BY morz_dx, morz_dy, morz_dz ) TILL morz_sig

		;PRINT "Follower: ", .morz_count, ",\tv = ", morz_v, ",\ttheta = ", morz_theta

		.morz_count = .morz_count + 1
	END
.END
