void writeToScreen() { //processing user input writing to screen
  if (!inputName) {
    if (key == '\n') {
      name = type;
      type = "";
      inputName = true;
    } else {
      type = type + key;
    }
  }
}

void loadScores() { //load scores from tsv file (tab separeted)
  int [] scoreSaved1 = append(scoreSaved, score); //save scores to a temp array
  scoreSaved = append(scoreSaved, score); //saves score to a global array
  scoreSaved1 = sort(scoreSaved1);
  File file = new File(sketchPath("Score.tsv"));
  if (file.exists()) {
    BufferedReader reader = createReader("Score.tsv");
    String line;
    do {
      try {
        line = reader.readLine();
      }
      catch(IOException e) {
        e.printStackTrace();
        line = null;
      }
      if (line != null) {
        String[] parts = split(line, "\t");
        names = append(names, parts[0]);
        scores = append(scores, int(parts[1]));
      }
    } while (line!=null);
    try {
      reader.close();
    }
    catch(IOException e) {
      e.printStackTrace();
      reader = null;
    }
  }
}

void writeToFile() { //writes with tab separted and saves it to the file
  scores = append(scores, score);
  names = append(names, name);
  PrintWriter output = createWriter("Score.tsv");
  for (int i = 0; i < scores.length; i++) {
    output.println(names[i] + "\t" + scores[i]);
  }
  output.flush();
  output.close();
}

void highestScores() {
  String[] namesTemp = new String[0]; //make temporary array to not mess up the original array
  int[] scoresTemp = new int[0];
  for (int i = 0; i < scores.length; i++) { //copy everything to the new array
    scoresTemp = append(scoresTemp, scores[i]);
    namesTemp = append(namesTemp, names[i]);
  }
  for (int i = 0; i < 5; i++) { //gets the max 5 values and puts it in the highestScores array
    int maxIndex = 0;
    for (int j = 1; j<scoresTemp.length; j++) {
      if (scoresTemp[j] > scoresTemp[maxIndex] && scoresTemp[j] != -1) {
        maxIndex = j;
      }
    }
    if (scoresTemp[maxIndex] != -1) {
      highestScores = append(highestScores, namesTemp[maxIndex] + "        " + scoresTemp[maxIndex]);
      scoresTemp[maxIndex] = -1;
      namesTemp[maxIndex] = "";
    }
  }
}

void displayHighestScores() { //displays high scores in the end screen
  int offset = 50;
  text("High scores", 250, 100 + offset);
  text("===================", 250, 100+ offset*1.5);
  text("Rank     " + "   Name   " + "  Score", 250, 100 + offset*2);
  for (int i = 0; i < highestScores.length; i++) {
    text(i+1, 163, 100 + (i+3) * offset);
    text(highestScores[i], 295, 100 + (i+3) * offset);
  }
}
