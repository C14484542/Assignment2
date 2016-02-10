//Space Wars Tower Defense

PImage space, path, menubg, planet, sell, cancel;
PImage[] creepimg = new PImage[13]; //different images for creep levels
PImage[] towerimg = new PImage[8]; // different images for tower levels
float bgrotate; //rotating the background

int cols = 24;
int rows = 12;
int grid [][] = new int[cols][rows];

ArrayList<BaseClass> objectsArray = new ArrayList<BaseClass>();
ArrayList<Corners> cornersArray = new ArrayList<Corners>();
ArrayList<Tower> towersArray = new ArrayList<Tower>();

//spawning creeps
int no_of_creeps;
int spawntime;
int timer = 0;

boolean start = false;
boolean menu = true;
boolean end = false;
boolean name = false;
boolean showhs = false;
boolean[][] occupied = new boolean[cols][rows];

int gold, lives, level, score; //stats

//drawing squares for grid
Square[] sq = new Square[288];
int rectSize = 50; 

//for building towers
int maptestX, maptestY;
int placeX, placeY;

//input and output
String userName;
String[] highsc;
int highscore;

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

  //adding all squares (cols * rows)
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

  //stats
  gold = 1000;
  lives = 10;
  level = 1;
  score = 0;

  //loading images
  menubg = loadImage("menubg.png");
  menubg.resize(width, height);
  planet = loadImage("planet.png");
  planet.resize(rectSize, rectSize);
  sell = loadImage("sell.png");
  sell.resize(rectSize, rectSize);
  cancel = loadImage("cancel.png");
  cancel.resize(rectSize, rectSize);

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

  userName = "";
  highscore = 0;
}

void draw()
{
  //mapping the coordinate of mouseX and mouseY to cols and rows
  maptestX = int(map(mouseX, 0, 1200, 0, 24));
  maptestY = int(map(mouseY, 0, 600, 0, 12));
  
  if (!start && !end)
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
    text("GOLD: " + gold, 250, 25);
    text("LIVES: " + lives, 450, 25);
    text("SCORE: " + score, 650, 25);
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
          //end of path
          image(planet, rectSize/2+i*rectSize, rectSize/2+j*rectSize);
        }

        if (i == 0 && j == 3)
        {
          //start of path
          pushMatrix();
          fill(0);
          text("Start", rectSize/2+i*rectSize, rectSize/2+j*rectSize);
          popMatrix();
        }
      }
    }
    
    //creeps spawn every second
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
    
    //drawing creeps
    for (int j=0; j<objectsArray.size(); j++) 
    {
      if (objectsArray.size()>0)
      {
        ((Creeps)objectsArray.get(j)).render();
        ((Creeps)objectsArray.get(j)).update();
      }
    }
    
    //spawning next level creeps
    if (objectsArray.size() == 0) 
    {
      timer++;
      if (timer == 120) 
      {
        spawntime = 0;
        no_of_creeps += 2;
        timer = 0;
        level++;
      }
    }
    
    placeCorners();
    checkCollisions();
    setOccupied();
    
    //draw towers
    for (int i=0; i<towersArray.size(); i++) 
    {
      ((Tower)towersArray.get(i)).render();
      ((Tower)towersArray.get(i)).update();
    }

    towerMenu();

    //ending the game
    if (level > creepimg.length || lives <= 0)
    {
      start = false;
      end = true;
    }
  }

  if (!start && end)
  {
    //comparing score to highscore and saving it into a file
    String[] highsc = split(userName + "," + score, ',');
    String lines[] = loadStrings("highscore.txt");
    for (int j = 0; j < lines.length; j++) 
    {
      if (j == 1)
      {
        highscore = Integer.parseInt(lines[j]);
      }
    }
    if (score > highscore)
    {
      saveStrings("highscore.txt", highsc);
    }
    if (lives > 0)
    {
      win();
    } else
    {
      lose();
    }
  }

  if (showhs)
  {
    showHighscore();
  }
}

//place corners for collision so that creeps will change direction
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

//checking collisions between elements
void checkCollisions()
{
  for (int i = objectsArray.size() - 1; i >= 0; i --)
  {
    BaseClass creep = objectsArray.get(i);
    if (creep instanceof Creeps)
    {
      //if tower kills the creep
      if (creep.health <= 0)
      {
        objectsArray.remove(creep);
        gold += 50 + (10*level);
        score += 10;
      }
      
      //if reaches end of path
      if (creep.creepvector.x < rectSize/2 && creep. creepvector.y > 300)
      {
        lives--;
        objectsArray.remove(creep);
      }
      
      //if creep collides with corners then change direction
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
    if (name == false)
    {
      if (dist(mouseX, mouseY, width/2, height/2 + 50) < 25 )
      {
        name = true;
      }
    } else
    {
      for (int i = 0; i <=50; i += 50)
      {
        if (mouseX > width/2 - 50 && mouseX < width/2 + 50 && mouseY > height/2 + i - 15 && mouseY < height/2 + i + 15)
        {
          if (i == 0)
          {
            start = true;
          }

          if (i == 50)
          {
            showhs = true;
          }
        }
      }
    }
  }
  if (!menu)
  {
    //adding towers
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

  if (showhs)
  {
    if (dist(mouseX, mouseY, width - rectSize/2, rectSize/2) < 25)
    {
      showhs = false;
    }
  }
}

//returns X coordinate of new tower
int current_buttonX (int x, int y) 
{
  int xpos = 0;
  int buttonChoice = grid[x][y];
  xpos = sq[buttonChoice].rectX;
  return xpos;
}

//returns Y coordinate of new tower
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

  if (name == false)
  {
    pushMatrix();
    fill(0);
    rect(width/2, height/2 + 50, 50, 50);
    popMatrix();

    pushMatrix();
    fill(255);
    text("Please enter your name: " + userName, width/2, height/2);
    text("Go", width/2, height/2 + 50);
    popMatrix();
  }

  if (name == true)
  {
    pushMatrix();
    textSize(20);
    fill(255);
    text("Hello " + userName + " Welcome to Space Wars Tower Defense!", width/2, height/2 - 100);
    popMatrix();

    for (int i = 0; i <= 50; i += 50)
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
    textSize(15);
    text("Start", width/2, height/2);
    text("Highscore", width/2, height/2 + 50);
    popMatrix();
  }
}

void win()
{
  background(0);
  fill(255);
  text("Congratulations! You won the Space Wars Tower Defense.", width/2, height/2);
  text("Score: " + score, width/2, height/2 + 30);
}

void lose()
{
  background(0);
  fill(255);
  text("You Lost! You failed to defend your planet from the invaders.", width/2, height/2);
  text("Score: " + score, width/2, height/2 + 30);
}

//set occupied[][] to true which means towers cannot be built here
void setOccupied()
{
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      //Set stats as occupied
      if (j == 0 && (i == 0 || i == 1 || i == 4 || i == 5 || i == 8 || i == 9 || i == 12 || i == 13))
      {
        occupied[i][j] = true;
      }
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

//drawing tower menu
void towerMenu()
{
  for (int i = towersArray.size() - 1; i >= 0; i --)
  {
    Tower tower = towersArray.get(i);
    if (tower instanceof Tower)
    {
      //if tower is clicked, show the tower menu
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
        } else
        {
          text("Max \n Level", width-rectSize/2, rectSize/2);
        }
        image(sell, width-rectSize/2, (rectSize/2) * 3);
        image(cancel, width-rectSize/2, (rectSize/2) * 5);
        popMatrix();

        if (dist(mouseX, mouseY, width-rectSize/2, rectSize/2) < rectSize/2)
        {
          pushMatrix();
          fill(255);
          text("Upgrade tower: Price:" + tower.towerprice[tower.towerlevel], width-(rectSize*4), rectSize/2);
          popMatrix();
        } else if (dist(mouseX, mouseY, width-rectSize/2, (rectSize/2) * 3) < rectSize/2)
        {
          pushMatrix();
          fill(255);
          text("Sell tower: Price:" + tower.towerprice[tower.towerlevel-1], width-(rectSize*4), (rectSize/2) * 3);
          popMatrix();
        }


        if (mousePressed)
        {
          if (dist(mouseX, mouseY, width-rectSize/2, rectSize/2) < rectSize/2)
          {
            if (tower.towerlevel < 8)
            {
              if (gold >= tower.towerprice[tower.towerlevel])
              {
                tower.towerlevel++;
                tower.damage+=2;
                gold-=tower.towerprice[tower.towerlevel-1];
                tower.towermenu = false;
              }
            }
          }

          if (dist(mouseX, mouseY, width-rectSize/2, 75) < rectSize/2)
          {
            towersArray.remove(tower);
            occupied[(int)tower.towervector.x/50][(int)tower.towervector.y/50] = false;
            for (int j = 1; j < tower.towerlevel; j++)
            {
              gold+=tower.towerprice[tower.towerlevel-j];
            }
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

//for getting input from keyboard
void keyPressed() 
{
  if (name == false)
  {
    if (keyCode == BACKSPACE) 
    {
      if (userName.length() > 0) 
      {
        userName = userName.substring(0, userName.length()-1);
      }
    } else if (keyCode == DELETE) 
    {
      userName = "";
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && keyCode != BACKSPACE) 
    {
      userName = userName + key;
    }
  }
}

void showHighscore()
{
  background(0);
  String lines[] = loadStrings("highscore.txt");
  for (int j = 0; j < lines.length; j++) 
  {
    pushMatrix();
    fill(255);
    textSize(20);
    text("Highscore: ", width/2, 50);
    text("Name", width/2 - 100, height/2 - 50);
    text("Score", width/2 +100, height/2 - 50);
    text(lines[0], width/2 - 100, height/2);
    text(lines[1], width/2 +100, height/2);
    popMatrix();
  }
  
  image(cancel,width-25,25);
}