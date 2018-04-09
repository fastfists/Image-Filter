void infileSelected(File selection) {
  if (selection == null) {
    println("IMAGE NOT LOADED: Window was closed or the user hit cancel.");
  } else { 
    filePath = selection.getAbsolutePath();
    PImage img = loadImage(filePath);
    resetCanvas(img, 600);    
    imageStack.add(img.get());
    println("IMAGE LOADED: User selected " + selection.getAbsolutePath());
    redraw();
  }
}

void outfileSelected(File selection) {
  if (selection == null) {
    println("IMAGE NOT SAVED: Window was closed or the user hit cancel.");
  } else {
    println("IMAGE SAVED: User selected " + selection.getAbsolutePath());

    lastImage().save(selection.getAbsolutePath());
    redraw();
  }
}

void resetCanvas(PImage img, int h) {
  float w;
  
  if (img.height > 600) {
    //if the image is too tall, resize so that it fits the height
    w = h / (float)img.height;
    w *= img.width;
    img.resize((int)w, h);
  } else if (img.width > width - sideBarSize) {
    //if the image is wider than the current screen, then stretch the screen 
    //to fit it
    w = img.width;
  } else {
    w = h-sideBarSize;
  }

  surface.setSize((int)w + sideBarSize, h);

  xOffset = 0;
  yOffset = 0;
  strokeSize = 3;
  currentColor = color(0);
  solid.selected = true;
  frame.selected = false;

  imageStack.clear();

  canvas = createGraphics(img.width, img.height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
}

PImage lastImage() {
  return imageStack.get(imageStack.size()-1);
}

PImage newAction() {
  PImage newImage = lastImage().get();
  imageStack.add(newImage);
  return lastImage();
}

void drawSideBar() {
  stroke(0);
  strokeWeight(1);
  fill(150);
  rect(0, 0, sideBarSize, 600);

  fill(50);
  text("Filters:", 5, 60);
  text("Tools:", 5, 200);
  text("Shape:", 5, 380);

  stroke(currentColor);
  strokeWeight(strokeSize);
  point(sideBarSize/2, 500);

  noStroke();
  fill(currentColor);
  rect(5, 545, sideBarSize - 10, sideBarSize - 10);
}

void undo() {
  if (imageStack.size() > 1)
    imageStack.remove(imageStack.size()-1);
}

void saveImage() {
  if (imageStack.size() > 0)
    lastImage().save(filePath);
}

Button currentButton(ArrayList<Button> arr) {
  for (Button b : arr) {
    if (b.isTouchingMouse()) {
      return b;
    }
  }
  return null;
}

void deleteHistory() {
  while (imageStack.size() > 20)
    imageStack.remove(0);
}

boolean isTouchingMouse(PImage img) {
  return 
    mouseX    > sideBarSize + xOffset
    && mouseX < sideBarSize + xOffset + img.width
    && mouseY > yOffset
    && mouseY < yOffset + img.height;
}


float adjustX(int x) {
  return x - sideBarSize - xOffset;
}

float adjustY(int y) {
  return y - yOffset;
}

//queue-based flood fill algorithm
void bucketFill(PImage img, int x, int y, color old_, color new_, float tolerance) {

  //run only if the pixel is both not equal to the replacement-color 
  //and equal to the target-color
  if (!equalsWithTolerance(img.get(x, y), new_, tolerance) 
    && equalsWithTolerance(img.get(x, y), old_, tolerance)) {

    //add pixel to the queue
    fillQueue.add(new PVector(x, y));

    //for each element (pixel) of the queue
    for (int j = 0; j < fillQueue.size(); j++) {

      //set e and w equal to the pixel
      PVector w = fillQueue.get(j).copy();
      PVector e = fillQueue.get(j).copy();

      //Move w to the left until the color of the pixel to the left 
      //of w no longer matches target-color.
      while (equalsWithTolerance(img.get((int)w.x, (int)w.y), old_, tolerance) && w.x > 0) {
        w.sub(1, 0);
      }

      //Move e to the right until the color of the pixel to the right 
      //of e no longer matches target-color.
      while (equalsWithTolerance(img.get((int)e.x, (int)e.y), old_, tolerance) && e.x < img.width - 1) {
        e.add(1, 0);
      }

      //bug fix
      img.pixels[index(img.width, (int)w.x, (int)w.y)] = new_;
      img.pixels[index(img.width, (int)e.x, (int)e.y)] = new_;

      //for each pixel between w and e:
      for (int i = (int)(w.x+1); i < (int)e.x; i++) {

        //set the color of the pixel to the replacement-color 
        img.pixels[index(img.width, i, (int)w.y)] = new_;

        //if the color of the pixel above is the target-color
        //then add it to the queue
        if (w.y > 0 && equalsWithTolerance(img.get(i, (int)w.y-1), old_, tolerance)) {
          fillQueue.add(new PVector(i, (int)w.y-1));
        }

        //if the color of the pixel south is the target-color
        //then add it to the queue
        if (w.y < img.height - 1 && equalsWithTolerance(img.get(i, (int)w.y+1), old_, tolerance)) {
          fillQueue.add(new PVector(i, (int)w.y+1));
        }
      }
    }
  }
}

boolean equalsWithTolerance(color c1, color c2, float tolerance) {

  float r = abs(red(c1) - red(c2));
  float g = abs(green(c1) - green(c2));
  float b = abs(blue(c1) - blue(c2));

  return (r+g+b)/3 < tolerance;
}

void drawColorChart(int xPos, int yPos) {
  colorMode(HSB);
  
  //draw the first 256 px x 256 px all hues at different brightness values
  for (int i = 0; i < 256; i++) {
    for (int j = 0; j < 256; j++) {
      set(xPos+j, yPos+i, color(i, j, 255));
    }
  }
  
  //draw the second 256 px x 256 px all hues at different saturation values
  for (int i = 0; i < 256; i++) {
    for (int j = 0; j < 256; j++) {
      set(xPos+j+256, yPos+i, color(i, 255, 255-j));
    }
  }
  
  //draw the grayscale column
  for (int i = 0; i < 256; i ++) {
    stroke(i);
    line(xPos+512, yPos+i, xPos+512 + 28, yPos+i);
  }
  colorMode(RGB);
}