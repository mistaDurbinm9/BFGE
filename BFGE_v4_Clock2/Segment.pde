//++++++++++++++++++++++++++++++++++++++++++++++++++++++++  Segment Class  ++++++++++++++

class Segment {
  //  +++++++++++++++++++  Class properties
  PVector loc;
  int pIndex;
  color c;
  int count = 0;
  // ++++++++++++++++   Constructor  +++++++++++
  Segment(float x, float y, int index) {
    loc = new PVector(x, y);
    pIndex = index;
  }

  //  peedType distinguishes loops vs player
  void display(String segType) {
    stroke(.5);

    if (segType.equals("loop")) {
      stroke(2);
      strokeWeight(2);
      fill(220, 120, 12);
      rect(loc.x, loc.y, blockSize, blockSize);  
      noStroke();
      fill(250, 250, 12);
      rect(loc.x+4, loc.y+4, blockSize-8, blockSize-8);
    }
  }

  void display(String segType, int index) {
    stroke(.5);

    if (segType.equals("head")) {
      float angle =   radians(90);
      stroke(50, 50, 250);
      fill(255, 20, 2);
      //ellipse(loc.x, loc.y, 15, 15);
      pushMatrix();
      if (game.player.west)  angle += radians(180);
      if (game.player.east)  angle += radians(0);
      if (game.player.north) angle += radians(-90);
      if (game.player.south) angle += radians(90);
      translate(loc.x, loc.y);
      rotate(angle);
      scale(1.5);
      image(segHeadImages[count++], 0, 0 );
      if (count > 22) count = 0;
      popMatrix();
    }
    else if (segType.equals("player")) {
      float angle =   radians(90);
      stroke(50, 50, 250);
      fill(255, 20, 2);
      //ellipse(loc.x, loc.y, 15, 15);
      pushMatrix();
      translate(loc.x, loc.y);
      rotate(angle);
      if(index < 5) scale(.2*index);
      if(index > game.player.body.size() - 6 ) scale(.18*(game.player.body.size()-index));
      image(seg, 0, 0 );
      popMatrix();
    }
  } // end display


  boolean hitTest(Boid b) {
    if (b.loc.x > loc.x &&
      b.loc.x < loc.x + blockSize &&
      b.loc.y > loc.y &&
      b.loc.y < loc.y + blockSize) return true;
    return false;
  }
}  // end class

