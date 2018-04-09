/*--------------------------------------------

This is an image editor made by 

--------------------------------
|                              |
|   int boolean team = null;   |
|                              |
--------------------------------

Class: Onramps Computer Science CS 302

Module: Digital Manipulation

Teacher: James Pigg

Course Coordinator: Erik Dillaman

--------------------------------------------*/

import javax.swing.JOptionPane;

ArrayList<PImage> imageStack = new ArrayList<PImage>();
String filePath;
int sideBarSize;

ArrayList<DropDownMenu> menus = new ArrayList<DropDownMenu>();

DropDownMenu file;
Button load, save, saveAs, clear, quit;

DropDownMenu edit;
Button undo, reset, flipH, flipV, mirrorH, mirrorV;

DropDownMenu basics;
Button grayScale, sepia, invertColor, colorNoise, brighten, darken;

DropDownMenu colors;
Button filterRed, filterGreen, filterBlue, filterYellow, filterMagenta, filterCyan;

DropDownMenu blurs;
Button meanBlur, gaussianBlur, motionBlurN_S, motionBlurE_W, motionBlurNE_SW, motionBlurNW_SE;

DropDownMenu edges;
Button sharpen, gaussianSharpen, detectEdge, gaussianDetectEdge, emboss, topSobel, bottomSobel, rightSobel, leftSobel;

DropDownMenu others;
Button posterize, dither, pixelate, mosaic, frostedGlass, polygon, maze;

ArrayList<Button> tools = new ArrayList<Button>();
Button move, brush, line, ellipse, rect, picker, fill; 

ArrayList<Button> shapes = new ArrayList<Button>();
Button colorPick, stroke;

PGraphics canvas;
ArrayList<PVector> fillQueue = new ArrayList<PVector>();

Button solid, frame;
color currentColor;
float strokeSize;

boolean isDrawingShape;
boolean isBrushing;

int beginX, beginY;
int xOffset, yOffset;

void setup() {

  size(600, 600);

  textAlign(LEFT, TOP);
  textSize(15);

  xOffset = 0;
  yOffset = 0;
  sideBarSize = 60;
  strokeSize = 3;
  currentColor = color(0);
  isDrawingShape = false;
  isBrushing = false;
  beginX = 0;
  beginY = 0;

  //"File" dropdown menu
  file       = new DropDownMenu(0, 0, sideBarSize, 20, "File");
  load       = new Button("Load"); 
  save       = new Button("Save");
  saveAs     = new Button("Save As");
  clear      = new Button("Clear");
  quit       = new Button("Quit");

  load.xSize = 70;
  file.addButton(load);
  file.addButton(save);
  file.addButton(saveAs);
  file.addButton(clear);
  file.addButton(quit);

  //"Edit" dropdown menu
  edit       = new DropDownMenu(0, 20, sideBarSize, 20, "Edit");
  undo       = new Button("Undo (shortcut: z)"); 
  reset      = new Button("Reset");
  flipH      = new Button("Flip Horizontally");
  flipV      = new Button("Flip Vertically");
  mirrorH    = new Button("Mirror Horizontally");
  mirrorV    = new Button("Mirror Vertically");

  undo.xSize = 150;
  edit.addButton(undo);
  edit.addButton(reset);
  edit.addButton(flipH);
  edit.addButton(flipV);
  edit.addButton(mirrorH);
  edit.addButton(mirrorV);

  //"Basics" dropdown menu
  basics = new DropDownMenu(0, 80, sideBarSize, 20, "Basics");
  grayScale   = new Button("Gray Scale");
  sepia       = new Button("Sepia");
  invertColor = new Button("Invert Color");
  colorNoise  = new Button("Color Noise");
  brighten    = new Button("Brighten by 10%");
  darken      = new Button("Darken by 10%");

  grayScale.xSize = 130;
  basics.addButton(grayScale);
  basics.addButton(sepia);
  basics.addButton(invertColor);
  basics.addButton(brighten);
  basics.addButton(darken);

  //"Colors" dropdown menu
  colors          = new DropDownMenu(0, 100, sideBarSize, 20, "Colors");
  filterRed       = new Button("Filter Red");
  filterGreen     = new Button("Filter Green");
  filterBlue      = new Button("Filter Blue");
  filterYellow    = new Button("Filter Yellow");
  filterMagenta   = new Button("Filter Magenta");
  filterCyan      = new Button("Filter Cyan");

  filterRed.xSize = 120;
  colors.addButton(filterRed);
  colors.addButton(filterGreen);
  colors.addButton(filterBlue);
  colors.addButton(filterYellow);
  colors.addButton(filterMagenta);
  colors.addButton(filterCyan);

  //"Blurs" dropdown menu
  blurs           = new DropDownMenu(0, 120, sideBarSize, 20, "Blurs");
  meanBlur        = new Button("Mean Blur");
  gaussianBlur    = new Button("Gaussian Blur");
  motionBlurN_S   = new Button("Motion Blur N-S");
  motionBlurE_W   = new Button("Motion Blur E-W");
  motionBlurNE_SW = new Button("Motion Blur NE-SW");
  motionBlurNW_SE = new Button("Motion Blur NW-SE");

  meanBlur.xSize  = 150;
  blurs.addButton(meanBlur);
  blurs.addButton(gaussianBlur);
  blurs.addButton(motionBlurN_S);
  blurs.addButton(motionBlurE_W);
  blurs.addButton(motionBlurNE_SW);
  blurs.addButton(motionBlurNW_SE);

  //"Edges" dropdown menu
  edges              = new DropDownMenu(0, 140, sideBarSize, 20, "Edges");
  sharpen            = new Button("Sharpen");
  gaussianSharpen    = new Button("Gaussian Sharpen");
  detectEdge         = new Button("Detect Edge");
  gaussianDetectEdge = new Button("Gaussian Detect Edge");
  emboss             = new Button("Emboss");
  topSobel           = new Button("Top Sobel");
  bottomSobel        = new Button("Bottom Sobel");
  rightSobel         = new Button("Right Sobel");
  leftSobel          = new Button("Left Sobel");

  sharpen.xSize      = 170;
  edges.addButton(sharpen);
  edges.addButton(gaussianSharpen);
  edges.addButton(detectEdge);
  edges.addButton(gaussianDetectEdge);
  edges.addButton(emboss);
  edges.addButton(topSobel);
  edges.addButton(bottomSobel);
  edges.addButton(rightSobel);
  edges.addButton(leftSobel);

  //"Others" dropdown menu
  others          = new DropDownMenu(0, 160, sideBarSize, 20, "Others");
  posterize       = new Button("Posterize");
  dither          = new Button("Dither");
  pixelate        = new Button("Pixelate");
  mosaic          = new Button("Mosaic");
  frostedGlass    = new Button("Frosted Glass");
  polygon         = new Button("Polygon");
  maze            = new Button("Maze");

  posterize.xSize = 110;
  others.addButton(posterize);
  others.addButton(dither);
  others.addButton(pixelate);
  others.addButton(mosaic);
  others.addButton(frostedGlass);
  others.addButton(polygon);
  others.addButton(maze);

  menus.add(file);
  menus.add(edit);
  menus.add(basics);
  menus.add(colors);
  menus.add(blurs);
  menus.add(edges);
  menus.add(others);

  //tool bar
  move    = new Button("Move");
  brush   = new Button("Brush");
  line    = new Button("Line");
  ellipse = new Button("Ellipse");
  rect    = new Button("Rect");
  picker  = new Button("Picker");
  fill    = new Button("Fill");

  tools.add(move);
  tools.add(brush);
  tools.add(line);
  tools.add(ellipse);
  tools.add(rect);
  tools.add(picker);
  tools.add(fill);

  for (int i = 0; i < tools.size(); i++) {
    tools.get(i).xSize  = sideBarSize;
    tools.get(i).ySize  = 20;
    tools.get(i).xPos   = 0;
    tools.get(i).yPos   = 220 + 20 * i;
    tools.get(i).active = true;
  }

  //shape options
  solid = new Button("Solid");
  frame = new Button("Frame");

  shapes.add(solid);
  shapes.add(frame);

  for (int i = 0; i < shapes.size(); i++) {
    shapes.get(i).xSize  = sideBarSize;
    shapes.get(i).ySize  = 20;
    shapes.get(i).xPos   = 0;
    shapes.get(i).yPos   = 400 + 20 * i;
    shapes.get(i).active = true;
  }

  solid.selected = true;

  //color picker
  colorPick = new Button("Color");
  colorPick.xSize = sideBarSize;
  colorPick.ySize = 20;
  colorPick.xPos = 0;
  colorPick.yPos = 520;
  colorPick.active = true;

  //stroke resize
  stroke = new Button("Stroke");
  stroke.xSize = sideBarSize;
  stroke.ySize = 20;
  stroke.xPos = 0;
  stroke.yPos = 460;
  stroke.active = true;
}

void draw() {
  //deleteHistory();

  background(50);

  if (imageStack.size() != 0) {
    if (isBrushing) {
      if (brush.selected) {
        image(canvas, sideBarSize + xOffset, yOffset);
      }
    } else {
      image(lastImage(), sideBarSize + xOffset, yOffset);

      if (isDrawingShape && isTouchingMouse(canvas)) {
        if (line.selected) {
          strokeWeight(strokeSize);
          stroke(currentColor);
          line(beginX, beginY, mouseX, mouseY);
        } else if (ellipse.selected ) {

          //solid shape
          noStroke();
          fill(currentColor);

          //frame (outline) shapes
          if (frame.selected) {
            stroke(currentColor);
            strokeWeight(strokeSize);
            noFill();
          }

          ellipseMode(CORNERS);
          ellipse(beginX, beginY, mouseX, mouseY);
        } else if (rect.selected ) {

          //solid shapes
          noStroke();
          fill(currentColor);

          //frame (outline) shapes
          if (frame.selected) {
            stroke(currentColor);
            strokeWeight(strokeSize);
            noFill();
          }
          rect(beginX, beginY, mouseX-beginX, mouseY-beginY);
        }
      }
    }
  }

  drawSideBar();
  
  if (colorPick.selected) {
    drawColorChart(sideBarSize+1, 600-256);
  }

  for (DropDownMenu m : menus) {
    m.display();
    m.showDropDown();
  }

  for (Button b : tools) {
    b.display();
  }

  for (Button b : shapes) {
    b.display();
  }

  colorPick.display();
  
  stroke.display();

  noLoop();
}

void mousePressed() {

  //"File" dropdown menu
  if (load.isClicked())
    selectInput("Select an image to load:", "infileSelected");
  if (save.isClicked())
    saveImage();
  if (saveAs.isClicked()) 
    selectOutput("Save image as:", "outfileSelected");
  if (clear.isClicked())
    imageStack.clear();
  if (quit.isClicked()) 
    exit();

  if (imageStack.size() > 0) {
    //"Edit" dropdown menu
    if (undo.isClicked())
      undo();
    if (reset.isClicked()) 
      while (imageStack.size() > 1)
        imageStack.remove(imageStack.size() - 1);
    if (flipH.isClicked()) 
      flip(newAction(), "Horizontal");
    if (flipV.isClicked()) 
      flip(newAction(), "Vertical");
    if (mirrorH.isClicked()) 
      mirror(newAction(), "Horizontal");
    if (mirrorV.isClicked()) 
      mirror(newAction(), "Vertical");

    //"Basics" dropdown menu
    if (grayScale.isClicked())
      grayScale(newAction());
    if (sepia.isClicked())
      sepia(newAction());
    if (invertColor.isClicked())
      invert(newAction());
    if (colorNoise.isClicked()) {
      String intensity = JOptionPane.showInputDialog("Enter the intensity of the noise (an integer >0, recommended >=10)");
      if (intensity != null && parseInt(intensity) > 1)
        colorNoise(newAction(), parseInt(intensity));
    }
    if (brighten.isClicked())
      bright(newAction(), 1.1);
    if (darken.isClicked())
      bright(newAction(), 0.9);

    //"Colors" dropdown menu
    if (filterRed.isClicked())
      colorFilter(newAction(), "Red");
    if (filterGreen.isClicked())
      colorFilter(newAction(), "Green");
    if (filterBlue.isClicked())
      colorFilter(newAction(), "Blue");
    if (filterYellow.isClicked())
      colorFilter(newAction(), "Yellow");
    if (filterMagenta.isClicked())
      colorFilter(newAction(), "Magenta");
    if (filterCyan.isClicked())
      colorFilter(newAction(), "Cyan");

    //"Blurs" dropdown menu
    if (meanBlur.isClicked())
      filterWithKernel(newAction(), "meanBlur");
    if (gaussianBlur.isClicked())
      filterWithKernel(newAction(), "gaussianBlur");
    if (motionBlurN_S.isClicked())
      filterWithKernel(newAction(), "motionBlurN_S");
    if (motionBlurE_W.isClicked())
      filterWithKernel(newAction(), "motionBlurE_W");
    if (motionBlurNE_SW.isClicked())
      filterWithKernel(newAction(), "motionBlurNE_SW");
    if (motionBlurNW_SE.isClicked())
      filterWithKernel(newAction(), "motionBlurNW_SE");

    //"Edges" dropdown menu
    if (sharpen.isClicked())
      filterWithKernel(newAction(), "sharpen");
    if (gaussianSharpen.isClicked())
      filterWithKernel(newAction(),"gaussianSharpen");
    if (detectEdge.isClicked() )
      filterWithKernel(newAction(), "detectEdge");
    if (gaussianDetectEdge.isClicked())
      filterWithKernel(newAction(), "gaussianDetectEdge");
    if (emboss.isClicked())
      filterWithKernel(newAction(), "emboss");
    if (topSobel.isClicked())
      filterWithKernel(newAction(), "topSobel");
    if (bottomSobel.isClicked())
      filterWithKernel(newAction(), "bottomSobel");
    if (rightSobel.isClicked())
      filterWithKernel(newAction(), "rightSobel");
    if (leftSobel.isClicked())
      filterWithKernel(newAction(), "leftSobel");

    //"Others" dropdown menu
    if (posterize.isClicked()) {
      String depth = JOptionPane.showInputDialog("Enter the number of color palettes (an integer >1)");
      if (depth != null && parseInt(depth) > 1)
        posterize(newAction(), parseInt(depth));
    }
    if (dither.isClicked()) {
      String depth = JOptionPane.showInputDialog("Enter the number of color palettes (an integer >1)");
      if (depth != null && parseInt(depth) > 1)
        dither(newAction(), parseInt(depth));
    }
    if (pixelate.isClicked()) {
      String pixelSize = JOptionPane.showInputDialog("Enter the size of each pixel (an integer >0)");
      if (pixelSize != null && parseInt(pixelSize) > 0)
        pixelate(newAction(), parseInt(pixelSize));
    }
    if (mosaic.isClicked()) {
      String pixelSize = JOptionPane.showInputDialog("Enter the size each square (an integer >0)");
      if (pixelSize != null && parseInt(pixelSize) > 0) {
        String lineSize = JOptionPane.showInputDialog("Enter the line thickness (an integer >=0)");
        if (lineSize != null && parseInt(lineSize) >= 0)
          mosaic(newAction(), parseInt(pixelSize), parseInt(lineSize));
      }
    }
    if (frostedGlass.isClicked()) {
      String scatterLevel = JOptionPane.showInputDialog("Enter the scattering radius (an integer >0)");
      if (scatterLevel != null && parseInt(scatterLevel) > 0)
        frostedGlass(newAction(), parseInt(scatterLevel));
    }
    if (polygon.isClicked()) {
      String size = JOptionPane.showInputDialog("Enter the polygon size (an integer >0, recommended >=5)");
      if (size != null && parseInt(size) > 0)
        polygon(newAction(), parseInt(size));
    }
    if (maze.isClicked())
      maze(newAction());
    
    //Tools behaviors
    if (mouseX > sideBarSize + xOffset) {

      if (picker.selected)
        currentColor = get(mouseX, mouseY);

      if (fill.selected) {
        fillQueue.clear();
        int x = (int)(mouseX - sideBarSize - xOffset);
        int y = (int)(mouseY - yOffset);
        imageStack.add(newAction());
        bucketFill(lastImage(), x, y, lastImage().get(x, y), currentColor, 10);
      }

      if (brush.selected) {
        
        //copy the image onto the canvas
        canvas.loadPixels();
        for (int i = 0; i < lastImage().pixels.length; i ++) {
          canvas.pixels[i] = lastImage().pixels[i];
        }
        canvas.updatePixels();

        canvas.beginDraw();
        canvas.ellipseMode(RADIUS);
        canvas.fill(currentColor);

        if (isTouchingMouse(canvas)) {
          isBrushing = true;
          canvas.noStroke();
          canvas.ellipse(adjustX(mouseX), adjustY(mouseY), strokeSize/2.0, strokeSize/2.0);
          canvas.stroke(currentColor);
        }

        canvas.endDraw();
      }

      if (ellipse.selected || rect.selected || line.selected) {
        
        //copy the image on to the canvas
        canvas.loadPixels();
        for (int i = 0; i < lastImage().pixels.length; i ++) {
          canvas.pixels[i] = lastImage().pixels[i];
        }
        canvas.updatePixels();
        
        beginX = mouseX;
        beginY = mouseY;
        isDrawingShape = true;
      }
    }
  }

  for (DropDownMenu m : menus)
    m.update();
  
  //only one button can be selected at a time
  //clicking on a selected button will deselect it
  if (currentButton(tools) != null) {
    for (Button b : tools)
      if (b != currentButton(tools))
        b.selected = false;
    currentButton(tools).selected = !currentButton(tools).selected;
  }
  
  //alternate between solid and frame shapes
  if (solid.isTouchingMouse()) {
    solid.selected = !solid.selected;
    frame.selected = !frame.selected;
  }

  if (frame.isTouchingMouse()) {
    solid.selected = !solid.selected;
    frame.selected = !frame.selected;
  }

  if (colorPick.isTouchingMouse())
    colorPick.selected = !colorPick.selected;

  if (stroke.isTouchingMouse())
    stroke.selected = !stroke.selected;

  redraw();
}

void mouseDragged() {
  if (mouseX > sideBarSize + xOffset) {
    if (imageStack.size() > 0) {
      if (move.selected) {
        //move the image based on mouse movement
        xOffset += mouseX - pmouseX;
        yOffset += mouseY - pmouseY;
      }
    }

    if (picker.selected)
      currentColor = get(mouseX, mouseY);

    if (brush.selected) {
      if (isTouchingMouse(canvas)) {
        canvas.beginDraw();
        canvas.strokeWeight(strokeSize);
        canvas.line(adjustX(pmouseX), adjustY(pmouseY), adjustX(mouseX), adjustY(mouseY));
        canvas.endDraw();
      }
    }
  }
  redraw();
}

void mouseReleased() {
  if (mouseX > sideBarSize + xOffset) {
    if (brush.selected) {
      imageStack.add(canvas.get());
      canvas.endDraw();
    }

    if (isDrawingShape && isTouchingMouse(canvas)) {
      canvas.beginDraw();
      if (line.selected) {
        canvas.strokeWeight(strokeSize);
        canvas.stroke(currentColor);
        canvas.line(adjustX(beginX), adjustY(beginY), adjustX(mouseX), adjustY(mouseY));
      } else if (ellipse.selected ) {
        canvas.noStroke();
        canvas.fill(currentColor);

        if (frame.selected) {
          canvas.stroke(currentColor);
          canvas.strokeWeight(strokeSize);
          canvas.noFill();
        }

        canvas.ellipseMode(CORNERS);
        canvas.ellipse(adjustX(beginX), adjustY(beginY), adjustX(mouseX), adjustY(mouseY));
      } else if (rect.selected ) {
        canvas.noStroke();
        canvas.fill(currentColor);

        if (frame.selected) {
          canvas.stroke(currentColor);
          canvas.strokeWeight(strokeSize);
          canvas.noFill();
        }

        canvas.rectMode(CORNERS);
        canvas.rect(adjustX(beginX), adjustY(beginY), adjustX(mouseX), adjustY(mouseY));
      }

      imageStack.add(canvas.get());
      canvas.endDraw();
      isDrawingShape = false;
    }
  }
  isDrawingShape = false;
  isBrushing = false;
  redraw();
}

void mouseWheel(MouseEvent e) {
  if (stroke.selected) {
    strokeSize -= e.getCount();
    strokeSize = constrain(strokeSize, 1, 20);
  }
  redraw();
}

void keyPressed() {
  if (key == 'z' || key == 'Z')
    undo();
  redraw();
}