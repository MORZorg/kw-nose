.PROGRAM morz_pc_gen()
	; Program which simulates points on a circumference, creating velocity to
	; reach them.
	;
	; Created: 8 May 2014
	; Last edited: 9 May 2014
	;
	; Authors:
	;   Maddiona Marco
	;   Orizio Riccardo
	;   Rizzini Mattia
	;   Zucchelli Maurizio

	.morz_angle = 0
	.morz_radius = 50
	.morz_dangle = 1
	.morz_circ = 360
	.morz_v_const = 50

	.morz_old_x = 0
	.morz_old_y = 0
	.morz_old_z = 0

	; TODO: we could use the function DISTANCE in some way to get the distance
	; between two transformation values.

	WHILE TRUE DO
		; Creating the point on the circumference, taking the morz_horizontal
		; point as its center.
		; FIXME Adding DX/DY should be kind of useless as it annihilates itself
		; Another possibility could be to use the current distance of Kiwi 
		; from the next point on the circumference to calculate the distance.
		.morz_new_x = .morz_radius * COS( .morz_angle ) + DX( morz_horizontal )
		.morz_new_y = .morz_radius * SIN( .morz_angle ) + DY( morz_horizontal )

		; Calculating the velocity for this point: we have to take in account
		; that these values will have a sign!
		; TODO I'm not taking in account the time, so what I'm saying is that
		; velocity = space. Maybe amplifying could be useful.
		morz_vx = morz_new_x - morz_old_x
		morz_vy = morz_new_y - morz_old_y

		; Saving these values for the next cycle.
		.morz_old_x = .morz_new_x
		.morz_old_y = .morz_new_y

		; Incrementing the angle of the circle.
		.morz_angle = ( .morz_angle + .morz_dangle ) MOD .morz_circ

		PRINT "Catch me: ", .morz_angle, ",\tvx = ", morz_vx, ",\tvy = ", morz_vy, ",\tvz = ", morz_vz
		TWAIT 0.1
	END
.END
