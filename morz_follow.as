.PROGRAM morz_follow()
  SPEED 10 ALWAYS
  HOME
  HOME 2
  TOOL globalpinza
  .morz_count = 0
  ACCURACY 500 ALWAYS
  SPEED 10 ALWAYS
  CP ON
  WHILE TRUE DO
    POINT .morz_point = TRANS(morz_x, morz_y, morz_z, 90, 90, -90)
    JMOVE .morz_point

    print "Program: ", .morz_count
    .morz_count = .morz_count + 1
  END
.END
