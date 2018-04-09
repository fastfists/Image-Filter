class Button {
  float xPos, yPos;
  float xSize, ySize;
  boolean active, selected;
  String text;

  Button() {
    xSize = 50;
    ySize = 20;
  }

  Button(String txt) {
    text = txt;
  }

  Button(float x, float y, float w, float h, String txt) {
    xPos = x;
    yPos = y;
    xSize = w;
    ySize = h;
    text = txt;
    active = false;
    selected = false;
  }

  void display() {
    if (active) {
      if (selected) {
        fill(100);
      } else {
        fill(200);
      }
      stroke(0);
      strokeWeight(1);
      rect(xPos, yPos, xSize, ySize);
    }
    fill(0);
    text(text, xPos+5, yPos);
  }

  void update() {
    if (active && isTouchingMouse()) {
      selected = !selected;
    } else {
      selected = false;
    }
  }

  boolean isTouchingMouse() {
    return 
      mouseX > xPos && mouseX < (xPos + xSize) && 
      mouseY > yPos && mouseY < (yPos + ySize);
  }

  boolean isClicked() {
    return isTouchingMouse() && active;
  }
}

class DropDownMenu extends Button {

  ArrayList<Button> children;

  DropDownMenu(float x, float y, float w, float h, String txt) {
    super(x, y, w, h, txt);
    children = new ArrayList<Button>();
    this.active = true;
  }

  void createChildren(float w, String[] names) {
    int temp = children.size();
    for (int i = temp; i < temp + names.length; i++) {
      children.add(new Button(xPos+xSize, yPos+i*ySize, w, ySize, names[i]));
    }
  }

  void addButton(Button b) {
    b.yPos = yPos+children.size()*ySize;
    b.ySize = this.ySize;
    b.xPos = this.xPos + this.xSize;

    if (children.size() != 0) {
      b.xSize = children.get(0).xSize;
    }

    children.add(b);
  }

  void showDropDown() {
    if (selected) {
      for (Button b : children) {
        b.active = true;
        b.display();
      }
    } else {
      for (Button b : children) {
        b.active = false;
      }
    }
  }
}

class Polygon {
  float xPos, yPos;
  float radius;

  Polygon(float x, float y, float r) {
    xPos = x;
    yPos = y;
    radius = r;
  }

  void displayPolygon(PGraphics pg) {
    pg.beginShape();
    for (int i = 0; i < 10; i++) {
      float x = xPos + random(1) * radius * cos(i * PI/5);
      float y = yPos + random(1) * radius * sin(i * PI/5);
      pg.vertex(x, y);
    }
    pg.endShape();
  }
}