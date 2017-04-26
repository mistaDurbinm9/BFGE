
class Button {
  PVector loc;
  float myWidth;
  float myHeight;
  color clr = color(10, 50, 8);
  String txt = "";

  Button(String txt, PVector loc, float w, float h, color c) {
    this.txt = txt;
    this.loc = loc;
    myWidth = w;
    myHeight = h;
    clr = c;
  } 

  void display() {
      noStroke();
      fill(5, 25, 4, 110);//Shadow at partial opacity
      rect(loc.x+15, loc.y-15, myWidth, myHeight, 20);
      fill(clr);
      stroke(2);
      strokeWeight(4);
      //Button rectangle with border set at 2 pixels
      rect(loc.x, loc.y-30, myWidth, myHeight, 20);
      textSize(60);
      fill(155, 105, 30, 155);
      text(txt, loc.x+44, loc.y+54 );
      fill(255, 255, 10);
      text(txt, loc.x+40, loc.y+50 );
  }


  //  mouseLoc sent from mousePressed
  //  Check to see if mouse if over bounds of 
  //  button when pressed
  boolean hitTest(PVector mouseLoc) {
    if (  mouseLoc.x > this.loc.x       &&
      mouseLoc.x < this.loc.x + myWidth &&
      mouseLoc.y > this.loc.y           && 
      mouseLoc.y < this.loc.y + myHeight   ) 
      return true;
      
    return false;
  }
}

