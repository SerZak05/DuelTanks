class Bullet {
  PVector origin;
  PVector target;
  PVector current;
  float calibre;

  float velocity;
  private float vx;
  private float vy;
  float damg;

  //boolean will_crash;
  //boolean yDir;
  //boolean xDir;
  //ArrayList<PVector> Hits = new ArrayList<PVector>();

  boolean team;

  Bullet( float x1, float y1, float x2, float y2, float damage, int calb, float vel, boolean t ) {

    origin = new PVector( x1, y1 );
    target = new PVector( x2, y2 );
    velocity = vel;
    damg = damage;
    calibre = calb;

    float asimut = atan2( x2-x1, y2-y1 );

    vx = velocity * sin( asimut );
    vy = velocity * cos( asimut );
    current = new PVector( origin.x, origin.y );

    team = t;
  }

  void run() {
    current.x += vx;
    current.y += vy;
    //xDir = current.x > origin.x;
    //yDir = current.y > origin.y;
  }

  boolean isHit() {
    //println( current.dist( origin ) );
    //println( target.dist( origin ) );
    return ( current.dist( origin ) >= target.dist( origin ) || current.x >= width || current.x <= 0 || current.y >= height || current.y <= 0 );
  }

  boolean isHit( Point p ) {
    //println( String.format( "dist: %.2f, rad: %.2f", current.dist( p ), (p.size/2 + calibre/2) ) );  
    return current.dist( p ) <= (p.size/2 + calibre/2);
  }
  boolean targetHit() {
    return current.x >= width || current.x <= 0 ||
      current.y >= height || current.y <= 0;
  }



  void draw() {
    noStroke();
    if ( !team ) fill( 0, 0, 255 );
    else fill ( 255, 0, 0 );
    ellipse( current.x, current.y, calibre, calibre );
  }
}