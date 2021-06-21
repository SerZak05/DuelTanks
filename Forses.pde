class Forse {
  //PVector pcoor = new PVector();
  final PVector resp;
  int r = 20;
  color fill;
  int reload = 20000;

  boolean used = false;
  int when_used = millis();

  Forse( PVector c ) {
    resp = new PVector( c.x, c.y );
  }

  void resp() {
    used = false;
  }

  boolean reload( int pshot ) {
    return reload + pshot <= millis();
  }

  boolean isUsed( Tank t ) {
    return dist( resp.x, resp.y, t.coor.x, t.coor.y ) >= r/2 + t.r/2;
  }
}


class Repair extends Forse {

  Repair( PVector c ) {
    super( c );
    reload += 15000;
  }

  void draw() {
    stroke( 0, 255, 255 );
    fill( 255, 255, 100 );
    ellipse( resp.x, resp.y, r, r );
    fill( 0, 255, 0 );
    ellipse( resp.x, resp.y, r/2, r/2 );
  }
}



class Shield extends Forse {

  Shield( PVector c ) {
    super( c );
  }

  void draw() {
    stroke( 0, 0, 255 );
    fill( 255, 255, 100 );
    ellipse( resp.x, resp.y, r, r );
    fill( 0, 0, 255, 50 );
    ellipse( resp.x, resp.y, r/2, r/2 );
  }
}


class FastReload extends Forse {

  FastReload( PVector c ) {
    super( c );
  }

  void draw() {
    stroke( 255 );
    fill( 255, 255, 100 );
    ellipse( resp.x, resp.y, r, r );
    fill( 255 );
    ellipse( resp.x, resp.y, r/2, r/2 );
  }
}
