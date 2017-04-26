
class GameArea {

  public PVector loc;
  public int myWidth;
  public int myHeight;
  public  color clr;
  GameArea(PVector location, int w, int h, color c) {

    loc = location;
    myWidth = w;
    myHeight = h;
    clr = c;
  }

  void run() {
    display();
  } 

  void display() {
    fill(clr);
    rect(loc.x, loc.y, myWidth, myHeight);
  }
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
class PlayArea extends GameArea {


  PlayArea(PVector location, int w, int h, color c) {
    super(location, w, h, c);
  }

  void run() {
    display();
    game.base.run();
    game.player.run();

    if (game.loop != null) {
      game.loop.run();
    }
  } 

  void display() {
    fill(clr);
    rect(loc.x, loc.y, myWidth, myHeight);
  }
} // end  class

class SplashArea extends GameArea {

  int bsi, nb;

  SplashArea(PVector location, int w, int h, color c, int buttonsStartIndex, int numberButtons) {
    super(location, w, h, c);
    bsi = buttonsStartIndex;
    nb = numberButtons;
  }

  void run() {
    display();
  }

  void display() {
    fill(clr);
    rect(loc.x, loc.y, myWidth, myHeight, 20);
    for (int i =bsi; i < (bsi+nb); i++ ) {
      game.buttons.get(i).display();
    }
  }
}

// +++++++++++++++++++++++++++++++++++++++++++++++++++  InfoArea
class InfoArea extends GameArea {


  Clock clock;
  
  InfoArea(PVector location, int w, int h, color c) {
    super(location, w, h, c);
    initClock();
  }

  void run() {
    display();
    clock.display();
  }
  
  void initClock(){
    clock = new Clock(new PVector(loc.x+75, loc.y+75), 50);
  }

  void display() {
    int yOffset = 270;
    fill(clr);
    stroke(2);
    rect(loc.x, loc.y, myWidth, myHeight, 20);
    textSize(20);
    //Score rectangle
    color c1 = color(65, 45, 65, 110);
    color c2 = color(65, 45, 65);

    makeInfoRect(15, -120 + yOffset, c1, c2, "Level");
    fill(255, 255, 0);
    text(level, loc.x+75, loc.y - 50 + yOffset);
    makeInfoRect(15, 30 + yOffset, c1, c2, "Score");
    fill(255, 255, 0);
    text(game.score, loc.x+75, loc.y + 100 + yOffset);
    makeInfoRect(15, 180+ yOffset, c1, c2, "Lives");
    fill(255, 255, 0);
    text(game.livesLeft, loc.x+75, loc.y + 250+ yOffset );
    makeInfoRect(15, 330+ yOffset, c1, c2, "Boids");
    fill(255, 255, 0);
    text(game.flock.boids.size(), loc.x+75, loc.y + 400+ yOffset );
    makeInfoRect(15, 480+ yOffset, c1, c2, "Highest");
    fill(255, 255, 0);
    text(highestScore, loc.x+75, loc.y + 550 + yOffset);
  }

  void makeInfoRect(int ox, int oy, color c1, color c2, String txt) {
    noStroke();
    fill(c1);//Shadow at partial opacity
    rect(loc.x+ox+10, loc.y+oy+10, 120, 120, 15);
    fill(c2);//rect color dark
    stroke(2);
    strokeWeight(4);
    //Button rectangle with border set at 2 pixels
    rect(loc.x+ox, loc.y+oy, 120, 120, 15);
    textSize(21);
    fill(220, 220, 30);
    text(txt, loc.x+ox+20, loc.y+oy+30 );
  }
} // end InfoArea class


class Clock {
  PVector loc;
  float handLength;
  float clockRadius;
  float clockTime, ellapsedTime;
  Clock(PVector location, float radius) {
    loc = location;
    clockRadius = radius;
    handLength = clockRadius;
    stroke(255);
    clockTime = 0;
    ellapsedTime = millis();
  }

  void display() {
    if(millis() - ellapsedTime >= 250){
      clockTime++;
      ellapsedTime = millis();
    }
    // Display shadow
    fill(50, 50, 50, 150);
    noStroke();
    strokeWeight(6);
    ellipse(loc.x+8, loc.y+8, clockRadius*2+4, clockRadius*2+4);    
    
    // Display outer rim
    fill(100, 60, 180);
    stroke(5);
    strokeWeight(6);
    ellipse(loc.x, loc.y, clockRadius*2+4, clockRadius*2+4);
    // Fisplay face
    noStroke();
    fill(180, 180, 80);
    pushMatrix();
    imageMode(CENTER);
    translate(loc.x, loc.y);
    scale(1.8);
    image(clock, 0, 0);
    //ellipse(loc.x, loc.y, clockRadius*2-12, clockRadius*2-12);
    popMatrix();
    float s = map(clockTime, 0, 60, 0, TWO_PI) - HALF_PI;
    
    stroke(10, 50, 5);
    strokeWeight(4);
    line(loc.x, loc.y, loc.x + cos(s) * handLength*(.7), loc.y + sin(s) * handLength*(.7));

  }

}
