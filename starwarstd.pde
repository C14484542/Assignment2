//Star Wars Tower Defense

PImage space, path;
float bgrotate;

int cols = 24;
int rows = 12;
int grid [][] = new int[cols][rows];

boolean start = true;

Square[] sq = new Square[288];

void setup()
{
  size(1200, 600, P3D);
  //imageMode(CENTER);
  //rectMode(CENTER);
  smooth();
  space = loadImage("background.jpg");
  space.resize(width, height + 500);
  path = loadImage("path.png");
  path.resize(width,600);

  for (int i = 0; i < 288; i++)
  {
    sq[i] = new Square();
  }
}

void draw()
{
  if (!start)
  {
    image(space, width/2, height/2);
  }
  if (start)
  {
    pushMatrix();
    image(space, 0, 0);
    popMatrix();
    image(path,0,0);

    int squareno = 0;
    for (int i = 0; i < cols; i++)
    {
      for (int j = 0; j < rows; j++)
      {
        sq[squareno].render((i*50), (j*50));
        squareno++;
      }
    }
  }
}