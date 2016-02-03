class Bullet
{
  PVector loc = new PVector();
  PVector center;
  PVector bulletforward;
  float dirX, dirY;
  PImage bullet;

  Bullet(float x, float y) 
  {
    loc.x = x;
    loc.y = y;
    bulletforward = new PVector(loc.x, loc.y);
    bullet = loadImage("bullet.png");
  }

  void render(float a, float b) 
  {
    dirX = a;
    dirY = b;
    center = new PVector(dirX, dirY);
    image(bullet, loc.x, loc.y);
    PVector velocity = PVector.sub(center, bulletforward);
    loc.add(new PVector(velocity.x/20, velocity.y/20));
  }
}