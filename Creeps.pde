class Creeps extends BaseClass
{
  PImage creep;

  Creeps()
  {
    this.speed = 2;
    this.health = 20;
    this.creep = loadImage("creep1.png");
    this.creep.resize(50,50);
    
    this.forward = new PVector(100, 0);
    this.creepvector.x = 0;
    this.creepvector.y = 175;
    this.creeprot = PI/2;
  }


  void render()
  {
    forward.x = sin(creeprot);
    forward.y = -cos(creeprot);
    forward.mult(speed);
    creepvector.add(forward);
    
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