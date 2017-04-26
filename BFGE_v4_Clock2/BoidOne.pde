

class BoidOne extends Boid {
  boolean hitPlayer = false;
  int count = (int)random(birdOneImages.length-1);
  BoidOne(int x, int y) {
    super(x, y);
    maxspeed = 33;
  }


  void display() {
    float angle = vel.heading() +radians(90);

    stroke(50, 50, 250);
    fill(255, 20, 2);
    pushMatrix();
      translate(loc.x, loc.y);
      //scale(2);
      rotate(angle);
      image(birdOneImages[count++], 0, 0 );
    popMatrix();
    if(count >= birdOneImages.length - 1) count = 0;
  }
  

  

  
}

