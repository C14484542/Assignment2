class Creeps extends BaseClass
{
  PImage creep;

  Creeps()
  {
    this.speed = 2;
    this.health = 20;
    this.creep = loadImage("creep1.png");
    this.creep.resize(50,50);
    
    this.forward = new PVector(1, 0);
    this.creepvector.x = 0;
    this.creepvector.y = 0;
  }


  void render()
  {
    forward.x = sin(creeprot);
    forward.y = -cos(creeprot);
    creepvector.add(forward);
    if (creepvector.x < 200 && creepvector.y < 200) 
    {
      creeprot = PI/2;
    }
    
    if (creepvector.x > 125)
    {
      creeprot -= PI/2;
    }
    
    if (creepvector.y < 75)
    {
      creeprot += PI/2;
    }
    
    if(creepvector.x > 475 && creepvector.y > 50)
    {
      creeprot += PI/2;
    }
    
    if(creepvector.y > 225 && creepvector.x < 500)
    {
      creeprot += PI/2;
    }
   
   
    pushMatrix();
    translate(creepvector.x, creepvector.y);
    rotate(creeprot);
    image(creep, 0, 0);
    popMatrix();
  }
  
  void update()
  {
  }
}