playerShip player;
BulletParent[] bP;
ArrayList<Float> scoreTable; //This and nameTable are used for high scores
ArrayList<String> nameTable;
float lastScore;
Stage1 stage;
int gameState, menuSelect, menuMax, scorePos;
String[] menuOptions;
String name; //name of our player
boolean gameOver;
PrintWriter highSave;
BufferedReader highLoad;

void setup(){
   size(400,500);
   background(0); 
   frameRate(60);
   gameState = 0;
   String[] toMenu = { "to Start", "to view High Scores", "to Quit" };
   menuSelect = 0;
   menuMax = toMenu.length-1;
   menuOptions = toMenu;
   scoreTable = loadScores();
   name = "";
   scorePos = -1;
}

  ArrayList<Float> loadScores(){
    ArrayList<Float> tempScores = new ArrayList<Float>();
    ArrayList<String> tempNames = new ArrayList<String>();
    
    
    try{
      highLoad = createReader("highscores.txt");
      String line = highLoad.readLine();
      String name = highLoad.readLine();
      while(line != null){
        tempScores.add(Float.valueOf(line));
        tempNames.add(name);
        line = highLoad.readLine();
        name = highLoad.readLine();
      }
    } catch (Exception e){
       //end of line or the file doesn't exist. Whatever it is, we make a new file
       createWriter("highscores.txt");
    }
    
    nameTable = tempNames;
    return tempScores;
  }

  int checkScores(){ //Checks to see if the last score recorded is higher than any of the current scores

    for(float score : scoreTable){
       if(lastScore > score){
          return scoreTable.indexOf(score);
       }
    }
    
    if(scoreTable.size() < 10){
         return scoreTable.size()-1;
      }
    return -1;
  }
  
  void addScore(int place){
      nameTable.add(place,name);
      scoreTable.add(place,lastScore); //adds it where score was
      if(scoreTable.size() > 10){
          nameTable.remove(nameTable.size()-1);
          scoreTable.remove(scoreTable.size()-1); //Removes the last one
      } 
  }
  
  void getPlayerName(){
      if(keyCode == ENTER){
          addScore(scorePos);
          saveScores();
         reset();  
      } else if(key == BACKSPACE){
          if(name.length() != 0) name = name.substring(0,name.length()-1);
      } else if(key != CODED){
         name = name + key;
      }
  }
  
  void saveScores(){ //Save scores to the highscore files
    highSave = createWriter("highscores.txt");
    for(int i = 0; i < scoreTable.size(); i++){
       highSave.println(scoreTable.get(i)); //we save each score
       highSave.println(nameTable.get(i)); //we then save the name
    }
    highSave.flush();
    highSave.close();
  }

void draw(){
   clear();
   background(0); 
   
   if(gameState == 1){ //Main game
     player.gameLogic();
     player.draw();
     stage.logic();
     stage.draw();
     if(player.gameOver){
       lastScore = player.returnScore(); //We need to store the score
       scorePos = checkScores();
       if(scorePos != -1){
          gameState = 3; 
       } else {
         reset();  
       }
     }
   } else if(gameState == 0){ //Main menu
      fill(0);
      
      //For the menu
      int menuTop = menuSelect + 1;
      int menuBottom = menuSelect - 1;
      if(menuTop > menuMax) menuTop = 0;
      else if(menuTop < 0) menuTop = menuMax;
      
      if(menuBottom > menuMax) menuBottom = 0;
      else if(menuBottom < 0) menuBottom = menuMax;
      
      pushMatrix();
      fill(255,255,255);
        textSize(24);
        textAlign(CENTER);
        text("Bulletless Hell",width*.5,height*.25); 
        textSize(12);
        text("Press Enter " + menuOptions[menuSelect],width*.5,height*.75);
        textSize(10);
        text(menuOptions[menuTop],width*.58,height*.71);
        text(menuOptions[menuBottom],width*.58,height*.79);
      popMatrix();
   } else if(gameState == 2){ //High Score table
      //we display the high score table 
      pushMatrix();
      fill(255,255,255);
      textSize(14);
      textAlign(CENTER);
      text("High Scores",width*.5,20);
      textSize(10);
      text("Press Enter to go back to menu.",width*.5,height*.98);
      if(scoreTable.size() != 0){
      for(int i = 0; i < scoreTable.size(); i++){
         text(nameTable.get(i) + " - " + scoreTable.get(i),width*.5,(20+((height-20)*(.05 + (float) i/10)))); 
      }
      }
      popMatrix();
   } else if(gameState == 3){
      //We're here to get the player's name - so we try to get it.
      pushMatrix();
        textAlign(CENTER);
        textSize(12);
        fill(255,255,255);
        text("Please enter your name: " + name, width*.5,height*.5);
      popMatrix();
      

   }
}

void menuLogic(){
           switch(menuSelect){
              case(0):  gameStart(); break;
              case(1): loadScores(); gameState = 2;  break; //check high scores - load them in etc.
              case(2): exit(); break;
           }
}

void gameStart(){
    player = new playerShip();
   player.setup();
   stage = new Stage1(player);
   player.stage = stage;
   gameState = 1; 
}

void reset(){
   stage = null;
   gameState = 0; 
}

void keyPressed(){
    if(gameState == 1) player.keyPressed();
}

void keyReleased(){
   if(gameState == 1) { player.keyReleased(); 
   } else if(gameState == 3){getPlayerName();} 
   else if(gameState == 2){
      if(keyCode == ENTER){
         gameState = 0; 
      }
   }
   else {
     if(keyCode == ENTER) menuLogic();
     
     if(key == CODED){
         if(keyCode == UP) menuSelect++; 
         else if(keyCode == DOWN) menuSelect--;
         if(menuSelect > menuMax) menuSelect = 0;
        else if(menuSelect < 0) menuSelect = menuMax;
      } 
   }
}
