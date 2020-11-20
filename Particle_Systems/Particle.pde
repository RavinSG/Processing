class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  float mass = 1; 

  Particle(PVector pos) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = pos.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);   
    acceleration.add(f);
  }

  void distanceForce(PVector pos, float scale) {
    PVector force = PVector.sub(position, pos);
    force.setMag(scale/pos.mag());
    applyForce(force);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 2.0;
  }

  void display() {
    stroke(0, lifespan);
    strokeWeight(2);
    fill(127, lifespan);
    ellipse(position.x, position.y, 12, 12);
  }

  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}
