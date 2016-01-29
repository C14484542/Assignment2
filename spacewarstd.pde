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

Square[] sq = new Square[288];

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

  no_of_creeps = 5;
  creepX = 0;
  creepY = 175;
}

void draw()
{
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
  }
}

void placeCorners()
{
  for (int i = 0; i < cols; i++)
  {
    for (int j =0; j < rows; j++)
    {
      if ((i == 2 && j == 0))
      {
        Corners corner = new Top(i*50, j*50);
        cornersArray.add(corner);
        corner.render();
      }
      else if ((i == 1 && j == 1))
      {
        Corners corner = new Right(i*50, j*50);
        cornersArray.add(corner);
        corner.render();
      }
      else if ((i == 3 && j == 3))
      {
        Corners corner = new Right(i*50, j*50);
        cornersArray.add(corner);
        corner.render();
      }
    }
  }
}