//Class for left corner i.e if the square is on the left of the creeps
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
    fill(255);
    rect(cornervector.x, cornervector.y, 50, 50);
    popMatrix();
  }
}