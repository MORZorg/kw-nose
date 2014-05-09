.PROGRAM morz_pc_gen()
  .morz_angle = 0
  .morz_radius = 50
  .morz_dangle = 1
  
  WHILE TRUE DO
	morz_v = .morz_radius * SIN( .morz_angle ) + 2 * .morz_radius
	morz_theta = .morz_angle
	
    print "PC: ", .morz_angle, ",\tv = ", morz_v, ",\ttheta = ", morz_theta
	
    .morz_angle = ( .morz_angle + .morz_dangle ) MOD 360
    TWAIT 0.1
  END
.END
