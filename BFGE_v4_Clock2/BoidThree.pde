
class BoidThree extends Boid {
  
  boolean hitPlayer = false;
  int count = (int)random(birdThreeImages.length-1);
  
  BoidThree(int x, int y) {
    super(x, y);
    maxspeed = 1.8;
  }

  void display() {
    float angle = vel.heading() +radians(90);

    stroke(50, 50, 250);
    fill(255, 20, 2);
    pushMatrix();
      translate(loc.x, loc.y);
      //scale(2);
      rotate(angle);
      image(birdThreeImages[count++], 0, 0 );
    popMatrix();
    if(count >= birdThreeImages.length - 1) count = 0;
  }
  

  

  
}

