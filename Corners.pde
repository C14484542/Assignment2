//Class for the corners of the path so that if there are collisions, the creeps will automatically rotate and follow the path.
abstract class Corners
{
  int x, y;
  
  // Default constructor
  Corners()
  { 
    this.x = 0;
    this.y = 0;
  }

  abstract void render();
}