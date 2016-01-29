//Class for right corner i.e if the square is at the right of the creeps
class Right extends Corners
{
  //Default constructor
  Right(int cx, int cy)
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