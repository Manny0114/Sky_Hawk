// This is the heroes class. Each hero has a live count, a size, and x and y position.

class Nobby extends Entity{

  public int lives = 6;
  public int shootTimer = 10;
  
  public Nobby(){
    this.width = 50;
    this.height = 50;
    x = roomWidth/2-(ship.width/2);
    y = roomHeight-(ship.height+60);
    team = 1;
  }
  
  public void move(ListIterator<Entity> i){
      shoot(i);
     if (key == CODED) { 
        if (keyCode == LEFT && keyPressed == true) 
        {
            x -= 3; 
            if( x < 0 ) 
              x = 0;
        }
        else if (keyCode == RIGHT && keyPressed == true) 
        {
            x += 3;
            if (x > roomWidth - ship.width)
              x = (roomWidth - ship.width);
        }
    } 
    image(ship, x, y, 60, 60); 
  }
  
  void die(){
   lives --; 
   if (lives <= 0)
     gameover = true;
   x = roomWidth/2-(ship.width/2);
   y = roomHeight-(ship.height+60);
  }
  
  public void shoot(ListIterator<Entity> i){
    
   for (Entity b: entities)
      if (b.team != team && b.checkCollision(this)){
         die();
         b.die();
      }
      
    shootTimer--;
    if (key == ' '  && keyPressed == true && shootTimer < 0) {
      shoot.play();
      shootTimer = 10;
      Bullet b = new Bullet(x + width/2, y, 5, -1, team);
      b.width = 5;
      b.height = 10;
      i.add(b);
    }
  }
    
}
