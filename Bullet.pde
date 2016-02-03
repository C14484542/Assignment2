class Bullet
{
  PVector loc = new PVector();
  PVector center;
  PVector towervector;
  float dirX, dirY;
  PImage bullet;

  Bullet(float x, float y) 
  {
    loc.x = x;
    loc.y = y;
    towervector = new PVector(loc.x, loc.y);
    bullet = loadImage("bullet.png");
  }

  void render(float a, float b) 
  {
    dirX = a;
    dirY = b;
    center = new PVector(dirX, dirY);
    image(bullet, loc.x, loc.y);
    PVector velocity = PVector.sub(center, towervector);
    loc.add(new PVector(velocity.x/2, velocity.y/2));
  }
}