class Draw {
  int r;
  int g;
  int b;
  boolean drawToggle = false;

  Draw() {
    fill(r, g, b);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}
