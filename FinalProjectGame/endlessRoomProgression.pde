/*
resets variables for going to the next room
*/

void resetNextRoom() {
  if ((powerActive && roomsPassed % 2 == 0)) {
    pBoost.reset();
  }
  if (roomsPassed < 10) {
    if (roomsPassed % 3 == 0) {
      pBoost = new Powerups();
      powerAvail = true;
    }
  } else {
    if (roomsPassed % 2 == 0) {
      pBoost = new Powerups();
      powerAvail = true;
    }
  }

  roomScore = 0;
  //new room, borders close again with blocks and background changes
  mapRoom = backgroundImage[int(random(backgroundFrames))];
  if (roomsPassed > 10 && roomsPassed % 2 != 0) {
    blocks = new blockBounds[6];
    blocks[0] = new blockBounds(-32, 0, 64, 500);
    blocks[1] = new blockBounds(468, 0, 64, 500);
    blocks[2] = new blockBounds(32, -32, 500, 64);
    blocks[3] = new blockBounds(32, 468, 500, 64);
    //Interior walls
    blocks[4] = new blockBounds(150, 170, 32, 170);
    blocks[5] = new blockBounds(350, 170, 32, 170);
  } else {
    blocks = new blockBounds[4];
    blocks[0] = new blockBounds(-32, 0, 64, 500);
    blocks[1] = new blockBounds(468, 0, 64, 500);
    blocks[2] = new blockBounds(32, -32, 500, 64);
    blocks[3] = new blockBounds(32, 468, 500, 64);
  }

  for (int i = 0; i < enemies.length; i++) {
    enemies[i].reset();
  }
}


void roomCleared() {
  if (roomsPassed > 10 && roomsPassed % 2 != 0) {
    blocks = new blockBounds[7];
    blocks[0] = new blockBounds(-32, 0, 64, 500);
    blocks[1] = new blockBounds(468, 0, 64, 250);
    blocks[2] = new blockBounds(468, 300, 64, 200);
    //creating gap for player to pass
    blocks[3] = new blockBounds(32, -32, 500, 64);
    blocks[4] = new blockBounds(32, 468, 500, 64);
    //Interior walls
    blocks[5] = new blockBounds(150, 170, 32, 170);
    blocks[6] = new blockBounds(350, 170, 32, 170);
  } else {
    blocks = new blockBounds[5];
    blocks[0] = new blockBounds(-32, 0, 64, 500);
    blocks[1] = new blockBounds(468, 0, 64, 250);
    //creating gap for player to pass
    blocks[2] = new blockBounds(468, 300, 64, 200);
    blocks[3] = new blockBounds(32, -32, 500, 64);
    blocks[4] = new blockBounds(32, 468, 500, 64);
  }
}
