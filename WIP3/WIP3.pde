// Manuel Soto, Isreal Parra, Wendell Brooks
  
  import java.util.*;

Star star;
Nobby nobby;
Title gameTitle;
PImage ship;
PImage beeShip;
PImage waspShip;
PFont title;
int stage;
import processing.sound.*;
SoundFile file;
SoundFile shoot;
SoundFile pew;

public static int beeNum = 0;
public static int waspNum = 0;

public static boolean gameover = false;

public final int starCount = 150;
public Star[] stars = new Star[starCount];
public static final int roomWidth = 900;
public static final int roomHeight = 900;
public int score = 0;
public int highScore = 100;
public boolean passHighscore = false;

public LinkedList<Entity> entities;
public LinkedList<Bullet> bullets;

final int INTRO = 0;
final int PLAY = 1;
final int GAMEOVER = 2;
final int CREDITS = 3;
final int WIN = 4;
final int INSTRUCT = 5;
public int gameState;

void staro () {
  for (int i = 0; i < starCount; i ++){
     stars[i] = new Star(
       (float)Math.random()*roomWidth,  //random position on x-axis
       (float) Math.random()*roomHeight, //random position on y-axis
        (int)random(4)          //random size from 1 to 4
     ); 
  }
}

void drawStars(){
  for (int i = 0; i < starCount; i ++){ 
     ellipse(stars[i].x, stars[i].y, stars[i].size, stars[i].size);
     stars[i].move(); 
  }
}

int spawnRate = 60;
void init(){
  passHighscore = false;
  spawnRate = 40;
   gameover = false;
   beeNum = 44;
waspNum = 0  ;
  score = 0;
entities = new LinkedList();
bullets = new LinkedList();
  nobby = new Nobby();
  entities.add(nobby);
}
int texty = height;
void drawCredits(){
  background(0);
  textAlign(CENTER);
  textSize(14);
  text("A game made by \n" +
  "Programmers: Manuel Soto, Isreael Parra, Wendell Brooks\n" +
  "Images(Sprites): Fighter(from Galaga), Bee(From Galaga), and Galaga Boss(from Galaga) \n" +
  "Title Music: Captain Skyhawk Theme - David Wise \n" +
  "Thank You for playing!\n"+ "Galaga is a game developed by NAMCO, Published by NAMCO\n"+ "\nPress ANY Key to return to menu",
  width/2, height - texty);
  texty += 1;
}

void setup(){

gameState = INTRO;

if (file == null){
  file = new SoundFile(this, "CaptainSkyhawkTitle.mp3");
  file.loop();
}

shoot = new SoundFile(this, "laser.mp3");
pew = new SoundFile(this, "pew.mp3");
  
gameTitle = new Title();
gameTitle.setTitle();

     size (900,900);
  staro();
  ship = loadImage("nobbyShip.png");
  beeShip = loadImage("beeShip.png");
  waspShip = loadImage("waspShip.png");

  init();
}

void draw(){ 
  background(0);
  drawStars();
  
  switch (gameState){
    case INTRO:
      gameTitle.drawTitle();
    break;
    
    case PLAY:
      gamePlay();
    break;
    
    case CREDITS:
      drawCredits();
    break;
    
    case GAMEOVER:
    drawScreen("GAME OVER", "Press s to restart\n SCORE: "+score+"\nHigh Score: "+highScore+"\nPress m to return to Menu"+"\nPress c to view credits");
    break;
    
    case WIN:
    drawScreen("YOU WIN!", "Press s to restart\n SCORE: "+score+"\nHigh Score: "+highScore+"\nPress m to return to Menu"+"\nPress c to view Credits");
    break;
    
    case INSTRUCT:
    drawScreen("INSTRUCTIONS","< : Left\n> : Right\nSPACE : Shoot\nBees = 1 hit/point, Wasp = 4 hits/points\n\nPress m for menu");
    break;
  }
}

void headsUpDisplay(){
  
  //lives
  for(int i=1; i<=nobby.lives; i++)
    image(ship, 30*i-12, height-40, 30, 30); 
  
  // Score
  textSize(20);
  textAlign(LEFT, TOP);
  text("HIGH SCORE: "+ highScore, 0, 0);
  
  textSize(20);
  textAlign(RIGHT, TOP);
  text("SCORE: "+ score, width, 0); 
}

int spawnCounter = 0;
void gamePlay(){
  spawnRate += 0.5;

  if (gameover){
      if (passHighscore)
        gameState = WIN;
        else
      gameState = GAMEOVER;
     return; 
  }
  spawnCounter++;
  if (spawnCounter > spawnRate){
    spawnCounter = 0;
    if (Math.round(Math.random()*2) == 0){
        Enemy wasp = new Enemy(0,50, 15, waspShip, 50);
        entities.add(wasp);
        wasp.health = 4 ;
    }
    else
      entities.add(new Enemy(0,50, 5, beeShip, 50)); 
  }
  
  ListIterator<Entity> i = entities.listIterator();
  while (i.hasNext()){
   Entity entity = i.next();
   entity.move(i);
  }
  
 i = entities.listIterator();
  while (i.hasNext()){
   if (i.next().isDead)
     i.remove();
  }
  
  headsUpDisplay();
  
}

void keyPressed()
{ 
  if(key== 's' && ( gameState==INTRO || gameState==GAMEOVER || gameState == WIN)) 
  {
    file.stop();
    gameState=PLAY;    
    init();
  }
  
  if(key== 'i' && ( gameState==INTRO)) 
  {
    gameState = INSTRUCT;
  }else
  if (keyPressed &&  gameState==INSTRUCT){
    gameState = INTRO;
  }
  
  if(key== 'm' && ( gameState==GAMEOVER || gameState==WIN)) 
  {
    gameState = INTRO;
    file.play();
  }
  
  if(key== 'c' && ( gameState==INTRO || gameState==GAMEOVER || gameState==WIN)) 
  {
    gameState = CREDITS;      
  }else
  if (keyPressed && gameState==CREDITS){
    gameState = INTRO;
  }
 

}

void drawScreen(String title, String instructions) 
{
  background(0,0,0);
  
  // draw title
  fill(255,0,0);
  textSize(60);
  textAlign(CENTER, BOTTOM);
  text(title, width/2, height/2);
  
  // draw instructions
  fill(255,255,255);
  textSize(32);
  textAlign(CENTER, TOP);
  text(instructions, width/2, height/2);
}
  
