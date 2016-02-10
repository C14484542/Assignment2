class Square 
{
  int rectX = 0;
  int rectY = 0;
  int testX, testY;
  color rectColor, baseColor;
  color rectHighlight;
  color rectRed;
  color currentColor;
  boolean rectOver = false;
  boolean rectOn = false;

  Square() 
  {
    rectHighlight = color(175, 100);
    rectRed = color(#278AA8, 25);
    baseColor = color(102);
    currentColor = rectRed;
  }

  void render (int x, int y) {
    rectX = x;
    rectY = y;
    rectColor = color(currentColor);

    update();
    testX = posX();
    testY = posY();

    if (rectOn) {
      fill (rectRed);
    } else if (rectOver) {
      fill(rectHighlight);
    } else {
      fill (rectColor);
    }

    stroke(255, 10);
    rect(rectX, rectY, rectSize, rectSize);
  }

  void update () 
  {

    if (overRect(rectX, rectY)) 
    {
      rectOver = true;
    } else {
      rectOver = false;
    }

    if (mousePressed && rectOver) 
    {
      rectOn = true;
    } else {
      rectOn = false;
    }
  }

  int posX() 
  {
    int a = 0;
    if (mousePressed && rectOn) {
      a = rectX;
    } 
    return a;
  }

  int posY()
  {
    int a = 0;
    if (mousePressed && rectOn) {
      a = rectY;
    } 
    return a;
  }

  boolean overRect (int x, int y) 
  {
    if (mouseX >= x-rectSize/2 && mouseX <= x+rectSize/2 && mouseY >= y-rectSize/2 && mouseY <= y+rectSize/2) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }
}