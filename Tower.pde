//Class for building the towers
class Tower 
{
  PVector towervector = new PVector();
  int Tfr = 0; //timeframe
  int towerRange = 200;
  float aX = 40;
  float aY = 40;
  float angle;
  float towerrot;
  int damage;
  int towerlevel;
  boolean towermenu;
  ArrayList bulletsArray = new ArrayList();
  int towerprice[] = new int[8];

  Tower (float x, float y) {
    towervector.x = x;
    towervector.y = y;
    damage = 1;
    towerlevel = 1;
    towermenu = false;
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
      } else
      {
        towerrot = 0;
      }
    }

    pushMatrix();
    translate(towervector.x, towervector.y);
    rotate(towerrot);
    for (int i = 0; i < towerimg.length; i++)
    {
      if (towerlevel == i + 1)
      {
        image(towerimg[i], 0, 0);
      }
    }
    popMatrix();
  }

  void update()
  {
    for (int i = 0; i < towerimg.length; i++)
    {
      if (i == 0)
      {
        towerprice[i] = 250;
      }
      if (i == 1)
      {
        towerprice[i] = 250 * 2 - 10;
      }
      if (i == 2)
      {
        towerprice[i] = 250 * 3 - 20;
      }
      if (i == 3)
      {
        towerprice[i] = 250 * 4 - 30;
      }
      if (i == 4)
      {
        towerprice[i] = 250 * 5 - 40;
      }
      if (i == 5)
      {
        towerprice[i] = 250 * 6 - 50;
      }
      if (i == 6)
      {
        towerprice[i] = 250 * 7 - 60;
      }
      if (i == 7)
      {
        towerprice[i] = 250 * 8 - 70;
      }
    }

    for (int i = 0; i < objectsArray.size(); i++)
    {
      if (objectsArray.size() > 0) 
      {
        if (dist(((BaseClass)objectsArray.get(i)).creepvector.x, ((BaseClass)objectsArray.get(i)).creepvector.y, towervector.x, towervector.y) < towerRange) 
        {
          Tfr++;
          if (Tfr == 60)
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

        if (dist(((BaseClass)objectsArray.get(i)).creepvector.x, ((BaseClass)objectsArray.get(i)).creepvector.y, ((Bullet)bulletsArray.get(j)).loc.x, ((Bullet)bulletsArray.get(j)).loc.y) < rectSize) 
        {
          bulletsArray.remove(j);
          objectsArray.get(i).health-=damage;
        } else if (((Bullet)bulletsArray.get(j)).loc.x > width || ((Bullet)bulletsArray.get(j)).loc.x < 0 || ((Bullet)bulletsArray.get(j)).loc.y > height || ((Bullet)bulletsArray.get(j)).loc.y < 0) 
        {
          bulletsArray.remove(j);
        }
        if (objectsArray.size() == 0)
        {
          bulletsArray.remove(j);
        }
      }
    }
  }
}