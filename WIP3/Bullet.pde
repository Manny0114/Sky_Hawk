class Bullet extends Entity{
  public float speed;
  public int direction = 1;
  
  public Bullet(int x, int y, float speed, int direction, int team){
    this.x = x;
    this.y = y;
    this.speed = speed;    
    this.team = team;
    this.direction = direction;
    width = 10;
    height = 10;
  }
  
  public boolean isAttacking = false;
  
  public void move(ListIterator<Entity> i){
    for (Entity b: entities)
      if (b.team != team && b.checkCollision(this)){
        if (b.health<=0)
        b.die();
         die();
         
      }
    
    
    fill(color(255,255,255));
    rect(x, y, width, height);
    
    y += speed*direction;
    if (y > roomHeight){
      die();
    }
    if (x < 0){
      die();
    }
  }
  
}
