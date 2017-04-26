// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids;           // An ArrayList for all the boids
  ArrayList<BoidOne> boidsOne;     // An ArrayList for type one the boids
  ArrayList<BoidTwo> boidsTwo;     // An ArrayList for type two the boids
  ArrayList<BoidThree> boidsThree; // An ArrayList for type three the boids
  ArrayList<BoidFour> boidsFour;   // An ArrayList for type four the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);                // Passing the entire list of boids to each boid individually
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
}



