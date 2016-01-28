//Star Wars Tower Defense

PImage space, path;
float bgrotate;

int cols = 24;
int rows = 12;
int grid [][] = new int[cols][rows];


ArrayList<BaseClass> objectsArray = new ArrayList<BaseClass>();

ArrayList creeps = new ArrayList();
float creephealth;
float creepX, creepY;
int no_of_creeps;
int time;
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

  creephealth = 100;
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
 
    int squareno = 0;
    for (int i = 0; i < cols; i++)
    {
      for (int j = 0; j < rows; j++)
      {
        sq[squareno].render((i*50), (j*50));
        squareno++;
      }
    }

    time++;
    if (time == 60)
    {
       creeps.add(new Creeps());
      if (creeps.size() < no_of_creeps)
      {
        time = 0;
      } else
      {
        time = 100;
      }
    }

    for (int j=0; j<creeps.size(); j++) 
    {
      if (creeps.size()>0)
      {
        ((Creeps)creeps.get(j)).render();
      }
    }

    if (creeps.size() == 0) 
    {
      timer++;
      if (timer == 120) 
      {
        time = 0;
        creephealth += 35;
        no_of_creeps += 1;
        timer = 0;
      }
    }
  }
}