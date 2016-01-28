abstract class BaseClass
{
  PVector creepvector;
  float speed;
  float health;

  // Default constructor
  BaseClass()
  {
    this.speed = 2;
    this.health = 20;
    this.creepvector = new PVector();
  }

  abstract void render();
  abstract void update();
}