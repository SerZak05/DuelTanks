class Point extends PVector {
  public float size = 20;

  Point( float x_, float y_, float s ) {
    super( x_, y_ );
    size = s;
  }

  void draw() {
    noStroke();
    fill( 157, 189, 50 );
    ellipse( x, y, size, size ); 
    //hiding();
  }
}
