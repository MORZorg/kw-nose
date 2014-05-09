.PROGRAM morz_follow()
  morz_dist = 10
  ACCURACY morz_dist ALWAYS
  ACCEL 100 ALWAYS
  DECEL 100 ALWAYS
  SPEED 10 ALWAYS
  CP ON

  HOME 2
  TOOL globalpinza
  JMOVE morz_horizontal
  
  .morz_count = 0
  WHILE TRUE DO
	
    print "Program: ", .morz_count, ",\tv = ", morz_v, ",\ttheta = ", morz_theta
	
	morz_dx = morz_dist * COS( morz_theta )
	morz_dy = morz_dist * SIN( morz_theta )
	morz_dz = 0
	
	SPEED morz_v MM/S
	HERE morz_current
	; Working on y (invert y and z)
	JMOVE SHIFT( morz_current BY morz_dx, morz_dz, morz_dy )
	
    print "Program: ", .morz_count, ",\tdx = ", morz_dx, ",\tdy = ", morz_dy, ",\tdz = ", morz_dz
    .morz_count = .morz_count+1
  END
.END
