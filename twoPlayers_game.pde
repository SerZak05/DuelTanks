//int x, y, r = 20, v = 5;
//int x_, y_, r_ = 20, v_ = 5;


ArrayList<Bullet> bullets;
ArrayList<Point> points;
ArrayList<Tank> tanks = new ArrayList<Tank>();
ArrayList<Repair> repairs = new ArrayList<Repair>();
ArrayList<Shield> shields = new ArrayList<Shield>();
ArrayList<FastReload> reloads = new ArrayList<FastReload>();

boolean killed = false, killed_ = false;
int dir, dir_;

//boolean isRun = false;
int pshot = 0, pshot_= 0;

void setup() {
  //size( displayWidth, displayHeight - 30 );
  //size( displayWidth, displayHeight );
  fullScreen();
  /*x = width/4;
   y = height/2;
   x_ = width/2 + width/4;
   y_ = height/2;*/
  rectMode( CENTER );
  textSize( 60 );
  textAlign( CENTER, CENTER );
  points = new ArrayList<Point>();
  bullets = new ArrayList<Bullet>();
  map1();
}


void keyPressed() {
  if ( menu != 2 ) controlMenu();
  else {
    Tank t_ = tanks.get( 0 );
    Tank t = tanks.get( 1 );
    switch( key ) {
    case 'e':
      if ( t_.reload( pshot ) ) {
        bullets.add( new Bullet( tanks.get(0).coor.x, tanks.get(0).coor.y, tanks.get(1).coor.x, tanks.get(1).coor.y, 5.2, 10, 7.0, true ) );
        pshot = millis();
      }
      //println( pshot, millis(), t_.reload + pshot, t_.reload( pshot ) );
      break;
    case ENTER:
      if ( t.reload( pshot_ ) ) {
        bullets.add( new Bullet( tanks.get(1).coor.x, tanks.get(1).coor.y, tanks.get(0).coor.x, tanks.get(0).coor.y, 5.2, 10, 7.0, false ) );
        pshot_ = millis();
      }
      break;
    case TAB:
      menu = 0;
      dir = 68;
      dir_ = 68;
      break;
    }
  }
}


/*boolean timer( int t ) {
 return millis() >= t;
 }
 
 boolean timer() {
 if ( !isRun ) {
 start = millis();
 isRun = true;
 }
 //println( "timer works!", millis() );
 return  timer( start + t );
 }
 */

void control() {
  Tank t__ = tanks.get( 0 );
  PVector pcoor_ = new PVector( t__.coor.x, t__.coor.y );
  Tank t_ = tanks.get( 1 );
  PVector pcoor = new PVector( t_.coor.x, t_.coor.y );

  switch ( key ) {
  case CODED:
    switch ( keyCode ) {
    case UP:
      dir = UP; 
      break;
    case DOWN:
      dir = DOWN;
      break;
    case LEFT:
      dir = LEFT;
      break;
    case RIGHT:
      dir = RIGHT;
      break;
    case SHIFT:
      dir = 68;
      break;
    }
    break;

  case 'w':
    dir_ = UP;
    break;
  case 's':
    dir_ = DOWN;
    break;
  case 'a':
    dir_ = LEFT;
    break;
  case 'd':
    dir_ = RIGHT;
    break;
  case 'q':
    dir_ = 68;
    break;
  }
  println( dir );
  //println( t_.coor );
  //println( t_.resp );
  switch( dir ) {
  case UP:
    t_.coor.y--;
    break;
  case DOWN:
    t_.coor.y++;
    break;
  case LEFT:
    t_.coor.x--;
    break;
  case RIGHT:
    t_.coor.x++;
    break;
  }

  switch( dir_ ) {
  case UP:
    t__.coor.y--;
    break;
  case DOWN:
    t__.coor.y++;
    break;
  case LEFT:
    t__.coor.x--;
    break;
  case RIGHT:
    t__.coor.x++;
    break;
  }

  for ( Point p : points ) {
    if ( dist( t__.coor.x, t__.coor.y, p.x, p.y ) <= t__.r/2 + p.size/2 ) {
      t__.coor = new PVector( pcoor_.x, pcoor_.y );
      //println( t_.coor, pcoor_ );
    }
    if ( dist( t_.coor.x, t_.coor.y, p.x, p.y ) <= t_.r/2 + p.size/2 ) {
      t_.coor = new PVector( pcoor.x, pcoor.y );
      //println( t_.coor, pcoor_ );
    }
    //println( dist( t_.coor.x, t_.coor.y, p.x, p.y ) <= t_.r/2 + p.size );
  }
}



void draw() {
  background( bg );

  if ( menu == 2 ) {

    control();


    PVector t1 = tanks.get( 0 ).coor;
    PVector t2 = tanks.get( 1 ).coor;
    //println( t1, t2 );

    tanks.get( 0 ).targeting( t2 );
    tanks.get( 1 ).targeting( t1 );

    for ( Repair r : repairs ) {
      if ( r.used ) {
        if ( r.reload( r.when_used ) ) r.used = false;
      } else {
        r.when_used = millis();
        r.draw();
        for ( Tank t : tanks ) {
          if ( !r.isUsed( t ) ) {
            t.lives = t.maxLives;
            r.used = true;
          }
        }
      }
      //println( r.when_used, millis(), r.when_used + r.reload, r.used );
    }

    for ( Shield s : shields ) {
      if ( s.used ) {
        if ( s.reload( s.when_used ) ) s.used = false;
      } else {
        s.when_used = millis();
        s.draw();
        for ( Tank t : tanks ) {
          if ( !s.isUsed( t ) ) {
            t.shielded = true;
            s.used = true;
          }
        }
      }
      //println( r.when_used, millis(), r.when_used + r.reload, r.used );
    }

    for ( FastReload fr : reloads ) {
      if ( fr.used ) {
        if ( fr.reload( fr.when_used ) ) fr.used = false;
      } else {
        fr.when_used = millis();
        fr.draw();
        for ( Tank t : tanks ) {
          if ( !fr.isUsed( t ) ) {
            t.fast_rel = true;
            fr.used = true;
          }
        }
      }
      //println( r.when_used, millis(), r.when_used + r.reload, r.used );
    }

    for ( int i = 0; i < tanks.size(); i++ ) {
      Tank t = tanks.get(i);
      //println( t.resp );
      t.draw();
      for ( int j = 0; j < bullets.size(); j++ ) {
        Bullet b = bullets.get( j );
        if ( t.player == b.team ) continue;
        if ( t.isHit( b ) ) {
          bullets.remove( j );
          if ( t.shielded ) continue;
          if ( t.lives <= 0 ) {
            if ( t.is( tanks.get( 0 ) ) ) killed = true;
            else killed_ = true;
            t.resp_();
            t.lives = 5;
            t.maxLives = 5;
            t.shielded = false;
            println( t.coor );
          } else t.lives--;

          j--;
        }
      }
    }

    if ( killed ) {
      tanks.get( 1 ).kills++;
      killed = false;
    } else if ( killed_ ) {
      tanks.get( 0 ).kills++;
      killed_ = false;
    }
    println("");
    for ( Bullet b : bullets ) {
      b.run();
      b.draw();
    }

    for ( Point p : points ) { 
      p.draw();
    }
    for ( int i = 0; i < bullets.size(); i++ ) {
      Bullet b = bullets.get( i );
      if ( b.targetHit() ) {
        bullets.remove( i );
        i--;
      }
    }

    for ( int i = 0; i < bullets.size(); i++ ) {
      Bullet b = bullets.get( i );

      for ( int j = 0; j < points.size(); j++ ) {

        Point p = points.get(j);

        if ( b.isHit( p ) ) {
          if ( bullets.size() >= 1 ) bullets.remove( i );
        }
      }
    }

    tanks.get(0).drawParam(pshot);
    tanks.get(1).drawParam(pshot_);


    for ( Tank t : tanks ) {
      if ( t.kills >= 20 ) {
        int winner = 1;
        if ( t.player ) {
          fill( 255, 0, 0 );
        } else { 
          winner = 2;
          fill( 0, 0, 255 );
        }
        background( 0, 0, 0 );
        text( "The Winner is player №" + winner + "!!!", width/2, height/2 );
      }
    }
    if ( millis() >= 600000 ) {
      int winner = 0;
      fill( 255, 0, 255 );
      if ( tanks.get( 0 ).kills > tanks.get( 1 ).kills ) winner = 1;
      else if ( tanks.get( 1 ).kills > tanks.get( 0 ).kills ) winner = 2;
      background( 0, 0, 0 );
      if ( winner != 0 ) text( "The Winner is player №" + winner + "!!!", width/2, height/2 );
      else text( "Draw.", width/2, height/2 );
    }
  } else menu();
}