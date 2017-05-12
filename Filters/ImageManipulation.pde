PImage bg, bg2; //bg = background (image to filter); bg2 = background2 (result from filtering)
float r,g,b,newR,newG,newB = 0; //used and changed with each pixel
color c; //used and changed with each pixel
float[][] normal = {{0,0,0}, {0,1,0}, {0,0,0}}; //identity, the same image
float[][] gaussianBlur = {{1.5*0.0625,0.125,0.0625}, {0.125,0.25,1.5*0.125}, {0.0625,1.5*0.125,0.0625}};
float[][] sepiaFilter = {{.393,.349,.272}, {.769,.686,.534}, {.189,.168,.131}};
float[][] edgeDetection = {{-1,-1,-1}, {-1,8,-1}, {-1,-1,-1}};
float[][] sharpen = {{0,-1,0}, {-1,5,-1}, {0,-1,0}};
float[][] mix = {{0,0,0}, {0,3/2,0}, {0,0,0}};
int counter = 0;
int fHeight;
int fWidth;
String fileName;
boolean done = false;

void settings() {
  selectInput("Select a file to process:", "fileSelected");
  interrupt();
  bg = loadImage(fileName);
  size(bg.width,bg.height);
  fWidth = bg.width;
  fHeight = bg.height;
  bg2 = createImage(bg.width, bg.height, RGB);
  //<>//
}

void setup() {
  background(bg);
  loadPixels();
  //mainManipulator(sharpen);
  sepiaFilter();
  background(bg2);
} //<>//

void fileSelected(File selection) {
  fileName = selection.getAbsolutePath();
}
void interrupt() {
  while (fileName == null) {
    delay(200);
  }
}
void interrupt2() {
  while (!done) {
    delay(200);
  }
}

void mainManipulator(float[][] matrix) {
  for (int i = 0; i < fWidth; i++) {
    for (int j = 0; j < fHeight; j++) {
      for (int k = 2; k >= 0; k--) {
          if (i == 0 || i == fWidth-1) {
          } else if (j == 0 || j == fHeight-1) {
          } 
          if (i != 0 && i != fWidth-1 && j != 0 && j != fHeight-1) {
            for (int l = 2; l >= 0; l--) {
              c = pixels[(j+l-1)*fWidth + (i+k-1)];
              r = (int)red(c);
              g = (int)green(c);
              b = (int)blue(c);
              newR += r * matrix[l][k];
              newG += g * matrix[l][k];
              newB += b * matrix[l][k];
          }
        }
      }
      bg2.set(i,j,color(newR,newG,newB));
      newR = 0;
      newB = 0;
      newG = 0;
    }
  } 
  background(bg2);
  done = true;
}

void sepiaFilter(){
  for (int i = 0; i < fWidth; i++) {
    for (int j = 0; j < fHeight; j++) {
          if (i != 0 && i != fWidth-1 && j != 0 && j != fHeight-1) {
              c = pixels[(j)*fWidth + (i)];
              r = (int)red(c);
              g = (int)green(c);
              b = (int)blue(c);
              newR = r * sepiaFilter[0][0] + g * sepiaFilter[1][0] + b * sepiaFilter[2][0];
              newG = r * sepiaFilter[0][1] + g * sepiaFilter[1][1] + b * sepiaFilter[2][1];
              newB = r * sepiaFilter[0][2] + g * sepiaFilter[1][2] + b * sepiaFilter[2][2];
        }
      bg2.set(i,j,color(newR,newG,newB));
      newR = 0;
      newB = 0;
      newG = 0;
    }
  }
  draw();
}
