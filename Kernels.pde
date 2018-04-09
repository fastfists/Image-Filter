float[][] convolutionMatrix(String type) {

  float[][] detectEdge = {  
    {-1, -1, -1}, 
    {-1, 8, -1}, 
    {-1, -1, -1}
  };

  float[][] gaussianDetectEdge = {  
    {0, 0, -1, 0, 0}, 
    {0, -1, -2, -1, 0}, 
    {-1, -2, 16, -2, -1}, 
    {0, -1, -2, -1, 0}, 
    {0, 0, -1, 0, 0}
  };
  float[][] sharpen = {  
    {-1, -1, -1}, 
    {-1, 9, -1}, 
    {-1, -1, -1}
  };
  float[][] gaussianSharpen = {
    {0,  0,  -1, 0,  0},
    {0,  -1, -2, -1, 0 },
    {-1, -2, 18,-2,-1},
    {0,  -1, -2,-1,0},
    {0,  0,  -1,0,0},
  };
  float[][] meanBlur = {  
    {1, 1, 1, 1, 1}, 
    {1, 1, 1, 1, 1}, 
    {1, 1, 1, 1, 1}, 
    {1, 1, 1, 1, 1}, 
    {1, 1, 1, 1, 1}
  };

  float[][] gaussianBlur = {
    {1, 4, 7, 4, 1}, 
    {4, 16, 26, 16, 4}, 
    {7, 26, 41, 26, 7}, 
    {4, 16, 26, 16, 4}, 
    {1, 4, 7, 4, 1}
  };

  float[][] emboss = {
    {-2, -1, 0}, 
    {-1, 1, 1}, 
    { 0, 1, 2}
  };

  float[][] topSobel = {
    {  1, 2, 1}, 
    { 0, 0, 0}, 
    { -1, -2, -1}
  };

  float[][] bottomSobel = {
    {-1, -2, -1}, 
    {0, 0, 0}, 
    {1, 2, 1}
  };

  float[][] leftSobel = {
    { 1, 0, -1}, 
    { 2, 0, -2}, 
    { 1, 0, -1}
  };

  float[][] rightSobel = {
    { -1, 0, 1}, 
    { -2, 0, 2}, 
    { -1, 0, 1}
  };

  float[][] motionBlurNE_SW = {
    {0, 0, 0, 0, 0, 0, 0, 0, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 1, 0}, 
    {0, 0, 0, 0, 0, 0, 1, 0, 0}, 
    {0, 0, 0, 0, 0, 1, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 1, 0, 0, 0, 0, 0}, 
    {0, 0, 1, 0, 0, 0, 0, 0, 0}, 
    {0, 1, 0, 0, 0, 0, 0, 0, 0}, 
    {1, 0, 0, 0, 0, 0, 0, 0, 0}, 
  };

  float[][] motionBlurNW_SE = {
    {1, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 1, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 1, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 1, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 1, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 1, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 1, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  };

  float[][] motionBlurN_S = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {1, 1, 1, 1, 1, 1, 1, 1, 1}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  };

  float[][] motionBlurE_W = {
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 1, 0, 0, 0, 0}, 
  };

  //filter that I found after playing around with the kernel
  float[][] maze = {  
    {-1, 0, -1}, 
    { 0, 8, 0}, 
    {-1, 0, -1}
  };

  switch (type) {
  case "gaussianSharpen":
    return gaussianSharpen;
  case "emboss":
    return emboss;
  case "topSobel":
    return topSobel;
  case "bottomSobel":
    return bottomSobel;
  case "rightSobel":
    return rightSobel;
  case "leftSobel":
    return leftSobel;
  case "sharpen":
    return sharpen;
  case "detectEdge":
    return detectEdge;
  case "gaussianDetectEdge":
    return gaussianDetectEdge;
  case "gaussianBlur":
    return gaussianBlur;
  case "maze":
    return maze;
  case "motionBlurNW_SE":
    return motionBlurNW_SE;
  case "motionBlurNE_SW":
    return motionBlurNE_SW;
  case "motionBlurN_S":
    return motionBlurN_S;
  case "motionBlurE_W":
    return motionBlurE_W;
  default:
    return meanBlur;
  }
}