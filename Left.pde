//Class for left corner i.e if the square is on the left of the creeps
class Left extends Corners
{
  //Default constructor
  Left(int cx, int cy)
  {
    this.x = cx;
    this.y = cy;
  }
  
  void render()
  {
    pushMatrix();
    fill(255);
    rect(x, y, 50, 50);
    popMatrix();
  }
}