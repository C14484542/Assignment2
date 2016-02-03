//Class for building the towers
class Tower 
{
  PVector towervector = new PVector();
  PImage towerimg;
  ArrayList bullet = new ArrayList();
  int Tfr = 0; //timeframe
  int inReach = 200;
  float aX = 40;
  float aY = 40;
  float angle;

  Tower (float x, float y) {
    towervector.x = x;
    towervector.y = y;
    towerimg = loadImage("tower1.png");
    towerimg.resize(40, 40);
  }

  void render() 
  {
    for (int i=0; i < objectsArray.size(); i++) 
    {
      if (dist(((BaseClass)objectsArray.get(0)).creepvector.x, ((BaseClass)objectsArray.get(0)).creepvector.y, towervector.x, towervector.y) < inReach) 
      {        
        angle = atan2((((BaseClass)objectsArray.get(0)).creepvector.y)-towervector.y, (((BaseClass)objectsArray.get(0)).creepvector.x)-towervector.x);
        aX = (40 * cos(angle)) + towervector.x;
        aY = (40 * sin(angle)) + towervector.y;
      }
    }

    pushMatrix();
    translate(towervector.x, towervector.y);
    //rotate(angle);
    //image(towerimg, 0, 0);
    popMatrix();
  }

  void shoot()
  {
    if (objectsArray.size()>0) 
    {
      if (dist(((BaseClass)objectsArray.get(0)).creepvector.x, ((BaseClass)objectsArray.get(0)).creepvector.y, towervector.x, towervector.y) < inReach) 
      {
        Tfr++;
        if (Tfr == 20) 
        {
          bullet.add(new Bullet(towervector.x, towervector.y));  
          Tfr = 0;
        }
      }

      for (int i=0; i<bullet.size(); i++) 
      {
        //image(towerimg, towervector.x, towervector.y);
        ((Bullet)bullet.get(i)).render(aX, aY);
        pushMatrix();
        translate(towervector.x, towervector.y);
        rotate(angle+PI/2);
        image(towerimg, 0, 0);
        popMatrix();
      }
    }
  }
}