//Class for bottom corner i.e if the square is on the bottom of the creeps
class Bottom extends Corners
{
  //Default constructor
  Bottom(int cx, int cy)
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