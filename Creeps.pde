class Creeps extends BaseClass
{

  Creeps()
  {
    this.speed = 1;
    this.health = 20;
    this.forward = new PVector(1, 0);
    this.creepvector.x = 0;
    this.creepvector.y = 175;
    this.creeprot = PI/2;
  }


  void render()
  {    
    pushMatrix();
    translate(creepvector.x, creepvector.y);
    rotate(creeprot);
    for(int i = 0; i < creepimg.length; i++)
    {
      if(level == i + 1)
      {
        image(creepimg[i], 0, 0);
      }
    }
    popMatrix();
  }
  
  void update()
  {
    forward.x = sin(creeprot);
    forward.y = -cos(creeprot);
    forward.mult(speed);
    creepvector.add(forward);
  }
}