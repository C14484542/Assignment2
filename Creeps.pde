class Creeps extends BaseClass
{
  PImage creep;
  PVector position;
  PVector forward;
  float speed;
  float health;
  float creeprot;

  Creeps()
  {
    this.speed = 2;
    this.health = 20;
    this.creep = loadImage("creep1.png");
    this.creep.resize(50,50);
    
    position = new PVector(0,0);
    forward = new PVector(1, 0);
    this.position.x = 0;
    this.position.y = 0;
  }


  void render()
  {
    forward.x = sin(creeprot);
    forward.y = -cos(creeprot);
    position.add(forward);
    if (position.x < 200 && position.y < 200) 
    {
      creeprot = PI/2;
    }
    
    if (position.x > 125)
    {
      creeprot -= PI/2;
    }
    
    if (position.y < 75)
    {
      creeprot += PI/2;
    }
    
    if(position.x > 475 && position.y > 50)
    {
      creeprot += PI/2;
    }
    
    if(position.y > 225 && position.x < 500)
    {
      creeprot += PI/2;
    }
   
   
    pushMatrix();
    translate(position.x, position.y);
    rotate(creeprot);
    image(creep, 0, 0);
    popMatrix();
  }
  
  void update()
  {
  }
}