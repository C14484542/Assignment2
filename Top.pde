//Class for top corner i.e if the square is on the top the creeps
class Top extends Corners
{
  // Default constructor
  Top(int cx, int cy)
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