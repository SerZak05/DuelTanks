String NOTG = "Двойные танки онлайн!";
String[] items = new String[] {
  "Начать игру", 
  "Настройки", 
  "Выход"
};
String[] Settings = new String[] {
  "Белый фон", 
  "Черный фон", 
  "Зеленый фон", 
  "Желтый фон", 
  "Назад"
};

color bg = color( 0, 0, 0 );

boolean continue_ = false;

int ac = 0;
int menu = 0;
int xt = width/2;

void menu() {

  /*void reset() {
   background( 0 );
   countChars = 0;
   xt = width/2;
   }*/

  if ( menu != 2 ) {
    drawName( NOTG );
    textSize( 32 );
    float H = textAscent() + textDescent();
    float h = H*.5;
    textAlign(CENTER, CENTER);
    if ( menu == 0 ) {
      float beg_text = ( height - ( ( items.length*H ) + ( (items.length-1)*h) ) ) / 2;

      for ( int i = 0; i < items.length; i++ ) {
        fill( 255 );
        if ( ac == i ) fill( 255, 0, 0 );
        text ( items[i], width/2, beg_text + ( H+h ) * i );
        //fill( 0 );
      }
    } else {
      float beg_text = ( height - ( ( Settings.length*H ) + ( (Settings.length-1)*h) ) ) / 2;

      for ( int i = 0; i < Settings.length; i++ ) {
        fill( 255 );
        if ( ac == i ) fill( 255, 0, 0 );
        text ( Settings[i], width/2, beg_text + ( H+h ) * i );
      }
    }
  }
}


void controlMenu() {
  switch ( key ) {
  case ENTER:
    if ( ac == 0 ) {
      if ( menu == 0 ) {
        menu = 2;
        continue_ = true;
        //x = width/2;
        //y = height/2; 
        break;
      } else if ( menu == 1 ) {
        bg = color( 220 );
        //println( bg );
        break;
      }
    }
    if ( ac == 1 ) {
      if ( menu == 0 ) {
        menu = 1;
        break;
      } else if ( menu == 1 ) {
        bg = color( 0 );
        //println( bg );
        break;
      }
      //text( "Настройки в разработке.", x, height - height/2/2 );
    }
    if ( ac == 2 ) {
      if ( menu == 0 ) {
        exit();
      } else if ( menu == 1 ) {
        bg = color( 0, 220, 0 );
        break;
      }
    }
    if ( ac == 3 ) {
      bg = color( 200, 200, 0 );
    }
    if ( ac == 4 ) {
      menu = 0;
      ac = 1;
      break;
    }

    //println( ac, isMenu );
    break;
  case CODED:
    switch( keyCode ) {
    case DOWN:
      //if( ac != items.length - 1 ) 
      ac++;
      break;
    case UP:
      //if( ac != 0 ) 
      ac--;
      break;
    }
    break;
  }

  if ( menu == 0 ) {
    if ( ac < 0 ) ac += items.length;
    ac = ac % items.length;
  } else if ( menu == 1 ) {
    if ( ac < 0 ) ac += Settings.length;
    ac = ac % Settings.length;
  }

  if ( continue_ ) {
    items[0] = "Продолжить";
  }
  //println( ac );
}






void drawName( String n ) {
  textSize( 70 );
  //println( countCycles, countCycles2, countChars );
  fill( 255, 255, 0 );
  //if ( countCycles % 40 == 0 && countCycles2 < 40 ) {
  text( n, width/2, height/2/2/2 );
}