abstract class BaseClass
{
  PVector creepvector;
  PVector forward;
  float speed;
  float health;
  float creeprot;
  
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