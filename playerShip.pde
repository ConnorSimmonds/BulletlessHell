class playerShip {
  float x, y, xAcceleration, yAcceleration, xMax, yMax, accelTick, yBase, collisY, scoreMult, score, colourValue;
  int imageWid, imageHig, collisWid, collisHig, lives, graphicDraw, graphicTime, invulnTime, currentCredits, scoreThreshold, cutsceneTime, thrusterIndex, thrusterDraw;
  boolean gameOver, stoppedMoving, invuln, cutscene;
  PImage shipImage, thrusterEffect;
  Stage1 stage;

  void setup(){
   //Movement Variables
   x = width/2;
   yBase = height - 40;
   y = height + 40;
   xMax = 3;
   yMax = 10;
   accelTick = 2;
   
   //Graphical Variables
   imageWid = 17;
   imageHig = 28;
   collisWid = 5;
   collisHig = 5;
   collisY = y + imageHig/2; //<>//
   graphicDraw = 0;
   graphicTime = 0;
   colourValue = 0;
   shipImage = loadImage("sprites/spr_ship.png");
   thrusterEffect = loadImage("sprites/spr_thrusterEffect0000.png");
   
   
   //Gameplay Variables
   lives = 3;
   score = 0;
   invulnTime = 0;
   tint(255,255);
   scoreMult = 1; //scoreMultiplier increases as you stay alive for longer and longer
   scoreThreshold = 1000; //Threshold you must reach to get an extra life.
   currentCredits = 3; //How many credits you have (resets you to previous pattern/checkpoint with no points)
  }
  
  PImage thrusterAnimation(){
     PImage thrust = thrusterEffect;
     thrusterDraw++;
     if(thrusterDraw >= 3){
         thrust = loadImage("sprites/spr_thrusterEffect000" + thrusterIndex + ".png");
         thrusterIndex++;
         
         if(thrusterIndex > 8) thrusterIndex = 0;
         thrusterDraw = 0;
     }
     
     
     return thrust;
  }

  void draw(){
   if(invuln){
     colourValue = 255*((float)(250-invulnTime)/250);
     tint(255,255-colourValue);
   }
   image(shipImage,x-imageWid/2,y);
   thrusterEffect = thrusterAnimation();
   image(thrusterEffect,x-imageWid*.34,y+22);
   
   
   //Text
   fill(255,255,255);
   
   textSize(12);
   textAlign(LEFT);
   text("Lives: " + lives,width*.1,20);
   text("Score: " + (int) score + " - " + scoreMult,width*.65,20);
   
   //Extra Graphics
   switch(graphicDraw){
     case(0): graphicTime = 0; break;
      case(1): { //This is the score multiplier  
        graphicTime++;
        pushMatrix();
          fill(255,255,255,255/(graphicTime*.05));
          textAlign(CENTER);
          //shearX(PI/2.0);
          text("Multiplier Increase!",x,y-(graphicTime*.25));
        popMatrix();
        if(graphicTime > 125) graphicDraw = 0;
      } break;
      
      case(2): { //Score Multipier Level Down
        graphicTime++;
        pushMatrix();
          fill(255,255,255,255/(graphicTime*.05));
          textAlign(CENTER);
          //shearX(PI/2.0);
          text("Multiplier Reset!",x,y+(graphicTime*.25));
        popMatrix();
        if(graphicTime > 125) graphicDraw = 0;
      } break;
   }
  }

  void gameLogic(){
    if(!cutscene){
          if(lives <= 0){
        gameOver = true;
    }
      
    score += scoreMult * 1;
    
    if(score/scoreThreshold >= 1){
       lives++;
       scoreThreshold = scoreThreshold * 2;
    }
    
    if(invuln == true){
       invulnTime++;
       
       if(invulnTime > 250){
         invuln = false;
         invulnTime = 0;
       }
    }
    if(x < imageWid/2) {
      xAcceleration = 0;
      x = x + 1;
    } else if(x + imageWid/2 > width) {
      xAcceleration = 0;
      x = x - 1;
    }
    x = x + xAcceleration;
    y = y + yAcceleration;
    
    if(y != yBase){
      collisY = y + imageHig/2;
      if(y < yBase){
          if(yAcceleration > 0) {
            yAcceleration = yAcceleration + (accelTick * .25); 
            if(yAcceleration > xMax) yAcceleration = xMax;
          }
          else yAcceleration = yAcceleration + (accelTick * .5); 
      } else if(y > yBase){
          y = yBase;
          yAcceleration = 0;
      }
    }
    
    if(stoppedMoving){
      if(xAcceleration != 0){
         if(abs(xAcceleration) < 0.001) xAcceleration = 0;
         xAcceleration = xAcceleration * (0.8);
      }  
    }
    }
  }
  
  boolean hasCollided(Bullet b){ //Checks if you've outright collided with an object (bullet)
    //We do collision checks.
    return (b.x == x);
  }
  
  public void increaseMult(){
     scoreMult = scoreMult + 0.5; 
     graphicDraw = 1;
  }
  
  public void die(){
     lives--;
     graphicDraw = 2;
     scoreMult = 1;
     invuln = true;
  }
  
  public void enter(){
     cutscene = true; //Gotta make sure we're in the cutscene :ok_hand:
     cutsceneTime++; //We want to increment our cutscene thing
     
     y = (yBase-16) + (pow(((cutsceneTime * .35 - 10)),2)); //This is a parabola, we wanna go UP out of this game world
     
     if(cutsceneTime >= 25){
        //We exit out 
        cutscene = false;
     }
  }
  
  public void win(){
     //We've won - so play out the win sequence
     cutscene = true; //Gotta make sure we're in the cutscene :ok_hand:
     cutsceneTime++; //We want to increment our cutscene thing
     
     y = (yBase+16) + (-pow(((cutsceneTime * .35 - 4)),2)); //This is a parabola, we wanna go UP out of this game world
     
     if(cutsceneTime >= 100){
        //We exit out 
        gameOver = true;
     }
     
  }
  
  public float returnScore(){ return score; }

  void keyPressed(){
    if(!cutscene){
    //Horizontal Movement
    if(keyCode == LEFT){
        stoppedMoving = false;
        if(xAcceleration > 0) xAcceleration = -xAcceleration;
        xAcceleration = (xAcceleration - accelTick);
    } else if(keyCode == RIGHT){
      stoppedMoving = false;
      if(xAcceleration < 0) xAcceleration = -xAcceleration;
        xAcceleration = (xAcceleration + accelTick); 
    }
    
    
    if(keyCode == SHIFT) xMax = .75;
    
    if(abs(xAcceleration) > xMax){
         if(xAcceleration > 0) xAcceleration = xMax;
         else xAcceleration = -xMax;
    }
    }
  }
  
  void keyReleased(){
    if(!cutscene){
   if(keyCode == 32){ //If space is pressed
        if(y == yBase){ //If we haven't jumped already
            yAcceleration -= 12;
        }
    } 
    
  if(keyCode == SHIFT) xMax = 2;
  if(keyCode == LEFT || keyCode == RIGHT) stoppedMoving = true;
  }
  }
}
