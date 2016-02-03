//Class for making the creeps go up if there is a collision 
class Up extends Corners
{
  // Default constructor
  Up(int cx, int cy)
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