//Class for building the towers
class Tower 
{
  PVector towervector = new PVector();
  PImage towerimg;

  Tower (float x, float y) {
    towervector.x = x;
    towervector.y = y;
    towerimg = loadImage("tower1.png");
    towerimg.resize(40,40);
  }

  void render() 
  {
    image(towerimg,towervector.x,towervector.y);
  }
}