void line( float x, float y, float x_, float y_, int n ) {
  float dist = abs( y_ - y ) / n;
  float cx = x, cy = y;
  while ( cy < y_ ) {

    cx = map( cy, y, y_, x, x_ );
    points.add( new Point( cx, cy, dist + dist / 10 ) );
    //println( cy, cx, dist, width/4, height/4 );
    cy += dist;
  }
}


void map1() {
  points.add( new Point( width/2, height/2, 100 ) );

  points.add( new Point( width/2, height/2 - 65, 50 ) );
  points.add( new Point( width/2, height/2 + 65, 50 ) );

  points.add( new Point( width/2 - 40, height/4, 30 ) );
  points.add( new Point( width/2 + 40, height/4, 30 ) );
  points.add( new Point( width/2 - 40, height/4 + height/2, 30 ) );
  points.add( new Point( width/2 + 40, height/4 + height/2, 30 ) );

  points.add( new Point( width/2 - 30, height/4 + 25, 30 ) );
  points.add( new Point( width/2 + 30, height/4 + 25, 30 ) );
  points.add( new Point( width/2 - 30, height/4 + height/2 - 25, 30 ) );
  points.add( new Point( width/2 + 30, height/4 + height/2 - 25, 30 ) );

  points.add( new Point( width/4 + width/8 - 30, height/2, 30 ) );
  points.add( new Point( width/4 + width/8 + 30, height/2, 30 ) );
  points.add( new Point( width/4 + width*3/8 - 30, height/2, 30 ) );
  points.add( new Point( width/4 + width*3/8 + 30, height/2, 30 ) );

  tanks.add( new Tank( new PVector( width/4, height/2 ), true ) );
  tanks.add( new Tank( new PVector( width/4 + width/2, height/2 ), false ) );
  //tanks.add( new Tank( new PVector( width/4 + width/2, height/2 ), false ) );

  repairs.add( new Repair( new PVector( width/2, height/4 ) ) );
  repairs.add( new Repair( new PVector( width/2, height/4 + height/2 ) ) );

  shields.add( new Shield( new PVector( width/4 + width/8, height/2 ) ) );
  shields.add( new Shield( new PVector( width/4 + width*3/8, height/2 ) ) );

  reloads.add( new FastReload( new PVector( width/5 + width/4, height/2 ) ) );
  reloads.add( new FastReload( new PVector( width/2 + width/4 - width/5, height/2 ) ) );
}


void map2() {
  points.add( new Point( width/2 - 40, height/2, 30 ) );
  points.add( new Point( width/2 + 40, height/2, 30 ) );

  points.add( new Point( width/4 + 35, height/4 + 22, 20 ) );
  points.add( new Point( width/4 + width/2 - 35, height/4 + height/2 - 22, 20 ) );

  points.add( new Point( width/2 - 65, height/2, 60 ) );
  points.add( new Point( width/2 + 65, height/2, 60 ) );

  tanks.add( new Tank( new PVector( width/4, height/4 ), true ) );
  tanks.add( new Tank( new PVector( width/2 + width/4, height/4 + height/2 ), false ) );

  repairs.add( new Repair( new PVector( width/2, height/2 ) ) );
  shields.add( new Shield( new PVector( width/2, height/2 ) ) );
  reloads.add( new FastReload( new PVector( width/2, height/2 ) ) );
}

void map3() {
  line( width/2, 100, width/2, height/2 - 50, 10 );
  line( width/2, height/2 + 50, width/2, height - 100, 10 );

  line( width/2 - 70, 100, width/2 - 70, height/2 - 50, 10 );
  line( width/2 - 70, height/2 + 50, width/2 - 70, height - 100, 10 );

  line( width/2 + 70, 100, width/2 + 70, height/2 - 50, 10 );
  line( width/2 + 70, height/2 + 50, width/2 + 70, height - 100, 10 );

  line( width/4 + 70, height/2 - 40, width/4 + 70, height/2 + 40, 5 );
  line( width*3/4 - 70, height/2 - 40, width*3/4 - 70, height/2 + 40, 5 );

  repairs.add( new Repair( new PVector( width/2 - 35, 100 ) ) );

  tanks.add( new Tank( new PVector( width/4, height/2 ), true ) );
  tanks.add( new Tank( new PVector( width/4 + width/2, height/2 ), false ) );
}