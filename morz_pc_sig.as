.PROGRAM morz_pc_sig()

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
	; Created: 21 May 2014
	; Last edited: 21 May 2014

	morz_on_move = 2042
	morz_move_time = 10
	
	WHILE TRUE DO
		IF SIG( morz_on_move ) THEN
			TWAIT morz_move_time
			SIGNAL -morz_on_move
		END
	END
.END
