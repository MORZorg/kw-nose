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

	; TODO: we could try to estimate this value looking at how many data we
	; receive morz_dist = 10.
	ACCURACY morz_dist ALWAYS
	ACCEL 100 ALWAYS
	DECEL 100 ALWAYS
	SPEED 10 ALWAYS
	CP ON
	TOOL globalpinza

	HOME 2
	JMOVE morz_horizontal

	.morz_count = 0
	WHILE TRUE DO
		; Calculating the velocity that will be used for the speed of the Kiwi.
		.morz_v = SQRT( morz_vx * morz_vx + morz_vy * morz_vy )
		; We need this value with the sign to know the correct direction in
		; which we have to move.
		; TODO: Check if gives the angle in the correct way, if is restricted
		; in some range or not. (Should be right.)
		.morz_theta = ATAN2( morz_vy, morz_vx )

		; Estimating the end point
		.morz_dx = morz_dist * COS( .morz_theta )
		.morz_dy = morz_dist * SIN( .morz_theta )

		; Calibrating and moving.
		SPEED morz_v MM/S
		JMOVE SHIFT( HERE BY .morz_dx, .morz_dy, .morz_dz )
		; Just in case the previous operation makes some trouble. :D
		; HERE .morz_current
		; JMOVE SHIFT( .morz_current BY .morz_dx, .morz_dy, .morz_dz )

		PRINT "Follower: ", .morz_count, ",\tv = ", .morz_v, ",\ttheta = ", .morz_theta

		.morz_count = .morz_count + 1
	END
.END
