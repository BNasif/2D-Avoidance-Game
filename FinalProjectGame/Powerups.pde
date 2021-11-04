/*
Powerup class creates powerup object
*/

class Powerups {
  float x, y, w, h;
  int powerNumber;
  PImage powerUpImage;

  Powerups() {
    x = random(100, 400);
    y = random(100, 400);
    w = 15;
    h = 15;
    if (healthPoints < 200) {
      powerNumber = 0;
    } else {
      powerNumber = int(random(5));
      while (lastPowerUpNumber == powerNumber) {
        powerNumber = int(random(5));
      }
    }
    lastPowerUpNumber = powerNumber;
    powerUpImage = powerUpImages[powerNumber];
  }

  //displays powerup in the levels
  void display() {
    image(powerUpImage, x, y);
  }
  PImage hudResizeImage (PImage Image) {
    PImage tempImage = Image.get();
    tempImage.resize(25, 25);
    return tempImage;
  }
  //HUD includes the active powerup that the player has obtained
  void showHud() {
    image(hudResizeImage(powerUpImage), 275, 5);
  }
  
  /*
  processes each powerup and changes variables accordingly
  */


  void runPowerup() {
    if (gotItem(player)) {
      if (powerNumber == 0) { //health boost
        healthTaken.play();
        setHealthPoints(500);
      }
      if (powerNumber == 1) { //speed boost
        powerUpTaken.play();
        player.setMaxSpeed(8);
      }
      if (powerNumber == 2) { //armour
        powerUpTaken.play();
        setArmourBoost(3);
      }
      if (powerNumber == 3) { //god mode
        powerUpTaken.play();
        setArmourBoost(1);
      }
      if (powerNumber == 4) { //faster Bullets
        powerUpTaken.play();
        bulletTimerObj.setBulletTimer(200);
      }
    }
  }


  //user player has obtained the powerup placed in the level
  boolean gotItem(Player p1) {
    float distX = abs((p1.x+p1.w/2)-(x+w/2));
    float distY = abs((p1.y+p1.h/2)-(y+h/2));
    float combinedHalfWidths = p1.w/2+w/2;
    float combinedHalfHeights = p1.h/2+h/2;
    //check for x-axis intersection
    if (distX < combinedHalfWidths) {
      //check on y-axis
      if (distY < combinedHalfHeights) {
        x = 0;
        y = 0;
        if (powerNumber == 0) {
          powerActive = false;
        } else { 
          powerActive = true;
        }
        powerAvail = false;
        return true;
      }
    }
    return false;
  }
  
  //resets powerup
  void reset() {
    powerActive = false;
    bulletTimerObj.setBulletTimer(500);
    player.setMaxSpeed(5);
    setArmourBoost(10);
  }
  
  int getPowerNumber() {
    return powerNumber;
  }
}
