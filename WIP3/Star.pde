class Star {
   public float x;
   public float y;
   public float size;
   public Star(float x, float y, float size){
      this.x = x;
      this.y = y;
      this.size = size;
   }
   
   public void move(){
     // This is for the movement of the stars. (Top-Down)
      y += size; 
      
      //if the star is below the bottom of the screen, put it back on top
      if (y > roomHeight)
        y = 0;
   }
}
