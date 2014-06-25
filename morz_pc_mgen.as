.PROGRAM morz_pc_mgen()
	
	; Copyright (C) 2014 Marco Maddiona, Riccardo Orizio, Mattia Rizzini, Maurizio Zucchelli
	;
	; This program is free software: you can redistribute it and/or modify
	; it under the terms of the GNU General Public License as published by
	; the Free Software Foundation, either version 3 of the License, or
	; (at your option) any later version.
	;
	; This program is distributed in the hope that it will be useful,
	; but WITHOUT ANY WARRANTY; without even the implied warranty of
	; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	; GNU General Public License for more details.
	;
	; You should have received a copy of the GNU General Public License
	; along with this program.  If not, see <http://www.gnu.org/licenses/>.
	;
	; For any further information please contact us at
	; morzorganization@gmail.com
	; 
	; Program which simulates points on a circumference, creating velocity to
	; reach them.
	;
	; Created: 8 May 2014
	; Last edited: 15 May 2014

	morz_sig = 2048
	
	.morz_angle = 0
	.morz_radius = 50
	.morz_dangle = 0.05
	.morz_circ = 360
	.morz_wait = 0.01
	.morz_count = 0
	.morz_v_const = 1
	
	DECOMPOSE .morz_m_c[0] = morz_m_cen

	WHILE TRUE DO
		;; 
		; Creating the point on the circumference, taking the morz_horizontal
		; point as its center.
		; CIRCLE
		.morz_new_x = .morz_radius * COS( .morz_angle ) + .morz_m_c[0] + .morz_radius / 2 * SIN( .morz_angle * 7 )
		.morz_new_y = .morz_radius * SIN( .morz_angle ) + .morz_m_c[1] + .morz_radius / 2 * COS( .morz_angle * 7 )
		; .morz_new_z = .morz_radius * COS( .morz_angle * 21 ) + .morz_m_c[2]
		.morz_new_z = .morz_m_c[2]
		
		; SINUSOID
		;.morz_new_x = .morz_radius * COS( 2 * .morz_angle ) + DX( morz_m_cen )
		;.morz_new_y = .morz_radius * .morz_angle / 360 - .morz_radius + DY( morz_m_cen )

		DECOMPOSE .morz_old_val[0] = HERE
		.morz_old_x = .morz_old_val[0]
		.morz_old_y = .morz_old_val[1]
		.morz_old_z = .morz_old_val[2]

		; Calculating the velocity for this point: we have to take in account
		; that these values will have a sign!
		; Note: I'm not taking in account the time, so what I'm saying is that
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
