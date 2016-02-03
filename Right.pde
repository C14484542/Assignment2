//Class for making the creeps go right if there is a collision 
class Right extends Corners
{
  //Default constructor
  Right(int cx, int cy)
  {
    this.cornervector.x = cx;
    this.cornervector.y = cy;
  }
  
  void render()
  {
    pushMatrix();
    noFill();
    translate(cornervector.x,cornervector.y);
    rect(0, 0, 50, 50);
    popMatrix();
  }
}