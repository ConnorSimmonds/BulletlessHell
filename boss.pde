class Boss{
   ArrayList<BulletParent> bulletPatterns, toPatterns; //second is basically a queue
   float x, y, modX, modY, tX, tY;
   int imageX, imageY, queueTimer, queueMax;
   color bulletColor = color(128,0,0);
   playerShip player;
   
   public Boss(ArrayList<BulletParent> bP, float x, float y, playerShip p){
       bulletPatterns = bP;
       modX = 0.05; //easing value
       modY = 0.05; //easing value
       imageX = 50;
       imageY = 50;
       this.x = x;
       this.y = y;
       player = p;
   }
   
   void logic(){
    if(bulletPatterns != null){
       for(BulletParent bulP : bulletPatterns){
         bulP.gameLogic(); 
         bulP.draw();
       } 
     }
     
     if(toPatterns != null){
        queueTimer++;
        if(queueTimer >= queueMax){
           queueTimer = 0;
           if(toPatterns.size() >= 1) bulletPatterns.add(toPatterns.remove(0));
           else toPatterns = null;
           
        }
     }
     
     move();
   }
   
   void move(){
     if(toPatterns == null){
       x += (tX - x) * modX;
       y += (tY - y) * modY;
     }
   }
   
   void setTargets(float x, float y){
      tX = x;
      tY = y;
   }
   
   public void addToBullet(ArrayList<BulletParent> toAdd){
     bulletPatterns.addAll(toAdd);
   }
   
   public void addToBullet(BulletParent toAdd){
     bulletPatterns.add(toAdd);
   }
   
   public void addToQueue(ArrayList<BulletParent> toAdd){
     if(toPatterns != null) toPatterns.addAll(toAdd);
     else {
        toPatterns = toAdd; 
     }
   }
   
   public void addToQueue(BulletParent toAdd){
     if(toPatterns != null) toPatterns.add(toAdd);
     else {
       toPatterns = new ArrayList<BulletParent>();
       toPatterns.add(toAdd);
     }
   }
   
   public void setQueueDelay(int delay){ queueMax = delay;}
   
   //Boss Patterns
   ArrayList<BulletParent> pattern1(){ //Looks at the player, and aims three streams of bullets at them
      ArrayList<BulletParent> pattern = new ArrayList<BulletParent>(); 
      
      pattern.add(new BulletParent(width,height,x,y,stream(x,y+imageY,10),2,player,4));
      pattern.add(new BulletParent(width,height,x-imageX,y,stream(x-imageX,y+imageY,10),2,player,4));
      pattern.add(new BulletParent(width,height,x+imageX,y,stream(x+imageX,y+imageY,10),2,player,4));
      
      return pattern;
   }
   
   ArrayList<BulletParent> pattern2(){
       ArrayList<BulletParent> pattern = new ArrayList<BulletParent>(); 

       pattern.add(new BulletParent(width,height,x,y, circle(x,y,1,1,40),player,4));

       return pattern;
   }
   
   ArrayList<BulletParent> pattern3(){ //4 3/4 circles
       ArrayList<BulletParent> pattern = new ArrayList<BulletParent>(); 
       ArrayList<BulletParent> toPat = new ArrayList<BulletParent>();
       pattern.add(new BulletParent(width,height,x,y, circle(x,y,1,1,0,30),player,4));
       toPat.add(new BulletParent(width,height,x,y, circle(x,y,1,1,10,40),player,4));
       toPat.add(new BulletParent(width,height,x,y, circle(x,y,1,1,20,50),player,4));
       toPat.add(new BulletParent(width,height,x,y, circle(x,y,1,1,30,60),player,4));
       queueMax = 25;
       toPatterns = toPat;
       return pattern;
   }
   
   ArrayList<BulletParent> pattern4(){ //1/4 circle, going left/right
       ArrayList<BulletParent> pattern = new ArrayList<BulletParent>(); 
       pattern.add((new BulletParent(width,height,x,y, circle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, circle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, circle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,5,15),5,player,4)));
       queueMax = 25;
       return pattern;
   }
   
  ArrayList<BulletParent> pattern5(){ //pattern 4, but going the other way
       ArrayList<BulletParent> pattern = new ArrayList<BulletParent>(); 
       pattern.add((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, circle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, circle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,5,15),5,player,4)));
       addToQueue((new BulletParent(width,height,x,y, circle(x,y,1,1,5,15),5,player,4)));
       queueMax = 25;
       return pattern;
   }
   
   ArrayList<BulletParent> pattern6(){ //Pattern 4/5 but half circles.
     ArrayList<BulletParent> pattern = new ArrayList<BulletParent>();
     pattern.add(new BulletParent(width,height,x,y, circle(x,y,1,1,0,40),player,4));
     pattern.add((new BulletParent(width,height,x,y, circle(x,y,1,1,0,30),5,player,4)));
     addToQueue((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,0,30),5,player,4)));
     addToQueue((new BulletParent(width,height,x,y, circle(x,y,1,1,0,30),5,player,4)));
     addToQueue((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,0,30),5,player,4)));
     addToQueue((new BulletParent(width,height,x,y, circle(x,y,1,1,0,30),5,player,4)));
     addToQueue(new BulletParent(width,height,x,y, circle(x,y,1,1,0,40),player,4));
     addToQueue((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,0,30),5,player,4)));
     addToQueue((new BulletParent(width,height,x,y, circle(x,y,1,1,0,30),5,player,4)));
     addToQueue((new BulletParent(width,height,x,y, reverseCircle(x,y,1,1,0,30),5,player,4)));
     addToQueue((new BulletParent(width,height,x,y, circle(x,y,1,1,0,30),5,player,4)));
     addToQueue(new BulletParent(width,height,x,y, circle(x,y,1,1,0,40),player,4));
     queueMax = 25;
     return pattern;
   }
   
  //Boss Bullets
  public ArrayList<Bullet> stream(float x, float y, int bulletNum){
    ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
    for(int i = 0; i < bulletNum; i++){
       bullets.add(new Bullet(x,y,7,7,-(x-player.x)/20,-(y-player.y)/20));
       bullets.get(i).setColor(bulletColor);
    }
    return bullets;
  }
  
  public ArrayList<Bullet> circle(float x, float y, float xSpeed, float ySpeed, int bulletNum){
   ArrayList<Bullet> bullets = new ArrayList<Bullet>();
   
   for(int i = 0; i < bulletNum; i++){
      bullets.add(new Bullet(x+(cos(i/TWO_PI)*xSpeed),y+(sin(i/TWO_PI)*ySpeed),7,7,cos(i/TWO_PI)*xSpeed,sin(i/TWO_PI)*ySpeed));
   }
   
   return bullets;
  }
  
  
  public ArrayList<Bullet> reverseCircle(float x, float y, float xSpeed, float ySpeed, int bulletNum){
   ArrayList<Bullet> bullets = new ArrayList<Bullet>();
   
   for(int i = 0; i < bulletNum; i++){
      bullets.add(new Bullet(x+(-cos(i/TWO_PI)*xSpeed),y+(-sin(i/TWO_PI)*ySpeed),7,7,-cos(i/TWO_PI)*xSpeed,-sin(i/TWO_PI)*ySpeed));
   }
   
   return bullets;
  }
  
    
  public ArrayList<Bullet> circle(float x, float y, float xSpeed, float ySpeed, int bulletStart, int bulletEnd){
   ArrayList<Bullet> bullets = new ArrayList<Bullet>();
   
   for(int i = bulletStart; i < bulletEnd; i++){
      bullets.add(new Bullet(x+(cos(i/TWO_PI)*xSpeed),y+(sin(i/TWO_PI)*ySpeed),7,7,cos(i/TWO_PI)*xSpeed,sin(i/TWO_PI)*ySpeed));
   }
   
   return bullets;
  }

  public ArrayList<Bullet> reverseCircle(float x, float y, float xSpeed, float ySpeed, int bulletStart, int bulletEnd){
   ArrayList<Bullet> bullets = new ArrayList<Bullet>();
   
   for(int i = bulletStart; i < bulletEnd; i++){
      bullets.add(new Bullet(x+(-cos(i/TWO_PI)*xSpeed),y+(sin(i/TWO_PI)*ySpeed),7,7,-cos(i/TWO_PI)*xSpeed,sin(i/TWO_PI)*ySpeed));
   }
   
   return bullets;
  }
  
  public ArrayList<Bullet> preCircle(float x, float y, float xSpeed, float ySpeed, float xDisp, float yDisp, int bulletNum){
     ArrayList<Bullet> bullets = new ArrayList<Bullet>();
   for(int i = 0; i < bulletNum; i++){
      bullets.add(new Bullet(x+(cos(i/TWO_PI)*xDisp),y+(sin(i/TWO_PI)*yDisp),7,7,cos(i/TWO_PI)*xSpeed,sin(i/TWO_PI)*ySpeed));
   }
   
   return bullets;
  }
   
   void draw(){
      fill(0,255,0);
      ellipse(x,y,imageX,imageY); 
   }
}
