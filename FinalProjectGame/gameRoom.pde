void gameRoom() { //<>// //<>//
  // local variables controlling the screen effect
  int r = 255;
  int g = 0;
  int b = 0;

  image(mapRoom, 0, 0);
  if (powerAvail) { //if powerup is in the level, display and process it
    pBoost.display();
    pBoost.runPowerup();
  }
  //shooting mechanics
  if (space) {
    if (bulletTimerObj.bulletFired()) {
      bullets[nextBullet].fire(player.x+player.w/2, player.y+player.h/2, player.facing);
      nextBullet = (nextBullet+1)%bullets.length; // bullet animation;
      bulletTimerObj.start(); //bullet interval or fire rate of player shooting
    }
  }

  for (int i = 0; i<bullets.length; i++) { //for each bullet fired
    bullets[i].move(); //bullet travels
    for (int j = 0; j < enemies.length; j++) {
      if ( bulletHitsEnemy(bullets[i], enemies[j]) && !enemies[j].dead) { //bullet hits enemy and enemy dies
        bullets[i].reset();
        enemies[j].destroy(); //enemy dies
        score++;
        roomScore++;
        if (roomScore == enemies.length) {
          roomCleared();
        }
      }
    }

    //when bullet hits blocks
    for (int k = 0; k<blocks.length; k++) {
      if (bulletHitsBlock(bullets[i], blocks[k])) {
        bullets[i].reset();
      }
    }
    bullets[i].display();
  }

  player.move();
  for (int j = 0; j<blocks.length; j++) { //when player hits blocks
    blocks[j].display();
    playerBlockCollision(player, blocks[j]);
  }
  if (player.x > width) { //go to next level
    nextRoomMusic.jump(0.15);
    player.x = 0;
    roomsPassed++;
    resetNextRoom();
  }
  player.display();
  for (int i = 0; i<enemies.length; i++) { //controls enemies targetting player
    if (!enemies[i].dead) {
      enemies[i].target(player.x, player.y);// enemy targets player
      enemies[i].move(); //enemy moves
      for (int k = 0; k<blocks.length; k++) { //enemy collision with blocks
        enemyBlockCollision(enemies[i], blocks[k]);
      }
      enemies[i].display();
      if (playerHitsEnemy(player, enemies[i]) && !enemies[i].dead) { //player hits enemy and health decreases and screen colour flashes for effect
        //Powerup damage effects
        if (powerActive && (pBoost.getPowerNumber() != 1 || pBoost.getPowerNumber() != 4)) { //colour flash for enemy collision
          if (pBoost.getPowerNumber() == 3) {
            r = 0;
            g = 0;
            b = 255;
          } else if (pBoost.getPowerNumber() == 2) {
            r = 9;
            g = 121;
            b = 105;
          }
        } else { //normal damage effects
          r = 255;
          g = 0;
          b = 0;
        }
        fill(r, g, b, 50);
        rect(0, 0, width, height);
        healthPoints -= (5 % armourMod);
        if (healthPoints <=0) {
          roomMusic.stop();
          playerDiedMusic.play();
          gameState = "LOSE";
        }
      }
    }
  }

  //HUD
  noStroke();
  fill(255);
  rect(64, 8, 100, 16);
  fill(255, 75, 243);
  rect(64, 8, healthPoints/10, 16);
  fill(0);
  text("Score :" + score, 400, 28);
  if (powerActive) {
    pBoost.showHud();
  }
}
