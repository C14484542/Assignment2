//Space Wars Tower Defense

PImage space, path, menubg, planet;
PImage[] creepimg = new PImage[13];
PImage[] towerimg = new PImage[8];
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

boolean start = false;
boolean menu = true;
boolean end = false;

ArrayList<Tower> towersArray = new ArrayList<Tower>();
int gold, lives, level;

Square[] sq = new Square[288];
boolean[][] occupied = new boolean[cols][rows];

int maptestX, maptestY;
int placeX, placeY;
int rectSize = 50; 

void setup()
{
  size(1200, 600, P3D);
  imageMode(CENTER);
  rectMode(CENTER);
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
  lives = 10;
  level = 1;

  menubg = loadImage("menubg.png");
  menubg.resize(width, height);
  planet = loadImage("planet.png");
  planet.resize(rectSize, rectSize);

  for (int i = 0; i < creepimg.length; i++)
  {
    creepimg[i] = loadImage("creep" + i + ".png");
    creepimg[i].resize(rectSize, rectSize);
  }

  for (int i = 0; i < towerimg.length; i++)
  {
    towerimg[i] = loadImage("tower" + i + ".png");
    towerimg[i].resize(40, 40);
  }
}

void draw()
{
  maptestX = int(map(mouseX, 0, 1200, 0, 24));
  maptestY = int(map(mouseY, 0, 600, 0, 12));

  if (!start)
  {
    drawMenu();
  }
  if (start)
  {
    menu = false;
    bgrotate += TWO_PI / 2000;
    pushMatrix();
    translate(width/2, height/2);
    rotate(bgrotate);
    image(space, 0, 0);
    popMatrix();
    image(path, width/2, height/2);

    //stats
    pushMatrix();
    fill(255);
    text("LEVEL: " + level, 50, 25);
    text("GOLD: " + gold, 150, 25);
    text("LIVES: " + lives, 300, 25);
    popMatrix();

    //tower menu
    pushMatrix();
    stroke(0);
    fill(127);
    rect(width-rectSize/2, rectSize/2, rectSize, rectSize);
    rect(width-rectSize/2, (rectSize/2) * 3, rectSize, rectSize);
    rect(width-rectSize/2, (rectSize/2) * 5, rectSize, rectSize);
    popMatrix();

    int squareno = 0;
    for (int i = 0; i < cols; i++)
    {
      for (int j = 0; j < rows; j++)
      {
        sq[squareno].render(rectSize/2+i*rectSize, rectSize/2+j*rectSize);
        squareno++;
        if (i == 0 && j == 6)
        {
          image(planet, rectSize/2+i*rectSize, rectSize/2+j*rectSize);
        }

        if (i == 0 && j == 3)
        {
          pushMatrix();
          fill(0);
          text("Start", rectSize/2+i*rectSize, rectSize/2+j*rectSize);
          popMatrix();
        }
      }
    }

    if (end)
    {
      if (lives > 0)
      {
        win();
      } else
      {
        lose();
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
        ((Creeps)objectsArray.get(j)).update();
      }
    }

    if (objectsArray.size() == 0) 
    {
      timer++;
      if (timer == 120) 
      {
        spawntime = 0;
        no_of_creeps += 1;
        timer = 0;
        level++;
      }
    }

    placeCorners();
    checkCollisions();
    setOccupied();
    for (int i=0; i<towersArray.size(); i++) 
    {
      ((Tower)towersArray.get(i)).render();
      ((Tower)towersArray.get(i)).update();
    }

    towerMenu();

    if (level > creepimg.length || lives <= 0)
    {
      start = false;
      end = true;
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
        if (j == 2 || j == 12 || j == 18)
        {
          Corners corner = new Right(rectSize/2+j*rectSize, rectSize/2+i*rectSize);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if

      if (i == 1)
      {
        if (j == 10 || j == 16 || j == 22)
        {
          Corners corner = new Down(rectSize/2+j*rectSize, rectSize/2+i*rectSize);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if

      if (i == 3 && j == 3)
      {
        Corners corner = new Up(rectSize/2+j*rectSize, rectSize/2+i*rectSize);
        cornersArray.add(corner);
        corner.render();
      }//end if

      if (i == 4 && j == 4)
      {
        Corners corner = new Down(rectSize/2+j*rectSize, rectSize/2+i*rectSize);
        cornersArray.add(corner);
        corner.render();
      }//end if

      if (i == 5)
      {
        if (j == 2 || j == 9)
        {
          Corners corner = new Left(rectSize/2+j*rectSize, rectSize/2+i*rectSize);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if

      if (i == 7)
      {
        if (j == 13 || j == 19)

        {
          Corners corner = new Up(rectSize/2+j*rectSize, rectSize/2+i*rectSize);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if

      if (i == 8)
      {
        if (j == 5 || j == 15)
        {
          Corners corner = new Right(rectSize/2+j*rectSize, rectSize/2+i*rectSize);
          cornersArray.add(corner);
          corner.render();
        }//end inner if
      }//end outer if

      if (i == 10 && j == 1)
      {
        Corners corner = new Up(rectSize/2+j*rectSize, rectSize/2+i*rectSize);
        cornersArray.add(corner);
        corner.render();
      }//end if

      if (i == 11 && j == 21)
      {
        Corners corner = new Left(rectSize/2+j*rectSize, rectSize/2+i*rectSize);
        cornersArray.add(corner);
        corner.render();
      }//end if
    }//end inner for
  }//end outer for
}

void checkCollisions()
{
  for (int i = objectsArray.size() - 1; i >= 0; i --)
  {
    BaseClass creep = objectsArray.get(i);
    if (creep instanceof Creeps)
    {
      if (creep.health <= 0)
      {
        objectsArray.remove(creep);
        gold += 50;
      }

      if (creep.creepvector.x < rectSize/2 && creep. creepvector.y > 300)
      {
        lives--;
        objectsArray.remove(creep);
      }
      for (int j = cornersArray.size() - 1; j >= 0; j --)
      {
        Corners corner = cornersArray.get(j);
        if (corner instanceof Up) // Check the type of an object
        {
          if (creep.creepvector.dist(corner.cornervector) < rectSize)
          {
            // Do some casting
            creep.creeprot = 0;
          }//end if
        }//end if

        if (corner instanceof Right) // Check the type of an object
        {
          if (creep.creepvector.dist(corner.cornervector) < rectSize)
          {
            // Do some casting
            creep.creeprot = PI/2;
          }//end if
        }//end if

        if (corner instanceof Left) // Check the type of an object
        {
          if (creep.creepvector.dist(corner.cornervector) < rectSize)
          {
            // Do some casting
            creep.creeprot = PI*3/2;
          }//end if
        }//end if

        if (corner instanceof Down) // Check the type of an object
        {
          if (creep.creepvector.dist(corner.cornervector) < rectSize)
          {
            // Do some casting
            creep.creeprot = PI;
          }//end if
        }//end if
      }//end inner for
    }//end outer if
  }//end outer for
}

void mousePressed()
{

  if (menu)
  {
    for (int i = 0; i < 100; i += 50)
    {
      if (mouseX > width/2 - 50 && mouseX < width/2 + 50 && mouseY > height/2 + i - 15 && mouseY < height/2 + i + 15)
      {
        if (i == 0)
        {
          start = true;
        }
      }
    }
  }
  if (!menu)
  {
    if (gold >= 250) 
    {
      placeX = current_buttonX(maptestX, maptestY);
      placeY = current_buttonY(maptestX, maptestY);
      if (occupied[maptestX][maptestY] == false)
      {
        towersArray.add(new Tower(placeX, placeY));
        gold -= 250;
        occupied[maptestX][maptestY] = true;
        mousePressed = !mousePressed;
      }
    }
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

void drawMenu()
{
  background(menubg);
  noStroke();
  textAlign(CENTER, CENTER);

  for (int i = 0; i < 100; i += 50)
  {
    pushMatrix();
    if (mouseX > width/2 - 50 && mouseX < width/2 + 50 && mouseY > height/2 + i - 15 && mouseY < height/2 + i + 15)
    {
      noFill();
    } else
    {
      fill(127);
    }
    rect(width/2, height/2 + i, 100, 30);
    popMatrix();
  }

  pushMatrix();
  fill(0);
  text("Start", width/2, height/2);
  text("How to play", width/2, height/2 + 50);
  popMatrix();
}

void win()
{
  background(0);
  fill(255);
  text("Congratulations! You won the Space Wars Tower Defense.", width/2, height/2);
}

void lose()
{
  background(0);
  fill(255);
  text("You Lost! You failed to defend your planet from the invaders.", width/2, height/2);
}

//set occupied[][] to true which means towers cannot be built here
void setOccupied()
{
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      //Set the tower menu as occupied
      if (i == 23 && j < 3)
      {
        occupied[i][j] = true;
      }

      //Set the path as occupied
      if (j == 1 && ((i >= 2 && i <= 9) || (i >= 12 && i <= 15) || (i >= 18 && i <= 21)))
      {
        occupied[i][j] = true;
      }
      if (j == 2 && (i == 2 || i == 9 || i == 12 || i == 15 || i == 18 || i == 21))
      {
        occupied[i][j] = true;
      }
      if (j == 3 && (i <=2 || i == 9 || i == 12 || i == 15 || i == 18 || i == 21)) 
      {
        occupied[i][j] = true;
      }
      if (j == 4 && ((i >= 5 && i <= 9) || i == 12 || i == 15 || i == 18 || i == 21)) 
      {
        occupied[i][j] = true;
      }
      if (j == 5 && (i == 5 || i == 12 || i == 15 || i == 18 || i == 21)) 
      {
        occupied[i][j] = true;
      }
      if (j == 6 && (i <= 2 || i == 5 || i == 12 || i == 15 || i == 18 || i == 21)) 
      {
        occupied[i][j] = true;
      }
      if (j == 7 && ( i == 2 || (i >= 5 && i <= 12) || (i >= 15 && i <= 18) || i == 21)) 
      {
        occupied[i][j] = true;
      }
      if ((j == 8 || j == 9) && (i == 2 || i == 21)) 
      {
        occupied[i][j] = true;
      }
      if (j == 10 && i >= 2 && i <= 21)
      {
        occupied[i][j] = true;
      }
    }
  }
}

void towerMenu()
{
  for (int i = towersArray.size() - 1; i >= 0; i --)
  {
    Tower tower = towersArray.get(i);
    if (tower instanceof Tower)
    {
      if (mousePressed)
      {
        if (occupied[maptestX][maptestY] == true)
        {
          if (dist(mouseX, mouseY, tower.towervector.x, tower.towervector.y) < rectSize/2)
          {
            tower.towermenu = true;
          }
        }
      }

      if (tower.towermenu == true)
      {

        pushMatrix();
        stroke(0);
        fill(0);
        if (tower.towerlevel < 8)
        {
          image(towerimg[tower.towerlevel], width-rectSize/2, rectSize/2);
          towerimg[tower.towerlevel].resize(rectSize, rectSize);
        }
        else
        {
          text("Max \n Level", width-rectSize/2, rectSize/2);
        }
        rect(width-rectSize/2, 75, rectSize, rectSize);
        rect(width-rectSize/2, 125, rectSize, rectSize);
        popMatrix();

        if (dist(mouseX, mouseY, width-rectSize/2, rectSize/2) < rectSize/2)
        {
          pushMatrix();
          fill(255);
          text("Upgrade tower", width-(rectSize*2), rectSize/2);
          popMatrix();
        }

        if (mousePressed)
        {
          if (dist(mouseX, mouseY, width-rectSize/2, rectSize/2) < rectSize/2)
          {
            if (tower.towerlevel < 8)
            {
              tower.towerlevel++;
              tower.damage++;
              tower.towermenu = false;
            }
          }

          if (dist(mouseX, mouseY, width-rectSize/2, 75) < rectSize/2)
          {
            towersArray.remove(tower);
          }

          if (dist(mouseX, mouseY, width - rectSize/2, 125) < rectSize/2)
          {
            tower.towermenu = false;
          }
        }
      }
    }
  }
}