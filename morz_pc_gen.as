.PROGRAM morz_pc_gen()
  morz_x = 0
  morz_y = 650
  morz_z = 160
  
  .morz_angle = 0
  .morz_radius = 100
  .morz_d_angle = 1
  WHILE TRUE DO
    ; TODO
    .morz_d_x = .morz_radius * COS(.morz_angle)
    .morz_d_x = .morz_radius * SIN(.morz_angle)
    morz_x = morz_x + .delta_x
    morz_y = morz_y + .delta_y
    
    .morz_angle = .morz_angle + .morz_d_angle
    print "PC: ", .morz_angle

    TWAIT 0.1
  END
.END
