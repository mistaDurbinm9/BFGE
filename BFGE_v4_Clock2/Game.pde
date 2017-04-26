

class Game {
  //  Instance varaibles (Properties)  +++++++++++++++++++++++++
  boolean gameStarted = false;
  boolean gameEnded = false;
  boolean loopMade = false;
  int loopTimeLapsed = 0;
  int score = 0;
  int livesLeft = 4;
  PVector[] loopBounds = {
    new PVector(0, 0), new PVector(0, 0)
    };
    GameArea playArea;
  GameArea startArea;
  GameArea endArea;
  InfoArea infoArea;
  Base base;
  Player player;
  Loop loop;
  Flock flock;

  ArrayList<Button> buttons  = new ArrayList<Button>();

  //  Constructors  +++++++++++++++++++++++++++++++
  Game() {
    // When game constructed, init the following
    level++;
    loopTimeLapsed = millis();
    makeButtons(); 
    player = new Player(new PVector(blockSize*12, blockSize*12), 5, "player");
    loop = new Loop(new PVector(blockSize*10, blockSize*10), 0, "loop");
    infoArea = new InfoArea(new PVector(playAreaSize, 0), infoBarSize, screenH, color(135, 95, 136));
    playArea = new PlayArea(new PVector(0, 0), playAreaSize, screenH, color(90, 148, 90));
    startArea = new SplashArea(new PVector(0, 0), playAreaSize, screenH, color(90, 108, 148), 0, 2);
    endArea = new SplashArea(new PVector(0, 0), playAreaSize, screenH, color(90, 108, 148), 2, 1);
    base = new Base(new PVector(blockSize*12-25, blockSize*12-25));

    generateFlock(8);
  }

  //  Methods (Behaviors)  +++++++++++++++++++++++++
  // Generate flock called from loop when loop update and game constructor
  void generateFlock(int numBoids) {
    flock = new Flock();
    // Add an initial set of boids into the system

    if (level == 1)
      for (int i = 0; i < numBoids; i++) {
        flock.addBoid(new BoidOne(playAreaSize/2, playAreaSize/2));
      }
    else if (level == 3) {
      livesLeft = 4;
      for (int i = 0; i < numBoids; i++) {
        flock.addBoid(new BoidOne(300, playAreaSize/4));
        flock.addBoid(new BoidTwo(playAreaSize - 300, playAreaSize - 100));
      }
    }
    else if (level == 5) {
      livesLeft = 4;
      for (int i = 0; i < numBoids; i++) {
        flock.addBoid(new BoidOne(playAreaSize/4, playAreaSize/2));
        flock.addBoid(new BoidTwo(playAreaSize - 300, playAreaSize - 100));
        flock.addBoid(new BoidThree(playAreaSize/2, playAreaSize/4));
      }
    }
    else if (level == 7) {
      livesLeft = 4;
      for (int i = 0; i < numBoids; i++) {
        flock.addBoid(new BoidOne(playAreaSize/4, playAreaSize/2));
        flock.addBoid(new BoidTwo(playAreaSize - 300, playAreaSize - 100));
        flock.addBoid(new BoidThree(playAreaSize/2, playAreaSize/4));
        flock.addBoid(new BoidFour(500, 700));
      }
    }
  }

  //  add to boids array  +++++++++++++++++++++++++
  void addBoidsToFlock(int numboids, String boidType) {
    // Add an initial set of boids into the system
    for (int i = 0; i < numboids; i++) {
      if (level==1)
        flock.addBoid(new BoidOne(width/2, height/2));
      else if (level==2)
        flock.addBoid(new BoidTwo(width/2, height/2));
      else if (level==3)
        flock.addBoid(new BoidThree(width/2, height/2));
      else
        flock.addBoid(new BoidFour(width/2, height/2));
    }
  }
  void run() {
    infoArea.run();
    if (!gameStarted) {
      startArea.run();
    } 
    else if (!gameEnded) {
      if (currLevel != level) {

        currLevel = level;
      }
      playArea.run();
      flock.run();
      if (loopMade ) loop.run();
    }
    else if (gameEnded) {
      endArea.run();
    }
    else {
      println("Outside of game");
    }
  }

  void keyCodeHandler(int kc) {
    game.player.setDirection(kc);
  }

  void mousePressedHandler(PVector mouseLoc) {
    if (!gameStarted && (buttons.get(2).hitTest(mouseLoc))) {
      gameStarted = true;
      startGameTime = millis();
    }     
    if (gameEnded && (buttons.get(0).hitTest(mouseLoc))) {
      initGame();
    }
  }

  void mouseMovedHandler(PVector mouseLoc) {
    color clr1 = color(159, 196, 176);
    color clr2 = color(45, 54, 74);
    if ((buttons.get(0).hitTest(mouseLoc))) 
      buttons.get(0).clr = clr1;
    else
      buttons.get(0).clr = clr2;

    if ((buttons.get(1).hitTest(mouseLoc))) 
      buttons.get(1).clr = clr1;
    else
      buttons.get(1).clr = clr2;

    if ((buttons.get(2).hitTest(mouseLoc))) 
      buttons.get(2).clr = clr1;
    else
      buttons.get(2).clr = clr2;
  }

  void makeButtons() {
    int w = 400;
    int h = 150;
    //Evntually we can place these in in an array list of Buttons
    buttons.add( new Button("Play", new PVector(blockSize*numBlocks/3.5, 200), w, h, color(45, 54, 74)));
    buttons.add( new Button("Instructions", new PVector(blockSize*numBlocks/3.5, 400), w, h, color(45, 54, 74)));
    buttons.add( new Button("Reset?", new PVector(blockSize*numBlocks/3.5, 200), w, h, color(45, 54, 74)));
  }

  void makeLoop(int index) {
    float x = player.body.get(0).loc.x;
    float y = player.body.get(0).loc.y;
    if (!loopMade) {
      loop   = new Loop(new PVector(x, y), index, "loop");
      loopTimeLapsed = millis();
      getLoopBounds(index);
      setBoidsInLoop();
    }
    player = new Player(new PVector(blockSize*12, blockSize*12), 5, "player");
  }

  // Get top most y, left most x etc
  // return two PVectors
  //  Find the extreme x and y coordinates of a loop
  //  Save these in an array of PVectors
  void getLoopBounds(int index) {
    float maxX = MIN_FLOAT;
    float maxY = MIN_FLOAT;
    float minX = MAX_FLOAT;
    float minY = MAX_FLOAT;
    //get extreems and load into PVector Array
    for (int i = 0; i < loop.body.size(); i++) {
      if (maxX < loop.body.get(i).loc.x + 4) maxX = loop.body.get(i).loc.x;
      if (maxY < loop.body.get(i).loc.y) maxY = loop.body.get(i).loc.y;
      if (minX > loop.body.get(i).loc.x - 4) minX = loop.body.get(i).loc.x;
      if (minY > loop.body.get(i).loc.y) minY = loop.body.get(i).loc.y;
    }
    loopBounds[0].x = maxX;
    loopBounds[0].y = maxY;
    loopBounds[1].x = minX;
    loopBounds[1].y = minY;
  }

  void setBoidsInLoop() {
    for (Boid b: flock.boids) {
      if (b.loc.x < loopBounds[0].x &&
        b.loc.y < loopBounds[0].y   &&
        b.loc.x > loopBounds[1].x   &&
        b.loc.y > loopBounds[1].y      ) {         
        b.setInLoop(true);
        score++;
      }
    }
  }
} // end Game class

