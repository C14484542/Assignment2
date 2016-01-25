class Creeps
{
  PImage creep;
  float creepX, creepY;
  float speed;
  float health;
  
  Creeps(float creephealth)
  {
    speed = 2;
    health = creephealth;
    creep = loadImage("creep1.png");
    creep.resize(50,50);
    creepY = 175;
  }
  
  
  void render()
  {
    if (creepX < 125) 
    {
      creepX += speed;
    }

    pushMatrix();
    translate(creepX,creepY);
    image(creep,0,0);
    popMatrix();

  }
}