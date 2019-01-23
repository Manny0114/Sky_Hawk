class Entity {
  public int x;
  public int y;
  public int width;
  public int height;
  public boolean isDead = false;
  public int team;
  int health = 1;
  
  void die(){
   isDead = true; 
  }
  
  boolean checkCollision(Entity entity){
     return (this.x < entity.x + entity.width && 
         this.x + this.width > entity.x &&
         this.y < entity.y +entity.height && 
         this.y+this.height > entity.y);
  }
  
  void move(ListIterator<Entity> i){
    
  }
}
