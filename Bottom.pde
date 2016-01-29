//Class for bottom corner i.e if the square is on the bottom of the creeps
class Bottom extends Corners
{
  //Default constructor
  Bottom(int cx, int cy)
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