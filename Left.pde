//Class for making the creeps go left if there is a collision 
class Left extends Corners
{
  //Default constructor
  Left(int cx, int cy)
  {
    this.cornervector.x = cx;
    this.cornervector.y = cy;
  }

  void render()
  {
    pushMatrix();
    noFill();
    rect(cornervector.x, cornervector.y, 50, 50);
    popMatrix();
  }
}