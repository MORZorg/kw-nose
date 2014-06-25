.PROGRAM morz_pc_gen()

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
	; Created: 14 May 2014
	; Last edited: 14 May 2014

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

	WHILE TRUE DO
        DECOMPOSE .morz_old_val[0] = HERE
		
		;; 
		; Creating the point on the circumference, taking the morz_horizontal
		; point as its center.
		; CIRCLE
		.morz_new_x = .morz_m_radius * COS( .morz_m_angle ) + .morz_m_c[0] + .morz_m_radius / 2 * SIN( .morz_m_angle * 7 )
		.morz_new_y = .morz_m_radius * SIN( .morz_m_angle ) + .morz_m_c[1] + .morz_m_radius / 2 * COS( .morz_m_angle * 7 )
		.morz_new_z = .morz_m_radius / 2 * COS( .morz_m_angle * 21 ) + .morz_m_c[2] + .morz_m_radius / 4
		
		; SINUSOID
		;.morz_new_x = .morz_radius * COS( 2 * .morz_angle ) + DX( morz_m_cen )
		;.morz_new_y = .morz_radius * .morz_angle / 360 - .morz_radius + DY( morz_m_cen )

		; Calculating the velocity for this point: we have to take in account
		; that these values will have a sign!
		; Note: I'm not taking in account the time, so what I'm saying is that
		; velocity = space. Maybe amplifying could be useful.
		.morz_tool_vx = ( .morz_new_x - .morz_old_val[0] ) * .morz_v_const
		.morz_tool_vy = ( .morz_new_y - .morz_old_val[1] ) * .morz_v_const
		.morz_tool_vz = ( .morz_new_z - .morz_old_val[2] ) * .morz_v_const
		
		; AS sucks
		morz_base_vx = 0
		morz_base_vy = 0
		morz_base_vz = 0
		
		; The translation values created are referred to the tool axis system.
		; Since the movement is executed via a SHIFT operation, these values
		; must be converted to translation values in the base axis system
		CALL morz_euler_transform( .morz_tool_vx, .morz_tool_vy, .morz_tool_vz, .morz_old_val[3], .morz_old_val[4], .morz_old_val[5], morz_sens_vx, morz_sens_vy, morz_sens_vz )
		; PRINT "Converted (", .morz_tool_vx, ", ", .morz_tool_vy, ", ", .morz_tool_vz, " ) into (", morz_base_vx, ", ", morz_base_vy, ", ", morz_base_vz, " )."
		; CALL morz_euler_transform( morz_base_vx, morz_base_vy, morz_base_vz, .morz_old_val[3], .morz_old_val[4], .morz_old_val[5], .morz_tool_vx, .morz_tool_vy, .morz_tool_vz )
		; PRINT "Converted (", morz_base_vx, ", ", morz_base_vy, ", ", morz_base_vz, " ) into (", .morz_tool_vx, ", ", .morz_tool_vy, ", ", .morz_tool_vz, " )." 
		
		; Creating the rotation values for Kiwi
		; morz_rx = .morz_x_angle - .morz_center
		; morz_ry = morz_rx
		; morz_rz = morz_rx
		
		.morz_new_rx = .morz_r_radius * COS( .morz_r_angle ) + .morz_m_c[3]
		.morz_new_ry = .morz_r_radius * SIN( .morz_r_angle ) + .morz_m_c[4]
		.morz_new_rz = .morz_r_radius * SIN( .morz_r_angle ) + .morz_m_c[5]
		
		morz_vrx = .morz_new_rx - .morz_old_val[3]
		morz_vry = .morz_new_ry - .morz_old_val[4]
		morz_vrz = .morz_new_rz - .morz_old_val[5]
		
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

