/* //<>//
Player class creates 1 player object that the user controls
 */

class Player {
  String facing; //which way the character is facing
  float xSpeed, ySpeed, maxSpeed, x, y, w, h;
  int offset, delay, currFrame, loopFrames;

  Player() { //initialize everything in constructor
    x = width/2;
    y = height/2;
    w = 20;
    h = 30;
    xSpeed = 0;
    ySpeed = 0;
    maxSpeed = 5;
    currFrame = 0;
    loopFrames = 2; //2 frames per facing direction for animation
    offset = 0;
    delay = 0;
    facing = "up";
  }

  void display() {
    image(playerImage[currFrame + offset], x, y);
  }

  void move() {
    //vertical movement
    if (up) {
      //xSpeed = 0;
      ySpeed = -maxSpeed;
      offset = 0; //picture to choose from images folder
      facing = "up";
    }
    if (down) {
      ySpeed = maxSpeed;
      offset = 2;
      facing = "down";
    }
    if ((!up && !down) || (up && down)) {
      ySpeed = 0;
    }
    //horizontal movement
    if (left) {
      xSpeed = -maxSpeed;
      offset = 4;
      facing = "left";
    }
    if (right) {
      xSpeed = maxSpeed;
      offset = 6;
      facing = "right";
    }
    if ((!left && !right) || (left && right)) {
      xSpeed = 0;
    }
    if (!up && !down && !right && !left) {
      currFrame = 1;
    } else {
      if (delay == 0) { //animating through images
        currFrame = (currFrame +1) % loopFrames;
      }
      delay = (delay + 1) % 1;
    }

    checkCollisionWithWall(); //if collides with wall

    //update position
    PVector vector = new PVector();
    vector.x = xSpeed;
    vector.y = ySpeed;

    vector.normalize().mult(maxSpeed);
    x += vector.x;
    y += vector.y;
  }//end movement method
  
  void checkCollisionWithWall() {
    if (x > width) {
      x = -w;
    }
    if (x < -w) {
      x = width;
    }
    if (y > height) {
      y = -h;
    }
    if (y < -h) {
      y = height;
    }
  }

  void setMaxSpeed(int speed) { //change max speed if powerup is used
    maxSpeed = speed;
  }
}
