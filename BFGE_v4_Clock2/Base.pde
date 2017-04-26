

class Base {

  PVector loc;

  Base(PVector location) {
    loc = location;
  }

  void run() {
    display();
  } 

  void display() {
    image(home, loc.x+25, loc.y+8);
  }
} // end  class


