abstract class Peed {
  //used for both player and loop
  ArrayList<Segment> body;
  //Gathers the indexes of each segment that hits a boid
  ArrayList<Integer> peedHitIndexes;
  //Gathers the indexes of each segment that hits a boid
  PVector loc;
  color clr;
  boolean north, south, east, west, moved;
  String name;
  int segCount;
  int peedDelay;
  int addSegmentInterval = 100;
  int lastSegmentAdded;
  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Peed(PVector headLocation, int segmentCount, String name) {
    this.name = name;
    this.segCount = segmentCount;
    this.loc = headLocation;
    clr = color(200, 100, 50);
    body = new ArrayList<Segment>();
    north = true;
    moved = false;
    lastSegmentAdded = millis();
  } 
  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  void run() {
    if(moved)
    update(); 
    display();
  }

  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  void display() {
    
    for (int i = 0; i < body.size (); i++) {
      body.get(i).display("");
    }
  }
  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  void update() {
    
  }
 //  ads (numSegments) segment abject to the body arraylist
  void addBodySegments(int numSegments) {
     
    for (int i = 0; i < numSegments; i++) {
      int x = (int)game.player.body.get(i).loc.x;
      int y = (int)game.player.body.get(i).loc.y;
      body.add(new Segment(x, y, i));
      
    }
  }
  //Use key code to set direction
 //Use key code to set direction
  void setDirection(int kc) {
     // set to true no matter what key is pressed
    north = south = east = west = false;
    switch(kc) {
    case UP:
      north = true;
      moved = true;
      break;
    case RIGHT:
      east = true;
      moved = true;
      break;
    case DOWN:
      south = true;
      moved = true;
      break;
    case LEFT:
      west = true;
      moved = true;
      break;
    }
  }   //  +++++++++++++++++++++++++++++++++++++++++  end setDirection

}     //  +++++++++++++++++++++++++++++++++++++++++  end class

