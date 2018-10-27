class Bullet{
  float x, y, baseX, baseY, modX, modY;
  int imageX, imageY, timer, maxTim, secondPattern;
  boolean hasCollided, isLooping; //For basic checks so we stop drawing it
  color c = color(255,0,0);
  
  public Bullet(float iX, float iY, int imageX, int imageY){
    x = iX;
    y = iY;
    this.imageX = imageX;
    this.imageY = imageY;
    baseX = iX;
    baseY = iY;
  }
  
    public Bullet(float iX, float iY, int imageX, int imageY, float modX, float modY){
    x = iX;
    y = iY;
    this.imageX = imageX;
    this.imageY = imageY;
    this.modX = modX;
    this.modY = modY;
    baseX = iX;
    baseY = iY;
  }
  
  public Bullet(float iX, float iY, int imageX, int imageY, float modX, float modY, float baseX, float baseY){
    x = iX;
    y = iY;
    this.imageX = imageX;
    this.imageY = imageY;
    this.modX = modX;
    this.modY = modY;
    this.baseX = baseX;
    this.baseY = baseY;
  }
  
  public void setColor(int col){c = col;}
  
  public void gameLogic(int pattern){
    if(isLooping){
       if(y > height + imageY) y = -imageY; 
    }
    
    switch(pattern){
       case(0):{ //Top to bottom
         y++;
       } break;
       case(1):{ //Sine wave
         y++;
         x =  sin(y*.01)*100 + baseX;
       } break;
       case(2):{ //Negative sine wave
         y++;
         x =  -sin(y*.01)*100 + baseX;
       } break;
       case(3):{ //Tan wave
        //x = baseX;
        baseX += 0.01;
        y = tan(baseX)*25 + baseY;
        //println(baseX + " : " + y);
      } break; 
      case(4):{ //Simple pattern where the bullet goes in the direction specified by modX and modY
        x = x + modX;
        y = y + modY;
      } break;
      case(5):{ //Simple pattern where the bullet goes in the direction specified by modX and modY (reversed x)
        x = x - modX;
        y = y + modY;
      } break;
      
      case(6):{ //"Gravity"-influenced bullet
        x = x + modX;
        y = y + (modY*.5);
        modY++;
        if(modY >= 5) modY = 5;
      }
      case(7):{ //We do nothing - this is for fancy dumb stuff

    } break;
    
    }
    if(isOutOfBounds() && !isLooping){
      hasCollided = true;
    }
  }
  
  //Checks
  public boolean checkCollision(playerShip p){
    return checkCollisionY(p) && ((p.x + p.collisWid > x - imageX/2) && (p.x - p.collisWid < x + imageX/2)); //Rectangular check.
  }
  
  public boolean checkCollisionY(playerShip p){
    return (checkAbove(p) && checkBelow(p));
  }
  
  public boolean checkAbove(playerShip p){
    return (p.collisY - p.collisHig < y + imageY/2);
  }
  
  public boolean checkBelow(playerShip p){
    return (p.collisY + p.collisHig > y - imageY/2);
  }
  
  public boolean isOutOfBounds(){
     return (x > width + imageX) || (x < 0 - imageX) || (y > height + imageY); 
  }
  
  
  public void draw(){
      fill(c);
      ellipse(x,y,imageX,imageY);
  }
}
