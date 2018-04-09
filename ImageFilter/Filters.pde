//return the index of an item in a 1D array 
//from two indices of an item in a 2D array
int index(int w, int x, int y) {
  return x + w * y;
}

//swap two items in a 1D array
void swap(int[] array, int index1, int index2) {
  int temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
}

//flip an image horizontally or vertically
void flip(PImage img, String type) {
  if (type.equalsIgnoreCase("Horizontal")) {
    for (int y = 0; y < img.height; y++) {
      //only iterates half-way horizontally
      for (int x = 0; x < img.width / 2; x++) {
        //index counting from the right
        int index1 = index(img.width, x, y);
        //index counting from the left
        int index2 = index(img.width, img.width - 1 - x, y);
        //swap left and right
        swap(img.pixels, index1, index2);
      }
    }
  } else if (type.equalsIgnoreCase("Vertical")) {
    //only iterates half-way vertically
    for (int y = 0; y < img.height / 2; y++) {
      for (int x = 0; x < img.width; x++) {
        //index counting from the top
        int index1 = index(img.width, x, y);
        //index counting from the bottom
        int index2 = index(img.width, x, img.height - 1 - y);
        //swap top and bottom
        swap(img.pixels, index1, index2);
      }
    }
  }
}

//mirror an image horizontally or vertically
//implementation similar to flip, but with one difference
void mirror(PImage img, String type) {
  if (type.equalsIgnoreCase("Horizontal")) {
    for (int y = 0; y < img.height; y++) {
      for (int x = 0; x < img.width / 2; x++) {
        int index1 = index(img.width, x, y);
        int index2 = index(img.width, img.width - 1 - x, y);
        //make pixels from the right the same as ones from the left
        img.pixels[index2] = img.pixels[index1];
      }
    }
  } else if (type.equalsIgnoreCase("Vertical")) {
    for (int y = 0; y < img.height / 2; y++) {
      for (int x = 0; x < img.width; x++) {
        int index1 = index(img.width, x, y);
        int index2 = index(img.width, x, img.height - 1 - y);  
        //make pixels from the top the same as ones from the bottom
        img.pixels[index2] = img.pixels[index1];
      }
    }
  }
}

//make the image looks like it is seen through a layer of frosted glass
void frostedGlass(PImage img, int radius) {
  //loop through the pixels array as if it was 2D
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      //index of original pixel
      int index1 = index(img.width, x, y);
      //index of a randomly chosen pixel within a square with
      //side length = radius * 2 + 1 surrounding the original pixel
      //constrains the randomly chosen pixel to be within the pixel array (border case) 
      int xx = constrain((int)random(x - radius, x + radius), 0, img.width - 1);
      int yy = constrain((int)random(y - radius, y + radius), 0, img.height - 1);

      int index2 = index(img.width, xx, yy);

      swap(img.pixels, index1, index2);
    }
  }
}

//turn any image into 256 shades of gray
void grayScale(PImage img) {
  //loop through the pixels array
  for (int i = 0; i < img.pixels.length; i++) {

    //get the rgb values of each pixel
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);

    //calculate how bright the pixel is by averaging the rgb values
    //and set it to be the value of the pixel in grayscale
    color c = color((r + g + b) / 3);

    //give the color to the pixel
    img.pixels[i] = c;
  }
}

//Invert the color of an image
void invert(PImage img) {
  //loop through the pixels array
  for (int i = 0; i < img.pixels.length; i++) {

    //get the rgb values of each pixel
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);

    //get the inverted color by subtracting the rgb from 255
    color c = color(255-r, 255-g, 255-b);

    //give the color to the pixel
    img.pixels[i] = c;
  }
}

//turn any image into 256 shades of brown
void sepia(PImage img) {
  //loop through the pixels array
  for (int i = 0; i < img.pixels.length; i++) {

    //get the rgb values of each pixel
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);

    //calculate the new rgb values of the pixel with the formula  
    //provided by smart people to make life easier for dumb people
    //(me)
    float sepiaR = (r * 0.393) + (g * 0.769) + (b * 0.189);
    float sepiaG = (r * 0.349) + (g * 0.686) + (b * 0.168);
    float sepiaB = (r * 0.272) + (g * 0.534) + (b * 0.131);

    //make a new color with the new rgb
    color c = color(sepiaR, sepiaG, sepiaB);

    //give the color to the pixel
    img.pixels[i] = c;
  }
}

//filter out a single color from the image(rgb)
void colorFilter(PImage img, String col) {
  //loop through the pixels array
  for (int i = 0; i < img.pixels.length; i++) {

    //get the rgb values of each pixel
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);

    color c = color(0);

    switch(col) {
    case "Red": 
      c = color(r, 0, 0);
      break;
    case "Green": 
      c = color(0, g, 0);
      break;
    case "Blue": 
      c = color(0, 0, b);
      break;
    case "Yellow": 
      c = color((r + g) / 2, (r + g) / 2, 0);
      break;
    case "Magenta": 
      c = color((r + b) / 2, 0, (r + b) / 2);
      break;
    case "Cyan": 
      c = color(0, (b + g) / 2, (b + g) / 2);
      break;
    }

    //give the color to the pixel
    img.pixels[i] = c;
  }
}

void bright(PImage img, float factor) {
  //loop through the pixels array
  for (int i = 0; i < img.pixels.length; i++) {

    //get the rgb values of each pixel
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);

    //get the inverted color by subtracting the rgb from 255
    color c = color(r * factor, g * factor, b * factor);

    //give the color to the pixel
    img.pixels[i] = c;
  }
}

void colorNoise(PImage img, int intensity) {
  //loop through the pixels array
  for (int i = 0; i < img.pixels.length; i++) {

    //get the rgb values of each pixel
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);

    r = constrain(r+intensity*randomGaussian(), 0, 255);
    g = constrain(g+intensity*randomGaussian(), 0, 255);
    b = constrain(b+intensity*randomGaussian(), 0, 255);

    color c = color(r, g, b);

    //give the color to the pixel
    img.pixels[i] = c;
  }
}

//reduce the number of colors in an image to a specified value
void posterize(PImage img, int depth) {
  //blah blah blah
  for (int i = 0; i < img.pixels.length; i++) {
    //yada yada yada
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);

    //the number of values each rgb channel can have is one more
    //than the diving factor because when cutting a line, 
    //1 cut makes two segments
    //2 cuts make three segments
    //3 cuts make four segments 
    //and so on
    int d = depth - 1;

    //find the color palette closest to the pixel's color
    r = round(d * r / 255) * 255 / d;
    g = round(d * g / 255) * 255 / d;
    b = round(d * b / 255) * 255 / d;

    //blah blah blah
    color c = color(r, g, b);
    //yada yada yada
    img.pixels[i] = c;
  }
}

//turns the image into a bunch of 1-pixel wide dots with limited
//color palette, and the density of the dots approximates the 
//values in between
void dither(PImage img, int depth) {
  //start by posterizing the image
  //only iterates through 
  for (int y = 0; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      int index1 = index(img.width, x, y);
      float oldR = red(img.pixels[index1]);
      float oldG = green(img.pixels[index1]);
      float oldB = blue(img.pixels[index1]);

      int d = depth - 1;

      float newR = round(d * oldR / 255) * 255 / d;
      float newG = round(d * oldG / 255) * 255 / d;
      float newB = round(d * oldB / 255) * 255 / d;
      img.pixels[index1] = color(newR, newG, newB);
      //end of posterization

      //find the difference between the old and the new pixel values
      //"quantization error"
      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;

      //declaring variables up here makes things easier
      int index2;
      float factor, red, green, blue;

      //push 7/16 of the error to the pixel to the right
      index2 = index(img.width, x + 1, y);
      factor = 7 / 16.0;
      red = red(img.pixels[index2]) + factor * errR;
      green = green(img.pixels[index2]) + factor * errG;
      blue = blue(img.pixels[index2]) + factor * errB;
      img.pixels[index2] = color(red, green, blue);

      //push 3/16 of the error to the pixel to the bottom left
      index2 = index(img.width, x - 1, y + 1);
      factor = 3 / 16.0;
      red = red(img.pixels[index2]) + factor * errR;
      green = green(img.pixels[index2]) + factor * errG;
      blue = blue(img.pixels[index2]) + factor * errB;
      img.pixels[index2] = color(red, green, blue);

      //push 5/16 of the error to the pixel to the bottom
      index2 = index(img.width, x, y + 1);
      factor = 5 / 16.0;
      red = red(img.pixels[index2]) + factor * errR;
      green = green(img.pixels[index2]) + factor * errG;
      blue = blue(img.pixels[index2]) + factor * errB;
      img.pixels[index2] = color(red, green, blue);

      //push 1/16 of the error to the pixel to the bottom right
      index2 = index(img.width, x + 1, y + 1);
      factor = 1 / 16.0;
      red = red(img.pixels[index2]) + factor * errR;
      green = green(img.pixels[index2]) + factor * errG;
      blue = blue(img.pixels[index2]) + factor * errB;
      img.pixels[index2] = color(red, green, blue);
    }
  }
}

void polygon(PImage img, float size) {
  PGraphics pg = createGraphics(img.width, img.height);
  ArrayList<Polygon> polygons = new ArrayList<Polygon>();

  pg.beginDraw();
  pg.noStroke();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      if (random(1) < 3.0/size) {
        int index = index(img.width, x, y);

        float red = red(img.pixels[index]);
        float green = green(img.pixels[index]);
        float blue = blue(img.pixels[index]);
        pg.fill(red, green, blue, 100);

        polygons.add(new Polygon(x, y, size));
        polygons.get(polygons.size()-1).displayPolygon(pg);
      }
    }
  }
  pg.endDraw();

  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = pg.pixels[i];
  }
}

//turn the image to a lower resolution
void pixelate(PImage img, int size) {
  square(img, size, 0);
}

//turn the image to a lower resolution with gridlines along the big pixels
void mosaic(PImage img, int size, int strokeSize) {
  square(img, size, strokeSize);
}

//base algorithm for both pixelation and mosaic
void square(PImage img, int size, int strokeSize) {
  //make a new layer to draw on
  PGraphics pg = createGraphics(img.width, img.height);
  pg.beginDraw();
  pg.strokeWeight(strokeSize);
  //stroke size = 0 is pixelate, anything > 0 is mosaic
  if (strokeSize == 0) pg.noStroke();

  for (int y = 0; y < img.height - size; y+=size) {
    for (int x = 0; x < img.width - size; x+=size) {

      //rgb values for the big pixel
      float r = 0;
      float g = 0;
      float b = 0;
      //add up the rbg values of all pixels in a square area of specified size
      for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
          int index = index(img.width, x+j, y+i);
          r+=red(img.pixels[index]);
          g+=green(img.pixels[index]);
          b+=blue(img.pixels[index]);
        }
      }

      //divide it by the number of pixels in that square to get the average
      r /= (size * size);
      g /= (size * size);
      b /= (size * size);
      color c = color(r, g, b);

      //color of big pixel
      pg.fill(c);
      //draw big pixel
      pg.rect(x, y, size, size);
    }
  }
  pg.endDraw();

  //convert the PGraphics to a PImage
  //for some reasons pg.get() doesn't work
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = pg.pixels[i];
  }
}

void maze(PImage img) {
  for (int i = 0; i < 15; i++)
    filterWithKernel(img, "maze");
}
//filter using convolution matrices
void filterWithKernel(PImage img, String type) {
  //different kernels are located in the "Kernels" tab
  float[][] matrix = convolutionMatrix(type);
  float normalization = 0;

  //calculate the sum of the values in the chosen kernel to make normalization easy
  for (float[] f : matrix) {
    for (float ff : f) {
      normalization += ff;
    }
  }
  //can't divide by 0
  if (normalization == 0) normalization = 1;

  int radius = floor(matrix.length/2);
  PImage tempImg = img.get();

  for (int y = 0; y < tempImg.height; y++) {
    for (int x = 0; x < tempImg.width; x++) {

      int index1 = index(tempImg.width, x, y);
      float r = 0;
      float g = 0;
      float b = 0;

      //loop through all pixels in a square area the size of the kernel
      for (int i = - radius; i <= radius; i++) {
        for (int j = - radius; j <= radius; j++) {
          //if at edge, extend the edge to use as kernel
          int ii = constrain(y + i, 0, tempImg.height-1);
          int jj = constrain(x + j, 0, tempImg.width-1);

          int index2 = index(img.width, jj, ii);

          //colvolution between the pixel kernel and the filter kernel
          r += red  (tempImg.pixels[index2]) * matrix[radius + j][radius + i];
          g += green(tempImg.pixels[index2]) * matrix[radius + j][radius + i];
          b += blue (tempImg.pixels[index2]) * matrix[radius + j][radius + i];
        }
      }

      r /= normalization;
      g /= normalization;
      b /= normalization;

      img.pixels[index1] = color(r, g, b);
    }
  }
}