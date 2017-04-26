class Player extends Peed {

  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Player(PVector headLocation, int segmentCount, String name) {
    super(headLocation, segmentCount, name);
    //add head
    addBodySegments(segmentCount);
    peedDelay = millis();
    lastSegmentAdded = millis();
  }

  // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++  display  ++++++++++++++++++++++++
  void display() {
    for (int i = 1; i < body.size (); i++) {
      if (i==1) {
        body.get(i).display("head", i);
        }
      else {
        body.get(i).display("player", i);
      }
    }
  }
  // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++  update  ++++++++++++++++++++++++
  //Most of the game logoic for the peed takes place here
  //this method is called from draw accordeing to frameRate() speed
  //  default frameRate is 30fps
  void update() {

    //  If no body--go no further
    if (body.size() < 1) return;
    // Check each boid to see if it is touching any segments in loop
    peedHitIndexes  = new ArrayList<Integer>();
    for (int i = 0; i < body.size (); i++) {
      for (int j = 0; j < game.flock.boids.size (); j++)
        if ( body.get(i).hitTest(game.flock.boids.get(j))) {
          peedHitIndexes.add(i);
        }
    }
    //  if peedHitIndexes > 0 then a hit has occured
    //  remove all segments after lowest index
    if (peedHitIndexes.size() > 0 ) {  
      game.livesLeft--;
      if ( game.livesLeft < 1) game.gameEnded = true;
      int min = getMinIndex();
      //Remove list eklements from end to min index
      for (int i =  body.size()-1; i >= min + 1; i--) {
        body.remove(i);
      }
    }


    // Move head according to direction set in keyPressed()
    if ( millis() - peedDelay > 30 && moved) { //millis() - peedDelay > 100 &&
      if (west)   body.get(0).loc.x -= blockSize/1.5;
      if (east)   body.get(0).loc.x += blockSize/1.5;
      if (north)  body.get(0).loc.y -= blockSize/1.5;
      if (south)  body.get(0).loc.y += blockSize/1.5;
      peedDelay = millis();
      // move body to follow head
      for (int i = body.size() - 1; i > 0 ; i--) {
        //  let loc of segment equal loc of segment ahead
        body.get(i).loc.x = body.get(i-1).loc.x;
        body.get(i).loc.y = body.get(i-1).loc.y;
      }
    }
    //  Add segments to player after addSegmentInterval
    if (millis() - lastSegmentAdded > addSegmentInterval) {
      addBodySegments(1);
      lastSegmentAdded = millis();
    }

    //  If head out of bounds, then end game
    if (body.get(0).loc.x < 0                       ||
      body.get(0).loc.x > playAreaSize-blockSize    ||
      body.get(0).loc.y < 0                         ||
      body.get(0).loc.y > screenH-blockSize) game.gameEnded = true;

    // If head touches body, then loop created
    if (moved)
      for (int i = body.size() - 1; i > 1 ; i--) {
        if (body.get(0).loc.x == body.get(i).loc.x && body.get(0).loc.y == body.get(i).loc.y) {
          game.makeLoop(i);
          game.loopMade = true;
        }
      }
    //update highscore if game ended
    if (game.gameEnded && game.score > highestScore) {
      highestScore = game.score;
    }
  }//  ++++++++ end update player

  //  +++++++++++++++++++++++++++++++++  helper function for remove segments in update
  int getMinIndex() {
    int min = MAX_INT;
    for (Integer x:peedHitIndexes) {
      if (min > x) min = x;
    }
    return min;
  }
  //  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  void addBodySegments(int numSegments) {
    if (numSegments == 1) {
      body.add(new Segment(body.get(body.size() - 1).loc.x, body.get(body.size() - 1).loc.y, 1));
    } 
    else {
      for (int i = 0; i < numSegments; i++) {
        body.add(new Segment(loc.x, loc.y, i));
      }
    }
  }
}  //  +++++++++++++++++++++++++++++++++++++++++  end class

