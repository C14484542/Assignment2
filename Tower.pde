//Class for building the towers
class Tower 
{
  PVector towervector = new PVector();
  PImage towerimg;
  int Tfr = 0; //timeframe
  int towerRange = 200;
  float aX = 40;
  float aY = 40;
  float angle;
  float towerrot;
  ArrayList bulletsArray = new ArrayList();

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
      if (dist(((BaseClass)objectsArray.get(0)).creepvector.x, ((BaseClass)objectsArray.get(0)).creepvector.y, towervector.x, towervector.y) < towerRange) 
      {        
        angle = atan2((((BaseClass)objectsArray.get(0)).creepvector.y)-towervector.y, (((BaseClass)objectsArray.get(0)).creepvector.x)-towervector.x);
        aX = (40 * cos(angle)) + towervector.x;
        aY = (40 * sin(angle)) + towervector.y;
        towerrot = angle + PI/2;
      }
      else
      {
        towerrot = 0;
      }
    }

    pushMatrix();
    translate(towervector.x, towervector.y);
    rotate(towerrot);
    image(towerimg, 0, 0);
    popMatrix();
  }

  void shoot()
  {
    for (int i = 0; i < objectsArray.size(); i++)
    {
      if (objectsArray.size() > 0) 
      {
        if (dist(((BaseClass)objectsArray.get(i)).creepvector.x, ((BaseClass)objectsArray.get(i)).creepvector.y, towervector.x, towervector.y) < towerRange) 
        {
          Tfr++;
          if (Tfr == 60 && objectsArray.get(i).health > 0)
          {
            bulletsArray.add(new Bullet(towervector.x, towervector.y));  
            Tfr = 0;
          }
        }
      }

      for (int j = 0; j < bulletsArray.size(); j++) 
      {
        //image(towerimg, towervector.x, towervector.y);
        ((Bullet)bulletsArray.get(j)).render(aX, aY);

        if (dist(((BaseClass)objectsArray.get(i)).creepvector.x, ((BaseClass)objectsArray.get(i)).creepvector.y, ((Bullet)bulletsArray.get(j)).loc.x, ((Bullet)bulletsArray.get(j)).loc.y) < 50) 
        {
          bulletsArray.remove(j);
          objectsArray.get(i).health--;
        } 
        else if (((Bullet)bulletsArray.get(j)).loc.x > width || ((Bullet)bulletsArray.get(j)).loc.x < 0 || ((Bullet)bulletsArray.get(j)).loc.y > height || ((Bullet)bulletsArray.get(j)).loc.y < 0) 
        {
          bulletsArray.remove(j);
        }
        if(objectsArray.size() == 0)
        {
          bulletsArray.remove(j);
        }
      }
    }
  }
}