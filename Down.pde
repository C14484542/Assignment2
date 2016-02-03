//Class for making the creeps go down if there is a collision 
class Down extends Corners
{
  //Default constructor
  Down(int cx, int cy)
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