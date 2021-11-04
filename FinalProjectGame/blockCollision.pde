/*
Controls overlapping of player and enemies inside blocks if blockCollision occurs
*/

void playerBlockCollision(Player p1, blockBounds b1) {
  //x distance
  float distX = ((p1.x+p1.w/2)-(b1.x+b1.w/2));
  //y distance
  float distY = ((p1.y+p1.h/2) - (b1.y+b1.h/2));
  //combined half width
  float combinedHalfWidth = p1.w/2+b1.w/2;
  //combined half height
  float combinedHalfHeight = p1.h/2+b1.h/2;

  //if x axis intersects
  if (abs(distX) < combinedHalfWidth) {
    //if y axis intersects
    if (abs(distY) < combinedHalfHeight) {

      //fix error on overlapping of intersection

      float overlapX = combinedHalfWidth - abs(distX);
      float overlapY = combinedHalfHeight - abs(distY);
      if (overlapX >= overlapY) {

        if (distY>0) {
          //top part of player is inside the box
          p1.y += overlapY;
        } else {
          //Bottom part of player is inside block
          p1.y -= overlapY;
        }
      } else {
        if (distX>0) {
          //left part of player is inside block
          p1.x += overlapX;
        } else {
          //right part of player is inside block
          p1.x -= overlapX;
        }
      }
    }
  }
}

void enemyBlockCollision(Enemy p1, blockBounds b1) {
  //x distance
  float distX = ((p1.x+p1.w/2)-(b1.x+b1.w/2));
  //y distance
  float distY = ((p1.y+p1.h/2) - (b1.y+b1.h/2));
  //combined half width
  float combinedHalfWidth = p1.w/2+b1.w/2;
  //combined half height
  float combinedHalfHeight = p1.h/2+b1.h/2;

  //if x axis intersects
  if (abs(distX) < combinedHalfWidth) {
    //if y axis intersects
    if (abs(distY) < combinedHalfHeight) {

      //fix error on overlapping of intersection

      float overlapX = combinedHalfWidth - abs(distX);
      float overlapY = combinedHalfHeight - abs(distY);
      if (overlapX >= overlapY) {

        if (distY>0) {
          //top part of enemy is inside the box
          p1.y += overlapY;
        } else {
          //Bottom part of enemy is inside block
          p1.y -= overlapY;
        }
      } else {
        if (distX>0) {
          //left part of enemy is inside block
          p1.x += overlapX;
        } else {
          //right part of enemy is inside block
          p1.x -= overlapX;
        }
      }
    }
  }
}
