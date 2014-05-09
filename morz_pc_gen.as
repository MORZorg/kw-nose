.PROGRAM morz_pc_gen()
  .morz_angle = 0
  .morz_radius = 50
  .morz_dangle = 1
  
  .morz_old_x = 0
  .morz_old_y = 0
  .morz_old_z = 0
  
  WHILE TRUE DO
	.morz_new_x = .morz_radius * COS( .morz_angle )
	.morz_new_y = .morz_radius * SIN( .morz_angle )
	
	
    ; morz_vx = .morz_new_x - .morz_old_x
	; morz_vy = .morz_new_y - .morz_old_y
	; morz_vz = 0
	morz_vx = .morz_new_x
	morz_vy = .morz_new_y
	morz_vz = 0
	
	.morz_old_x = .morz_new_x
	.morz_old_y = .morz_new_y
	
    print "PC: ", .morz_angle, ",\tvx = ", morz_vx, ",\tvy = ", morz_vy, ",\tvz = ", morz_vz
	
    .morz_angle = ( .morz_angle + .morz_dangle ) MOD 360
    TWAIT 0.1
  END
.END
