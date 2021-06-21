class Tank {
  PVector coor = new PVector();
  //PVector pcoor = new PVector();
  final PVector resp;

  float lives;
  float maxLives;
  int pr = 20;
  int r = 20;
  float v = 0.5;

  boolean player;
  color fill;
  PVector target = new PVector();

  int kills = 0;
  int reload = 2000;
  int preload = 2000;
  int nreload = 500;

  Tank( PVector c, boolean p ) {
    coor = c;
    resp = new PVector( coor.x, coor.y );
    //pcoor = coor;
    maxLives = 5;
    lives = 5;
    //player = p;
    if ( p ) fill = color( 255, 0, 0 );
    else fill = color( 0, 0, 255 );
    player = p;
  }

  boolean is( Tank t ) {
    return coor == t.coor && resp == t.resp && lives == t.lives;
  }

  boolean reload( int psh ) {
    return millis() - psh >= reload;
  }


  void targeting( PVector t ) {
    target = t;
  }


  boolean isHit( Bullet b ) {
    return dist( coor.x, coor.y, b.current.x, b.current.y ) <= r/2 + b.calibre;
  }

  void resp_() {
    //println( "Before - " + coor, resp );
    coor = new PVector( resp.x, resp.y );
    //println( "After - " + coor, resp );
  }

  int whenShielded = millis();
  boolean shielded = false;
  int shieldTime = 10000;
  void shielded() {
    if ( shielded ) {
      stroke( 0, 200, 255 );
      fill( 0, 0, 255, 50 );
      //r = pr + 50;
      ellipse( coor.x, coor.y, r + 50, r + 50 );

      if ( whenShielded + shieldTime < millis() ) {
        shielded = !shielded;
        //println( 1 );
      }
    }
  }

  int whenfreloaded = millis();
  boolean fast_rel = false;
  int freloadTime = 10000;
  void fast_reload() {
    if ( fast_rel ) {
      reload = nreload;
      if ( whenfreloaded + freloadTime < millis() ) {
        fast_rel = !fast_rel;
        reload = preload;
        //println( 1 );
      }
    }
  }

  //void control() {

  //}

  void drawParam( int psh ) {
    float x, y;
    String text = "Kills: " + kills;
    pushStyle();
    textAlign( CORNER );
    textSize( 40 );
    fill( fill );
    if ( player ) { 
      x = 10;
      y = 40;
    } else {
      x = width - ( textWidth( text ) + 10 );
      y = height - 10;
    }
    text( text, x, y );
    popStyle();

    float load = map( millis(), psh, psh + reload, -15, 15 );
    load = constrain( load, -15, 15 );
    stroke( 255, 255, 0 );
    //if ( load >= 15 ) load = 15; = constrain( -15, 15 );
    line( coor.x - 15, coor.y-r/2 - 5, coor.x + load, coor.y-r/2 - 5 );
    //println( load );

    load = map( lives, 0, maxLives, -15, 15 );
    stroke( 255, 0, 0 );
    //if ( load >= 15 ) load = 15; = constrain( -15, 15 );
    line( coor.x - 15, coor.y-r/2 - 10, coor.x + load, coor.y-r/2 - 10 );
    //println( load );

    if ( shielded ) {
      load = map( millis(), whenShielded, whenShielded + shieldTime, -15, 15 );
      stroke( 0, 255, 255 );
      line( coor.x - 15, coor.y-r/2 - 15, coor.x + 15, coor.y-r/2 - 15 );
      line( coor.x - 15, coor.y-r/2 - 16, coor.x + 15, coor.y-r/2 - 16 );
      stroke( 0 );
      line( coor.x + 15, coor.y-r/2 - 15, coor.x - load, coor.y-r/2 - 15 );
      line( coor.x + 15, coor.y-r/2 - 16, coor.x - load, coor.y-r/2 - 16 );
    }

    if ( fast_rel ) {
      load = map( millis(), whenfreloaded, whenfreloaded + freloadTime, -15, 15 );
      stroke( 255, 0, 255 );
      line( coor.x - 15, coor.y-r/2 - 15, coor.x + 15, coor.y-r/2 - 15 );
      //line( coor.x - 15, coor.y-r/2 - 16, coor.x + 15, coor.y-r/2 - 16 );
      stroke( 0 );
      line( coor.x + 15, coor.y-r/2 - 15, coor.x - load, coor.y-r/2 - 15 );
      //line( coor.x + 15, coor.y-r/2 - 16, coor.x - load, coor.y-r/2 - 16 );
    }
  }

  void draw() {    
    if ( !shielded ) {
      //r = pr;
      whenShielded = millis();
    }
    shielded();

    if ( !fast_rel ) {
      whenfreloaded = millis();
      preload = reload;
    }
    fast_reload();

    //println( shielded, whenShielded, millis(), whenShielded + shieldTime );

    int trans = int( map( lives, 0, int( maxLives ), 0, 255 ) );
    //println( trans );
    fill( fill, trans );
    if ( trans == 0 ) stroke( 255 );
    else noStroke();
    ellipse( coor.x, coor.y, r, r );

    /*float a = atan2( (target.x - coor.x), (target.y - coor.y) );
     float gx = x + r*sin( a );
     float gy = y + r*cos( a );
     stroke( 0, 255, 255 );
     line( coor.x, coor.y, gx, gy );*/
    float a = atan2( (target.x - coor.x), (target.y - coor.y) );
    float x_= coor.x + r*sin( a );
    float y_= coor.y + r*cos( a );
    stroke( 0, 255, 255 );
    line( coor.x, coor.y, x_, y_ );
    stroke( 255 );
  }
}