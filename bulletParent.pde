class BulletParent{
  float bWidth, bHeight, x, y;
  int bulletTop, bulletBottom, maxTime, timer, patTime;
  int[] p;
  playerShip player;
  ArrayList<Bullet> bulletArray, toBullet;
  int currentPattern = 0;
  
  public BulletParent(float Width, float Height, float iX, float iY, ArrayList<Bullet> bArray, playerShip p, int pattern){
     player = p;
     x = iX;
     y = iY;
     bWidth = Width;
     bHeight = Height;
     bulletArray = bArray;
     this.p = new int[1];
     this.p[0] = pattern;
  }
  
  public BulletParent(float Width, float Height, float iX, float iY, ArrayList<Bullet> bArray, playerShip p, int[] pattern){
     player = p;
     x = iX;
     y = iY;
     bWidth = Width;
     bHeight = Height;
     bulletArray = bArray;
     this.p = pattern;
  }
  
  public BulletParent(){
     //Empty bullet parent for the sake of error checking
     bulletArray = new ArrayList<Bullet>();
  }
  
  public BulletParent(float Width, float Height, float iX, float iY, ArrayList<Bullet> toB, int time, playerShip p, int pattern){
     player = p;
     x = iX;
     y = iY;
     bWidth = Width;
     bHeight = Height;
     toBullet = toB;
     bulletArray = new ArrayList<Bullet>();
     maxTime = time;
     this.p = new int[1];
     this.p[0] = pattern;
  }
  
    public BulletParent(float Width, float Height, float iX, float iY, ArrayList<Bullet> toB, int time, playerShip p, int[] pattern){
     player = p;
     x = iX;
     y = iY;
     bWidth = Width;
     bHeight = Height;
     toBullet = toB;
     bulletArray = new ArrayList<Bullet>();
     maxTime = time;
     this.p = pattern;
  }
  
  public BulletParent(float Width, float Height, float iX, float iY, ArrayList<Bullet> toB, int time, int patternTime, playerShip p, int[] pattern){
     player = p;
     x = iX;
     y = iY;
     bWidth = Width;
     bHeight = Height;
     toBullet = toB;
     bulletArray = new ArrayList<Bullet>();
     maxTime = time;
     patTime = patternTime;
     this.p = pattern;
  }
  
  //Collision stuff
  public boolean isCollidingGeneric(){
    return isCollidingGenericX() && isCollidingGenericY();
  }
  
  public boolean isCollidingGenericY(){
    return isAbove() && isBelow();
  }
  
  public boolean isBelow(){
     // println((player.collisY + player.collisHig) + " : " + y + bHeight + " - " + (player.collisY + player.collisHig < y + bHeight));
     return (player.collisY - player.collisHig < y + bHeight);
  }
  
  public boolean isAbove(){
    //println((player.collisY - player.collisHig) + " : " + (y - bHeight) + " - " + (player.collisY - player.collisHig > y - bHeight));
   return (player.collisY + player.collisHig > y - bHeight);
  }
  
  public boolean isCollidingGenericX(){
     return ((player.x + player.collisWid > x - bWidth) && (player.x - player.collisWid < x + bWidth)); //This checks if we're in range of actually colliding with the bullets (in general) 
  }
    
  
  //Game Logic/Drawing
  public void gameLogic(){
    if(toBullet != null){
      timer++;
      if(timer >= maxTime){
        timer = 0;
        if(toBullet.size() > 0) bulletArray.add(toBullet.remove(0));
        else{ 
          toBullet = null;
          timer = 0;
        }
      }
    } else if(currentPattern < p.length - 1){
      timer++;
      if(patTime != 0) maxTime = patTime;
      if(timer >= maxTime){
         currentPattern++;
         timer = 0;
      }
    }
    
    if(isCollidingGeneric() && !player.invuln) { //If we're in the area
      //Start the more intensive checks. For the purposes of testing, basic collision (i.e. no range changing) will be done
      for(int i = 0; i < bulletArray.size(); i++){
        Bullet b = bulletArray.get(i);
        if(b.checkCollision(player)) {
          bulletArray.remove(i);
          player.die();
        }
        
        if(b.hasCollided) bulletArray.remove(i);
      }
    }
    //Bullet Logic - All the fancy stuff either happens here (or in the bullets)
    
    for(Bullet b : bulletArray) b.gameLogic(p[currentPattern]);
  }
  
  public void swapLooping(){
     for(int i = 0; i < bulletArray.size(); i++){
        Bullet b = bulletArray.get(i);
        b.isLooping = !b.isLooping;
     }
  }
  
  public void draw(){
     //rect(x-bWidth,y-bHeight,bWidth*2,bHeight*2);  
     //if(debugCheck) rect(x-bWidth,y-bHeight,bWidth*2,bHeight*2);
     for(Bullet b : bulletArray) if(!b.hasCollided) b.draw();
  }
}
