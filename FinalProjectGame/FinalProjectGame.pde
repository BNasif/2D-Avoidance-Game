/*

Nasif Hossain

nh6655@bard.edu

08/16/2021

Final Project: 2d Avoidance Game

*/

//Sounds
import processing.sound.*;
SoundFile[] monsterDeathSounds;
SoundFile titleMusic, roomMusic, nextRoomMusic, playerDiedMusic;
SoundFile bulletSound, healthTaken, powerUpTaken;

// sound variable
int numOfMonsterDeathSounds;
//player move
boolean up, down, left, right;
Player player; //create player

//shooting variables
boolean space;
Bullet [] bullets;
int nextBullet;
BulletTimer bulletTimerObj;

//character images
PImage playerImage [], enemyImage[];
int playerFrames, enemyFrames, backgroundFrames, numOfPowerups;

//powerUp variables
PImage powerUpImages[];
Powerups pBoost;
boolean powerAvail, powerActive;
int armourMod;
int lastPowerUpNumber;

//enemies
Enemy[] enemies;

//blocks
blockBounds [] blocks; //exterior

//room variables
PImage backgroundImage[], mapRoom;
int roomsPassed, roomScore, healthPoints, score;
String gameState;

//score saving and processing variables
boolean inputName, scoresShown;
int[] scores, scoreSaved;
String[] highestScores;
String name;
String[] names;
String type;

void setup() {
  size(500, 500);
  background(255);
  //frames
  playerFrames = 8;
  enemyFrames = 11;
  backgroundFrames = 7;
  numOfPowerups = 5;
  numOfMonsterDeathSounds = 10;
  //load all images neeeded
  playerImage = new PImage[playerFrames];
  for (int i = 0; i < playerFrames; i++) {
    playerImage[i] = loadImage("data/images/player/player"+nf(i, 2)+".png"); //up, down, left, right, 06 == standing left, 08 == standing right
  }

  enemyImage = new PImage[enemyFrames];
  for (int j = 0; j < enemyFrames; j++) {
    enemyImage[j] = loadImage("data/images/enemy/enemy"+nf(j, 2)+".png");
  }
  backgroundImage = new PImage[backgroundFrames];
  for (int k = 0; k < backgroundFrames; k++) {
    backgroundImage[k] = loadImage("data/images/background/backgroundLevel"+nf(k, 2)+".png");
  }
  powerUpImages = new PImage[numOfPowerups];
  for (int i = 0; i < numOfPowerups; i++) {
    powerUpImages[i] = loadImage("data/images/icons/icon"+nf(i, 2)+".png");
  }
  //load Sounds
  monsterDeathSounds = new SoundFile[numOfMonsterDeathSounds];
  for (int j = 0; j < numOfMonsterDeathSounds; j++) {
    monsterDeathSounds[j] = new SoundFile(this, "data/sounds/monsterSounds/monsterDeathSounds/monsterDeath"+nf(j, 2)+".wav");
  }

  titleMusic = new SoundFile(this, "data/sounds/roomMusic/titleMusic.wav");
  roomMusic = new SoundFile(this, "data/sounds/roomMusic/roomMusic.wav");
  playerDiedMusic = new SoundFile(this, "data/sounds/playerDiedMusic.wav");
  nextRoomMusic = new SoundFile(this, "data/sounds/nextRoomMusic.wav");
  bulletSound = new SoundFile(this, "data/sounds/bulletSounds/bullet.wav");
  healthTaken = new SoundFile(this, "data/sounds/powerUpMusic/healthTaken.aif");
  powerUpTaken = new SoundFile(this, "data/sounds/powerupMusic/powerUpTaken.wav");



  mapRoom = backgroundImage[int(random(backgroundFrames))]; //background level image
  //powerups
  armourMod = 10;
  powerAvail = false;
  powerActive = false;
  lastPowerUpNumber = 0;

  //create enemy objects
  enemies = new Enemy[5];
  for (int i = 0; i< enemies.length; i++) {
    enemies[i] = new Enemy();
  }

  //create Player
  player = new Player();

  //user Keyboard Controls
  up = false;
  down = false;
  left = false;
  right = false;
  space = false;

  //bullet variables
  bullets = new Bullet[3];
  for (int i = 0; i < bullets.length; i++) {
    bullets[i] = new Bullet(100+(i*20), 500);
  }
  nextBullet = 0;
  bulletTimerObj = new BulletTimer(500);
  bulletTimerObj.start();

  //exterior/boundary walls
  blocks = new blockBounds[4];
  //left wall
  blocks[0] = new blockBounds(-32, 0, 64, 500);
  //right wall
  blocks[1] = new blockBounds(468, 0, 64, 500);
  //top wall
  blocks[2] = new blockBounds(32, -32, 500, 64);
  //bottom wall
  blocks[3] = new blockBounds(32, 468, 500, 64);

  //score saving
  scoreSaved = new int[0];
  scores = new int[0];
  names = new String[0];
  PFont font;
  font = createFont("Arial", 12);
  textFont(font, 20);
  type = "";
  name = "";
  inputName = false;
  highestScores = new String[0];
  scoresShown = false;

  healthPoints = 1000;
  score = 0;
  roomsPassed = 1;
  roomScore = 0;
  gameState = "BEGIN";
  titleMusic.loop(1, 0.75);
}

void draw() {
  if (gameState == "BEGIN") {
    begin();
  } else if (gameState == "PLAY") {
    noCursor();
    gameRoom();
  } else if (gameState == "LOSE") {
    cursor();
    loseGame();
  } else { 
    print("ERROR PLEASE RESTART THE GAME");
  }
}

void keyPressed() {
  if (gameState == "BEGIN") { //user input name
    writeToScreen(); 
  } else {
    if (keyCode == UP) {
      up = true;
    } else if (keyCode == DOWN) {
      down = true;
    } else if (keyCode == LEFT) {
      left = true;
    } else if (keyCode == RIGHT) {
      right = true;
    } else if (key == ' ') {
      space = true;
    }
  }
}

void keyReleased() {
  if (keyCode == UP) {
    up = false;
  } else if (keyCode == DOWN) {
    down = false;
  } else if (keyCode == LEFT) {
    left = false;
  } else if (keyCode == RIGHT) {
    right = false;
  } else if (key == ' ') {
    space = false;
  }
}

void reset() { //reset all variables for next game
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].reset();
  }
  roomsPassed = 1;
  roomScore = 0;
  powerAvail = false;
  powerActive = false;
  score = 0;
  healthPoints = 1000;
  gameState = "PLAY";
  type = "";
  highestScores = new String[0];
  scores = new int[0];
  names = new String[0];
  scoresShown = false;
  bulletTimerObj.setBulletTimer(500);
  player.setMaxSpeed(5);
  setArmourBoost(10);
  resetNextRoom();
}
