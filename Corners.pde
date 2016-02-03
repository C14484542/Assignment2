//Class for the corners of the path so that if there are collisions, the creeps will automatically rotate and follow the path.
abstract class Corners
{
  PVector cornervector;

  // Default constructor
  Corners()
  { 
    cornervector = new PVector(0, 0);
  }

  abstract void render();
}