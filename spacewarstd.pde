//Space Wars Tower Defense

PImage space, path;
float bgrotate;

int cols = 24;
int rows = 12;
int grid [][] = new int[cols][rows];


ArrayList<BaseClass> objectsArray = new ArrayList<BaseClass>();
ArrayList<Corners> cornersArray = new ArrayList<Corners>();

float creepX, creepY;
int no_of_creeps;
int spawntime;
int timer = 0;

boolean start = true;

ArrayList<Tower> towersArray = new ArrayList<Tower>();
ArrayList<Bullet> bulletsArray = new ArrayList<Bullet>();
int gold;

Square[] sq = new Square[288];

int maptestX, maptestY;
int placeX, placeY;

void setup()
{
  size(1200, 600, P3D);
  imageMode(CENTER);
  //rectMode(CENTER);
  smooth();
  space = loadImage("background.jpg");
  space.resize((int)(width * 1.5), (int)(width * 1.5));
  path = loadImage("path.png");
  path.resize(width, height);

  for (int i = 0; i < 288; i++)
  {
    sq[i] = new Square();
  }

  //Set up grid ID number
  int gridid = 0;
  for (int i = 0; i < cols; i++) 
  {
    for (int j = 0; j < rows; j++) 
    {
      grid[i][j] = gridid;
      gridid++;
    }
  }

  no_of_creeps = 5;
  gold = 1000;
}

void draw()
{
  maptestX = int(map(mouseX, 0, 1200, 0, 24));
  maptestY = int(map(mouseY, 0, 600, 0, 12));

  if (!start)
  {
    image(space, width/2, height/2);
  }
  if (start)
  {
    bgrotate += TWO_PI / 2000;
    pushMatrix();
    translate(width/2, height/2);
    rotate(bgrotate);
    image(space, 0, 0);
    popMatrix();
    image(path, width/2, height/2);

    placeCorners();

    int squareno = 0;
    for (int i = 0; i < cols; i++)
    {
      for (int j = 0; j < rows; j++)
      {
        sq[squareno].render((i*50), (j*50));
        squareno++;
      }
    }

    spawntime++;
    if (spawntime == 60)
    {
      BaseClass creep = new Creeps();
      objectsArray.add(creep);

      if (objectsArray.size() < no_of_creeps)
      {
        spawntime = 0;
      } else
      {
        spawntime = 100;
      }
    }

    for (int j=0; j<objectsArray.size(); j++) 
    {
      if (objectsArray.size()>0)
      {
        ((Creeps)objectsArray.get(j)).render();
      }
    }

    /* if (creeps.size() == 0) 
     {
     timer++;
     if (timer == 120) 
     {
     spawntime = 0;
     no_of_creeps += 1;
     timer = 0;
     }
     }*/
    checkCollisions();

    for (int i=0; i<towersArray.size(); i++) {

      ((Tower)towersArray.get(i)).render();
      ((Tower)towersArray.get(i)).shoot
        ();
    }
  }
}

void placeCorners()
{
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j < cols; j++)
    {
      if (i == 0)
      {
        if (j == 2 || j == 9 || j == 12 || j == 15 || j == 18 || j == 21)
        {
          Corners corner = new Top(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if
      else if (i == 1)
      {
        if (j == 1 || j == 11 || j == 17)
        {
          Corners corner = new Left(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end if
        else if (j == 10 || j == 16 || j == 22)
        {
          Corners corner = new Right(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if 
      else if (i == 4)
      {
        if (j == 2)
        {
          Corners corner = new Bottom(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end if
        else if (j == 4)
        {
          Corners corner = new Left(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        } else if (j == 10)
        {
          Corners corner = new Right(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if
      else if (i == 7)
      {
        if (j == 4 || j == 14)
        {
          Corners corner = new Left(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end if
        else if (j == 13 || j == 19)
        {
          Corners corner = new Right(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if
      
      else if (i == 8)
      {
        if (j == 5 || j == 12 || j == 15 || j == 18)
        {
          Corners corner = new Bottom(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }
      }
      
      else if (i == 10)
      {
        if (j == 1)
        {
          Corners corner = new Left(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end if

        else if (j == 22)
        {
          Corners corner = new Right(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if

      else if (i == 11)
      {
        if (j == 2 || j == 21)
        {
          Corners corner = new Bottom(j*50, i*50);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if

      if ( i == 3 && j == 3)
      {
        Corners corner = new Right(j*50, i*50);
        cornersArray.add(corner);
        corner.render();
      }
    }//end for
  }
}

void checkCollisions()
{
  for (int i = objectsArray.size() - 1; i >= 0; i --)
  {
    BaseClass creep = objectsArray.get(i);
    if (creep instanceof Creeps)
    {
      for (int j = cornersArray.size() - 1; j >= 0; j --)
      {
        Corners corner = cornersArray.get(j);
        if (corner instanceof Right) // Check the type of an object
        {
          if (creep.creepvector.dist(corner.cornervector) < 35)
          {
            // Do some casting
            creep.creeprot = 0;
          }//end if
        }//end if

        if (corner instanceof Top) // Check the type of an object
        {
          if (creep.creepvector.dist(corner.cornervector) < 80)
          {
            // Do some casting
            creep.creeprot = PI/2;
          }//end if
        }//end if
      }//end inner for

      for (int k = bulletsArray.size() - 1; k >= 0; k--)
      {
        Bullet bullet = bulletsArray.get(k);
        if (bullet instanceof Bullet)
        {
          if (creep.creepvector.dist(bullet.towervector) < 10)
          {
            bulletsArray.remove(bullet);
          }//end if
        }//end if
      }//end inner for
    }//end outer if
  }//end outer for
}

void mousePressed()
{

  if (gold >= 250) 
  {
    placeX = current_buttonX(maptestX, maptestY) + 25;
    placeY = current_buttonY(maptestX, maptestY) + 25;
    towersArray.add(new Tower(placeX, placeY));
    gold -= 250;
  }
}

int current_buttonX (int x, int y) 
{
  int xpos = 0;
  int buttonChoice = grid[x][y];
  xpos = sq[buttonChoice].rectX;
  return xpos;
}

int current_buttonY (int x, int y) 
{
  int ypos = 0;
  int buttonChoice = grid[x][y];
  ypos = sq[buttonChoice].rectY;
  return ypos;
}