class Title {
  
  void setTitle()  
    {
     stage = 1;

     background(0);
   
     
    }
    
  void drawTitle()
      {
       background(0);
       
       stroke(0);
       textAlign(CENTER);
       textSize(40);
       fill(255, 0, 0);
       text("STAR HAWK", 450,450);
       fill(255);
       text("PRESS s TO START\n PRESS c FOR CREDITS\nPRESS i FOR INSTRUCTIONS",450,510);
      }

}
