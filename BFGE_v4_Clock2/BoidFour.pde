
class BoidFour extends Boid {
  boolean hitPlayer = false;
  int count = (int)random(birdFourImages.length-1);
  
  BoidFour(int x, int y) {
    super(x, y);
    maxspeed = 2;
  }

  void display() {
    float angle = vel.heading() +radians(90);

    stroke(50, 50, 250);
    fill(255, 20, 2);
    pushMatrix();
      translate(loc.x, loc.y);
      //scale(2);
      rotate(angle);
      image(birdFourImages[count++], 0, 0 );
    popMatrix();
    if(count >= birdFourImages.length - 1) count = 0;
  
  }
  
}
