/*
Enemey class makes enemy objects
 */

class Enemy {
  float x, y, w, h, vX, vY, speed;
  int currFrame, loopFrames, offset, delay, difficulty;
  int  time = 0;
  boolean dead, dying;

  Enemy() {
    x = random(width - 200) + 100;
    y = random(height- 200) + 100;
    w = 32;
    h = 32;
    vX = 0;
    vY = 0;
    speed = random(1, 2);
    currFrame = 0;
    loopFrames = 2; //looping frames for animation
    offset = 0; //facing frame
    delay = 0;
    dead = false;
  }
  void move() { //enemy moving is updated
    x += vX;
    y += vY;
  }
  void reset() {
    x = random(width-200) + 100;
    y = random(width-200) + 100;
    dead = false;
    speed += .05;//enemy speed increases as player progresses through each room
  }
  void destroy() { //enemy is killed
    for (int i = 0; i < 5; i++) {
      image(enemyImage[6 + i], x, y);
    }
    vX = 0;
    vY = 0;
    x = 0;
    monsterDeathSounds[int(random(10))].jump(0.1);
    dead = true;
  }

  void display() { //enemy moving is displayed
    image(enemyImage[currFrame + offset], x, y);
  }

  /*
  Enemy targetting processed
  */

  void target(float playerX, float playerY) {
    if (dist(x, y, playerX, playerY) > 300) {
      vX = 0;
      vY = 0;
      currFrame = 1;
      currFrame = (currFrame + 1) % loopFrames;
      return;
    } //enemy on standby, no targetting
    //start target
    if (delay == 0) {
      currFrame = (currFrame + 1) % loopFrames; //enemy targetting animation
    }
    delay = (delay + 1) % 1;
    int newTime = millis();
    if (newTime > time) {
      time = newTime + 600;
      //change direction to target
      if (abs(x - playerX) < abs(y - playerY)) {
        //if player is close vertically
        if (y < playerY) { //enemy target moves up
          vY = speed;
          vX = 0;
          offset = 2;
        } else {
          vY = -speed;
          vX = 0;
          offset = 2;
        }
      } else { //player is close horizontally
        if (x < playerX) {
          vX = speed;
          vY = 0;
          offset = 3;
        } else {
          vX = -speed;
          vY = 0;
          offset = 5;
        }
      }
    }
  }
}
