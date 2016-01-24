class Square 
{
  int rectX = 0;
  int rectY = 0;
  int testX, testY;
  int rectSize = 50; 
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

    update(mouseX, mouseY);
    testX = posX(mouseX, mouseY);
    testY = posY(mouseX, mouseY);

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

  void update (int x, int y) {

    if (overRect(rectX, rectY, rectSize, rectSize)) {
      rectOver = true;
    } else {
      rectOver = false;
    }

    if (mousePressed && rectOver) {
      rectOn = true;
    } else {
      rectOn = false;
    }
  }

  int posX (int x, int y) {
    int a = 0;
    if (mousePressed && rectOn) {
      a = rectX;
    } 
    return a;
  }

  int posY (int x, int y) {
    int a = 0;
    if (mousePressed && rectOn) {
      a = rectY;
    } 
    return a;
  }

  boolean overRect (int x, int y, int rectwidth, int rectheight) 
  {
    if (mouseX >= x && mouseX <= x+rectwidth && mouseY >= y && mouseY <= y+rectheight) {
      return true;
    } else {
      return false;
    }
  }
}