// This is for each enemy, Each enemy contains a speed, shootspeed, and a size.
class Enemy extends Entity{
  PImage sprite;
  public float speed, shootSpeed;
  public int direction = 1;
  
  public Enemy(int x, int y, float speed, PImage sprite, float shootSpeed){
    this.x = x;
    this.y = y;
    this.sprite = sprite;
    this.speed = speed;
    this.width = 50;
    this.height = 50;
    this.shootSpeed = shootSpeed;
    team = 2;
  }
  
  public boolean isAttacking = false;
  
  void die(){
    super.die();
    println(beeNum);
    
    if (score >= highScore){
      passHighscore = true;
      highScore = score;
    }
    
    if (sprite == beeShip)
      score ++;
    if (sprite == waspShip){
      score += 4;
    }
  }
  
  public void move(ListIterator<Entity> i){
    if (Math.round(Math.random()*shootSpeed) == 1){
      pew.play();
      Bullet b = new Bullet(x + width/2, y, 5, 1, team);
      b.width = 5;
      b.height = 10;
      i.add((Entity) b);
    }
    
    for (Entity b: entities)
      if (b.team != team && b.checkCollision(this)){
         health --;
         if (health <= 0)
           die();
         b.die();
      }
    
    image(sprite, x, y, 50, 50);
    
    x += speed*direction;
    if (x > roomWidth-this.width){
      direction = -1;
      y += 50;
    }
    if (x < 0){
      direction = 1;
      y += 50;
    }
  }
  
}
