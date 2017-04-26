//  ++++++  Gloabal Variables
int startGameTime = 0;
int blockSize = 15;
int numBlocks = 60;
int infoBarSize = 150;
int playAreaSize = blockSize*numBlocks;
int screenW = blockSize*numBlocks + infoBarSize;
int screenH = blockSize*numBlocks;
int highestScore = 0;
int level, currLevel;
//  ++++++  Declare images
PImage clock, seg, home;
PImage[] segHeadImages;
PImage[] birdOneImages;
PImage[] birdTwoImages;
PImage[] birdThreeImages;
PImage[] birdFourImages;
//  ++++++  Global objects
Game game;


void setup() {
  size(screenW, screenH);
  background(10, 60, 40);
  frameRate(18);
  initGame();
}

void draw() {
  game.run();
}

void initGame() {
  level = currLevel = 0;
  loadImages();
  game = new Game();
}

void loadImages() {
  clock = loadImage("yb.png");
  seg = loadImage("seg.png");
  home = loadImage("w.png");

  //+++++++  Bird One  +++++++++++++++++++++++++++++++++
  birdOneImages = new PImage[13];
  for (int i=0; i < birdOneImages.length-1; i++) {
    birdOneImages[i] = loadImage("/birdOne/b"+i+".png");
  }
  //+++++++  Bird Two  +++++++++++++++++++++++++++++++++  
  birdTwoImages = new PImage[9];
  for (int i=0; i < birdTwoImages.length - 1; i++) {
    birdTwoImages[i] = loadImage("/birdTwo/bb"+i+".png");
  }
  //+++++++  Bird Three  +++++++++++++++++++++++++++++++++  
  birdThreeImages = new PImage[20];
  for (int i=0; i < birdThreeImages.length - 1; i++) {
    birdThreeImages[i] = loadImage("/birdThree/b"+i+".png");
  }
  //+++++++  Bird Four  +++++++++++++++++++++++++++++++++  
  birdFourImages = new PImage[9];
  for (int i=0; i < birdFourImages.length - 1; i++) {
    birdFourImages[i] = loadImage("/Bat/b"+i+".png");
  }
  
  //+++++++  SegHead  +++++++++++++++++++++++++++++++++  
  segHeadImages = new PImage[24];
  for (int i=0; i < segHeadImages.length - 1; i++) {
    segHeadImages[i] = loadImage("/segHead/h"+i+".png");
  }
}

void mousePressed() {
  game.mousePressedHandler(new PVector(mouseX, mouseY));
}

void mouseMoved() {
  game.mouseMovedHandler(new PVector(mouseX, mouseY));
}

void keyPressed() {
  game.keyCodeHandler(keyCode);
}

