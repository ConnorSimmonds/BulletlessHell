//stage1 - basically just keeps a record of all the patterns and manages how far we've gone through. Cycles through patterns until we've reached the end.

class Stage1{
  int pattern, timer, maxTim, stageGraphic, graphicTimer;
  ArrayList<BulletParent> bP;
  Boss boss;
  playerShip p;
  
  //Constructor
  public Stage1(playerShip p){
     timer = 0;
     pattern = -1;
     maxTim = 1800;
     this.p = p;
     bP = startingPattern();
  }

  //Logic
  public void logic(){
    timer++;
    
    switch(pattern){
      case(-1):{
        p.enter();
        if(p.cutscene == false){
          pattern++;
          timer = 0;
        }
      }
      
       case(0):{
         if(timer == maxTim*.25) bP.add(new BulletParent(width*.5, height, width * .75, 0, straightPattern(width*.75,-height*1.25),player,1));
         
         if(timer == maxTim*.35) bP.add(new BulletParent(width*.5, height, width * .5, 0, straightPattern(width*.5,-height*1.25),player,2));
         
         if(timer == maxTim*.75){
           bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern2(height*.25,-15),5,player,6));
         }
         
         if(timer >= maxTim){
            increasePattern();
            maxTim = 600;
            bP = pattern2();
         }
         
       } break;
       
       case(1):{
         if(timer == maxTim/2){
             bP.addAll(pattern1());
         }
         
         if(timer >= maxTim){
            increasePattern();
            maxTim = 1200;
            bP.addAll(pattern1());
            bP.add(parent2(width*.5,height*.5));
         }
         
       } break;
       
       case(2):{
         if(timer == maxTim*.25){
            bP.addAll(pattern3());
            bP.add( new BulletParent(width,height,width*.5,0,halfReversePattern(width*.5,height*.25,1,3),player,4));
         }
         
         if(timer == 600){
            bP.addAll(pattern2());
            bP.add(new BulletParent(width,height,width*.5,0,halfPattern(width*.5,height*.25,1,3),player,4));
         }
         
         if(timer == 625) bP.add( new BulletParent(width,height,width*.5,0,halfReversePattern(width*.5,height*.5,1,3),player,4));
         
         if(timer == 1100){
            for(int i = 0; i < bP.size(); i++){
               BulletParent tBP = bP.get(i);
               tBP.swapLooping();
            }
         }
         
         if(timer >= maxTim){
           increasePattern();
           bP.addAll(pattern4());
           maxTim = 1200;
         }
         
       } break;
       case(3):{
          if(timer == 200){
             bP.addAll(sackBullets());
          }
          
          if(timer == 600){
             bP.addAll(pattern4(width*.25)); 
             bP.addAll(pattern4(-width*.25)); 
          }
          
          if(timer == 800){
             bP.addAll(sackBullets()); 
          }
          
          if(timer == 1000){
             int[] tempPat = {7,3};
           bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern2(height*.25,-15),5,player,tempPat));
          }
          
          if(timer >= maxTim){
           increasePattern();
           bP.addAll(pattern2());
           bP.addAll(pattern1());
           maxTim = 1200;
         }
       } break;
       
       case(4):{
          if(timer == 400){
             bP.addAll(sackBullets()); 
             bP.addAll(pattern1());
             bP.addAll(pattern4());
          }
          
          if(timer == 750){
            bP.addAll(startingPattern());
            bP.add(new BulletParent(width*.5, height, width * .75, 0, straightPattern(width*.75,-height*1.25),player,2));
          }
          
          if(timer == 850){
              bP.addAll(pattern4(width*.25));
          }
          
          if(timer == 950){
             bP.addAll(pattern4(width*.75)); 
          }
          
         if(timer >= maxTim){
           increasePattern();
           bP.addAll(sackBullets());
           bP.addAll(pattern3());
           maxTim = 1600;
         }
       } break;
       
       case(5):{
         if(timer == 300) bP.add( new BulletParent(width,height,width*.5,0,halfReversePattern(width*.5,height*.5,1,3),player,4));
         if(timer == 400) bP.addAll(sackBullets());
         if(timer == 500) bP.add( new BulletParent(width,height,width*.5,0,halfPattern(width*.5,height*.5,1,3),player,4));
         if(timer == 600) bP.addAll(sackBullets());
         if(timer == 600) bP.add( new BulletParent(width,height,width*.5,0,halfReversePattern(width*.5,height*.5,1,3),player,4));
         if(timer == 800) bP.addAll(sackBullets());
         
         if(timer == 900){
           bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern2(height*.25,-15),5,player,6));
         }
         
         if(timer == 1050){
           int[] tempPat = {7,3};
           bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern2(height*.25,-15),5,player,tempPat));
         }
         
         if(timer ==  1200) {
           for(int i = 0; i < bP.size(); i++){
               BulletParent tBP = bP.get(i);
               tBP.swapLooping();
            }
         }
         
         if(timer >= maxTim){
           increasePattern();
           maxTim = 1800;
         }
       } break;
       
       case(6):{ //Start of boss-fight: draw the graphic
       switch(timer){
          case(100):{
            for(int i = 0; i < bP.size(); i++){
               BulletParent tBP = bP.get(i);
              // tBP.swapLooping();
            } 
          } break;
          
          case(200):{
            stageGraphic = 1;
           graphicTimer = 0;
          } break;
          
          case(600):{
            boss = new Boss(new ArrayList<BulletParent>(), width*.5, -50,p);
             boss.setTargets(width*.5,height*.5);
          } break;
          
          case(800):{
            boss.addToBullet(boss.pattern1()); 
          } break;
          
          case(850):{
            boss.addToBullet(boss.pattern1());
          } break;
          
          case(900):{
             boss.addToBullet(boss.pattern1());
          } break;
          
          case(950):{
            boss.addToBullet(boss.pattern2()); 
         } break;
         
         case(1000):{
          boss.addToBullet(boss.pattern2()); 
         }
         
         case(1050):{
          boss.addToBullet(boss.pattern1());  
         } break;
         
         case(1250):{
            boss.addToBullet(boss.pattern3()); 
         } break;
         
         case(1500):{
            boss.addToBullet(boss.pattern3()); 
         } break;
       }
       if(timer >= maxTim){
           increasePattern();
           maxTim = 1600;
           boss.setTargets(width*.75,height*.25);
         }
       } break;
       
       case(7):{
           switch(timer){
              case(100):{
                boss.addToBullet(boss.pattern4());
                boss.setTargets(width*.25,height*.25);
              } break;
              
              case(300):{
                boss.addToBullet(boss.pattern5());
              } break;
              
              case(600):{
               boss.setTargets(width*.5,height*.5); 
              } break;
              
              case(800):{
                 boss.addToBullet(boss.pattern6()); 
                 boss.setTargets(width*.5,height*.25); 
              } break;
              
              case(1200):{
                 bP = loopingPattern();
              }
              
              case(1400):{
                boss.addToBullet(boss.pattern2());
              } break;
           }
           if(timer >= maxTim){
           increasePattern();
           maxTim = 2200;
         }
       } break;
       
       case(8):{
          switch(timer){
             case(100):{
               bP.addAll(sackBullets());
               bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern(width*.25,-height*1.25),player,1));
               bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern(width*.75,-height*1.25),player,1));
               boss.addToBullet(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
             }break;
             
             case(400):{
               bP.addAll(sackBullets());
               bP.addAll(pattern4(width*.25));
               bP.addAll(pattern4(-width*.25));
               boss.addToBullet(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
             } break;
             
             case(700):{
               bP.addAll(sackBullets());
               int[] tempPat = {7,3};
               bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern2(height*.25,-15),5,player,tempPat));
               boss.addToBullet(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
             } break;
             
             case(1000):{
               bP.addAll(sackBullets());
               int[] tempPat = {7,3};
               bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern2(height*.25,-15),5,player,tempPat));
               bP.addAll(pattern4(width*.25));
               bP.addAll(pattern4(-width*.25));
               bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern(width*.25,-height*1.25),player,1));
               bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern(width*.75,-height*1.25),player,1));
               boss.addToBullet(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
               boss.addToQueue(boss.pattern2());
             }
             
             case(1300):{
               boss.addToBullet(boss.pattern6());
             } break;
             
             case(1800):{
                boss.addToBullet(pattern1()); 
             }
          }
          if(timer >= maxTim){
               increasePattern();
               maxTim = 2000;
               for(int i = 0; i < bP.size(); i++){
                 BulletParent tBP = bP.get(i);
                 tBP.swapLooping();
              }   
         }
       }break;
       case(9):{
           switch(timer){
              case(50): boss.addToBullet(boss.pattern1()); break;
              case(100): bP.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern2(height*.25,-15),5,player,6)); break;
              case(150): boss.addToBullet(boss.pattern1()); break;
              case(200): {boss.addToBullet(boss.pattern4());
                bP.addAll(sackBullets());
                boss.setTargets(width*.25,height*.25);
              }break;
              
              case(300): { boss.addToBullet(boss.pattern5());
                bP.addAll(sackBullets());
                boss.setTargets(width*.75,height*.25);
              } break;
              
              case(400): { boss.addToBullet(boss.pattern6());
                bP.add(parent2(width*.5,height*.5));
                boss.setTargets(width*.75,height*.25);
              } break;
              
              case(650):{
                boss.addToBullet(boss.pattern4());
                bP.add(new BulletParent(width*.5, height, width * .5, 0, straightPattern(width*.5,-height*1.25),player,2));
                boss.setTargets(width*.25,height*.25);
              } break;
              
              case(750):{
                boss.addToBullet(boss.pattern5());
                bP.add(new BulletParent(width*.5, height, width * .5, 0, straightPattern(width*.5,-height*1.25),player,1));
                boss.setTargets(width*.75,height*.25);
              }
              
              case(850):{
                boss.addToBullet(boss.pattern4());
                bP.addAll(pattern4());
                boss.setTargets(width*.5,height*.25);
              } break;
              
              case(1000):{
                 bP.addAll(pattern4(width*.25));
                 bP.addAll(pattern4(-width*.25));
                 boss.addToBullet(boss.pattern6());
                 boss.addToQueue(boss.pattern2());
                 boss.addToQueue(boss.pattern2());
                 boss.addToQueue(boss.pattern2());
              } break;
              
              case(1400):{
                bP.addAll(pattern1());
                bP.addAll(barPattern());
              } break;
              
              case(1600):{
                 boss.addToBullet(boss.pattern2());
                 boss.addToQueue(boss.pattern2());
              } break;
              
              case(1700):{
                boss.addToBullet(boss.pattern6());
              } break;
           }
           if(timer >= maxTim){
               increasePattern();
               maxTim = 500; 
         }
       }break;
       case(10):{
          switch(timer){
             case(50):  boss.setTargets(width*.25,height*.25); break;
             case(100): boss.setTargets(width*.75,height*.25); break;
             case(150): boss.setTargets(width*.5,height*.5); break;
             case(200): boss.setTargets(width*.5,height*.65); break;
             case(225): boss.setTargets(width*.5,height*.5); break;
             case(250): boss.setTargets(width*.5,height*.65); break;
             case(275): boss.setTargets(width*.5,height*.5); break;
             case(300): boss.setTargets(width*.5,-height); break;
          }
          if(timer >= maxTim){
            player.win();     
          }
       }
    }
  }
  
  //General Methods
  public void increasePattern(){
      if(!p.gameOver) {
            timer = 0;
            pattern++;
            clearBP();
            p.increaseMult(); 
      }
  }
  
  public void clearBP(){ //clears out bullet parents who have a null amount of bullet objects
      for(int i = 0; i < bP.size(); i++){
         BulletParent toChange = bP.get(i);
         if(toChange.bulletArray.size() == 0) bP.remove(i); 
      }
  }
  
  //General Patterns
  //BulletParent arguments: (float Width, float Height, float iX, float iY, Bullet[] bArray, playerShip p, int pattern){ 
  ArrayList<BulletParent> startingPattern(){
     ArrayList<BulletParent> pattern = new ArrayList<BulletParent>();
     
     pattern.add(new BulletParent(width*.5, height, width * .25, 0, straightPattern(width*.25,-height*1.25),player,1));
     return pattern;
  }
  
  ArrayList<BulletParent> barPattern(){
    ArrayList<BulletParent> pattern = new ArrayList<BulletParent>(); 
    
    for(int i = 0; i < 10; i++){
        pattern.add(new BulletParent(10, height, width * .5, 0, straightPattern(width*(.05 + (float) i/10),-height*1.25),player,0));
    }
   return pattern;
  }
    
  ArrayList<BulletParent> pattern1(){
     ArrayList<BulletParent> pattern = new ArrayList<BulletParent>(); 
     
     pattern.add(new BulletParent(width,height,width*.5,0, circlePattern(width*.25,height*.25,1,1),player,4));
     pattern.add(new BulletParent(width,height,width*.5,0, circlePattern(width*.75,height*.25,1,1),player,4));
       return pattern;
  }
  
  ArrayList<BulletParent> pattern2(){
     ArrayList<BulletParent> pattern= new ArrayList<BulletParent>(); 
   
     pattern.add(new BulletParent(width,height,width*.5,0, circlePattern(width*.5,height*.25,1,1),player,4)); //(float Width, float Height, float iX, float iY, Bullet[] bArray, playerShip p, int pattern){ 
    return pattern;
  }
  
  ArrayList<BulletParent> sackBullets(){
    ArrayList<BulletParent> pattern= new ArrayList<BulletParent>(); 
    int[] patternArray = { 7, 6 };
    pattern.add(new BulletParent(width,height,width*.5,0, preDrawCirclePattern(width*.5,height*.25,2,-5,25,25),1,player,patternArray));
    return pattern;
  }
  
  ArrayList<BulletParent> pattern3(){
     ArrayList<BulletParent> pattern = new ArrayList<BulletParent>(); 
     
     pattern.add(new BulletParent(width,height,width*.5,0,halfPattern(width*.5,height*.25,1,3),player,4));
     pattern.add(new BulletParent(10,height,width*.25,0,loopingStraightPattern(width*.25,-height),player,0));
     pattern.add(new BulletParent(10,height,width*.75,0,loopingStraightPattern(width*.75,-height),player,0));
     
     return pattern;
  }
  
    ArrayList<BulletParent> loopingPattern(){
     ArrayList<BulletParent> pattern = new ArrayList<BulletParent>(); 
     
     pattern.add(new BulletParent(10,height,width*.25,0,loopingStraightPattern(width*.25,-height),player,0));
     pattern.add(new BulletParent(10,height,width*.75,0,loopingStraightPattern(width*.75,-height),player,0));
     
     return pattern;
  }
  
  ArrayList<BulletParent> pattern4(){
     ArrayList<BulletParent> pattern = new ArrayList<BulletParent>();
     
     pattern.add((new BulletParent(width,height,width*.5,0, circlePattern(width*.5,height*.25,1,1),10,player,4)));
     return pattern;
  }
  
    ArrayList<BulletParent> pattern4(float xDisp){
     ArrayList<BulletParent> pattern = new ArrayList<BulletParent>();
     
     pattern.add((new BulletParent(width,height,width*.5+xDisp,0, circlePattern(width*.5+xDisp,height*.25,1,1),10,player,4)));
     return pattern;
  }
  
  BulletParent parent2(float x, float y){
      return new BulletParent(width,height,x,0, circlePattern(x,y,2,2),player,4);
  }
  
  //Bullet Patterns
  public ArrayList<Bullet> circlePattern(float x, float y, float xSpeed, float ySpeed){
    int h = (int) height/10;
   ArrayList<Bullet> bullets = new ArrayList<Bullet>();
   
   for(int i = 0; i < h; i++){
      bullets.add(new Bullet(x+(cos(i/TWO_PI)*xSpeed),y+(sin(i/TWO_PI)*ySpeed),7,7,cos(i/TWO_PI)*xSpeed,sin(i/TWO_PI)*ySpeed));
   }
   
   return bullets;
  }
  
  public ArrayList<Bullet> preDrawCirclePattern(float x, float y, float xSpeed, float ySpeed, float xDisp, float yDisp){
    int h = (int) height/10;
   ArrayList<Bullet> bullets = new ArrayList<Bullet>();
   
   for(int i = 0; i < h; i++){
      bullets.add(new Bullet(x+(cos(i/TWO_PI)*xDisp),y+(sin(i/TWO_PI)*yDisp),7,7,cos(i/TWO_PI)*xSpeed,sin(i/TWO_PI)*ySpeed));
   }
   
   return bullets;
  }
  
  public ArrayList<Bullet> halfPattern(float x, float y, float xSpeed, float ySpeed){
    int h = (int) height/10;
   ArrayList<Bullet> bullets = new ArrayList<Bullet>();
   
   for(int i = 0; i < h; i++){
      bullets.add(new Bullet(x,y,7,7,cos(TWO_PI/i)*xSpeed,sin(TWO_PI/i)*ySpeed));
   }
   
   return bullets;
  }
   
  public ArrayList<Bullet> halfReversePattern(float x, float y, float xSpeed, float ySpeed){
    int h = (int) height/10;
   ArrayList<Bullet> bullets = new ArrayList<Bullet>();
   
   for(int i = 0; i < h; i++){
      bullets.add(new Bullet(x,y,7,7,-cos(TWO_PI/i)*xSpeed,sin(TWO_PI/i)*ySpeed));
   }
   
   return bullets;
  }
  
  public ArrayList<Bullet> straightPattern(float x, float y){
  int h = (int) height/20;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  for(int i = 0; i < h; i++){
     bullets.add(new Bullet(x,(i*h) + y,7,7));
  }
  return bullets;
  }
  
    public ArrayList<Bullet> loopingStraightPattern(float x, float y){
  int h = (int) height/20;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  for(int i = 0; i < h; i++){
     bullets.add(new Bullet(x,(i*h) + y,7,7));
     bullets.get(i).isLooping = true;
  }
  
  return bullets;
}
  
  public ArrayList<Bullet> straightPattern2(float x){
  int h = (int) height/25;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  for(int i = 0; i < h; i++){
     bullets.add(new Bullet(i*h,x,7,7));
  }
  
  return bullets;
}

  public ArrayList<Bullet> straightPattern2(float x, float ySpeed){
  int h = (int) height/25;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  for(int i = 0; i < h; i++){
     bullets.add(new Bullet(i*h,x,7,7,0,ySpeed));
  }
  
  return bullets;
}

  public ArrayList<Bullet> pointPattern(float x, float y){
    int h = (int) height/25;
   ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  for(int i = 0; i < h; i++){
     bullets.add(new Bullet(x,y,7,7));
  }
  return bullets;
  }
  
  //Drawing
  void draw(){
    fill(0,0,0);
    //text(timer,width*.5,20);
    if(bP != null){
       for(BulletParent bulP : bP){
         bulP.gameLogic(); 
         bulP.draw();
       } 
     }
     if(boss != null){
        boss.logic();
        boss.draw(); 
     }
     
     graphicTimer++;
     switch(stageGraphic){
         case(0):  break;
         case(1):{//Boss warning graphic
         pushMatrix();
           fill(20 + (235*((float) graphicTimer/100 - (int) graphicTimer/100)),0,0);
           textAlign(CENTER);
           textSize(64);
           text("WARNING",width*.5,height*.5);
        popMatrix();
        if(graphicTimer > 500){
           stageGraphic = -1;
        }
       }break; 
     }
  }
}
