//Class for right corner i.e if the square is on the right of the creeps
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
    fill(255);
    translate(cornervector.x,cornervector.y);
    rect(0, 0, 50, 50);
    popMatrix();
  }
}