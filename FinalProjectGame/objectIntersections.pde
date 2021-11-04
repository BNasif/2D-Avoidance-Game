/*
all boolean methods check if the following objects intersects each others and is used in the main gameRoom() method
*/

boolean playerHitsEnemy(Player p1, Enemy e1) {
  float distX = abs((p1.x+p1.w/2)-(e1.x+e1.w/2));
  float distY = abs((p1.y+p1.h/2)-(e1.y+e1.h/2));
  float combinedHalfWidths = p1.w/2+e1.w/2;
  float combinedHalfHeights = p1.h/2+e1.h/2;

  //check for x-axis intersection
  if (distX < combinedHalfWidths) {
    //check on y-axis
    if (distY < combinedHalfHeights) {
      return true;
    }
  }

  return false;
}

boolean bulletHitsEnemy(Bullet b1, Enemy e1) {
  float distX = abs((b1.x+b1.w/2)-(e1.x+e1.w/2));
  float distY = abs((b1.y+b1.h/2)-(e1.y+e1.h/2));
  float combinedHalfWidths = b1.w/2+e1.w/2;
  float combinedHalfHeights = b1.h/2+e1.h/2;

  //check for x-axis intersection
  if (distX < combinedHalfWidths) {
    //check on y-axis
    if (distY < combinedHalfHeights) {
      return true;
    }
  }
  return false;
}

boolean bulletHitsBlock(Bullet b1, blockBounds b2) {
  float distX = abs((b1.x+b1.w/2)-(b2.x+b2.w/2));
  float distY = abs((b1.y+b1.h/2)-(b2.y+b2.h/2));
  float combinedHalfWidths = b1.w/2+b2.w/2;
  float combinedHalfHeights = b1.h/2+b2.h/2;

  //check for x-axis intersection
  if (distX < combinedHalfWidths) {
    //check on y-axis
    if (distY < combinedHalfHeights) {
      return true;
    }
  }

  return false;
}
