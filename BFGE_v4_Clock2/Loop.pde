
class Loop extends Peed {


  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Loop( PVector loc, int segmentCount, String name) {
    super( loc, segmentCount, name);
    addBodySegments(segmentCount);
  } 
  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  void run() {
    update(); 
    display();
  }


  void update() {
    //remove loop after spec time
    if (millis() - game.loopTimeLapsed > 2000 && body.size() > 0 ) {
      // remove all segments from loop body
      for (int i = body.size()-1; i >=0; i-- ) {
        body.remove(i);
      }
      //remove all looped-boids from flock
      int count = 0;
      for (int i = game.flock.boids.size()-1; i >= 0; i-- ) {
        if (game.flock.boids.get(i).inLoop ) {
          game.flock.boids.remove(i);
          count++;
        }
      } 
      
      if(game.flock.boids.size() < 1){
        level += 2;
        game.generateFlock(5*level);
      }
      // add new boids to flock

//      switch(level) {
//      case 1:
//        game.addBoidsToFlock(3*count, "blueBird");
//        break;
//      case 3:
//        game.addBoidsToFlock(3*count, "blackBird");
//        break;        
//      case 5:
//        game.addBoidsToFlock(3*count, "whiteBird");
//        break;
//      case 7:
//        game.addBoidsToFlock(3*count, "batBird");
//        break;
//      }
      
      game.loopMade = false;
    }
  }


  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  void display() {
    for (int i = 1; i < body.size (); i++) {
      body.get(i).display("loop");
    }
  }

  // //  ads (numSegments) segment abject to the body arraylist
  //  void addBodySegments(int numSegments) {
  //     
  //    for (int i = 0; i < numSegments; i++) {
  //      int x = (int)game.player.body.get(i).loc.x;
  //      int y = (int)game.player.body.get(i).loc.y;
  //      body.add(new Segment(x, y, i));
  //      
  //    }
  //  }
}  //  +++++++++++++++++++++++++++++++++++++++++  end class

