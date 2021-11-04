void begin() { //Title screen //<>//

  background(11, 106, 164, 255);
  fill(255);
  textAlign(CENTER);
  String text = "Welcome to the spooky fighter\nPlease enter your name\nHit enter to start";
  text(text, 250, 50);
  text("Name: " + type, 250, 200);
  if (inputName) {
    titleMusic.stop();
    roomMusic.loop(1, 0.5);
    gameState = "PLAY";
  }
}

void loseGame() { //lose Screen
  background(254, 1, 6, 1);
  fill(255);
  textAlign(CENTER);
  String text = "You have lost, better luck next time\nYour Score is: " + score + "\nPress Spacebar to play again";
  text(text, 250, 35);
  if (!scoresShown) {
    loadScores();
    writeToFile();
    highestScores();
    scoresShown = true;
  }
  displayHighestScores();
  if (keyPressed && key == ' ') {
    roomMusic.loop(1, 0.5);
    reset();
  }
}
