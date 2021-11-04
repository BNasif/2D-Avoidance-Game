/*
Bullet class
 
 */

class Bullet {
  float x, y, w, h, vx, vy, startingX, startingY;
  float speed;
  boolean fired;

  Bullet(float sx, float sy) {
    startingX = sx;
    startingY = sy;
    x = sx;
    y = sy;
    w = 5;
    h = 5;
    vx = 0;
    vy = 0;
    fired = false;
    speed = 10;
  }
  
  /*
  Bullet travelling through the screen
  */

  void move() {
    x += vx;
    y += vy;
    checkCollisionWithWall();
  }
  
  /*
  Bullet projectile shown travelling through the screen
  */

  void display() {
    fill(255, 0, 0);
    rect(x, y, w, h);
  }
  
  /*
  Bullet firing processed in this method
  travelling speed and direction
  */
  
  void fire(float tempX, float tempY, String facing) {
    bulletSound.play();
    x = tempX;
    y = tempY;
    if (!fired) {
      if (facing == "left") {
        vx = -speed;
        vy = 0;
        w = 10;
        h = 5;
      }
      if (facing == "right") {
        vx = speed;
        vy = 0;
        w = 10;
        h = 5;
      }
      if (facing == "up") {
        vx = 0;
        vy = -speed;
        w = 5;
        h = 10;
      }
      if (facing == "down") {
        vx = 0;
        vy = speed;
        w = 5;
        h = 10;
      }
      fired = true;
    }
  }
  /*
  bullet is destroyed/resets after collision
  */

  void reset() {
    x = startingX;
    y = startingY;
    vx = 0;
    vy = 0;
    w = 10;
    h = 10;
    fired = false;
  }
  void checkCollisionWithWall() { //check if bullet is collided with a wall, if it is, then bullet will reset
    if (x < -w || x > width || y < -h || y > height) {
      reset();
    }
  }
}
