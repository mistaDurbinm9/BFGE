
class BoidTwo extends Boid {
  boolean hitPlayer = false;
  int count = (int)random(birdTwoImages.length-1);
  float maxspeed;
  BoidTwo(int x, int y) {
    super(x, y);
    maxspeed = 12;
  }

  void display() {
    float angle = vel.heading() +radians(90);

    stroke(50, 50, 250);
    fill(255, 20, 2);
    pushMatrix();
      translate(loc.x, loc.y);
      //scale(2);
      rotate(angle);
      image(birdTwoImages[count++], 0, 0 );
    popMatrix();
    if(count >= birdTwoImages.length - 1) count = 0;
  
  }
  

  

  
}

