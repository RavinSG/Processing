class Mover {
  PVector origin = new PVector(width/2, 0);
  PVector velocity = new PVector(0, 0);
  PVector acceleration = new PVector(0, 0);
  PVector gravity = new PVector(0, 1);
  PVector position;
  float mass;

  Mover(PVector p_, float m_) {
    position = p_;
    mass = m_;
  }

  void display() {
    fill(150);
    line(origin.x, origin.y, position.x, position.y);
    ellipse(position.x, position.y, 20, 20);
  }

  void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }

  void springForce(float restlen, float k) {
    PVector displacement = PVector.sub(position, origin);
    float force = -k * (displacement.mag() - restlen); 
    applyForce(displacement.setMag(force));
  }


  void update() {
    acceleration.add(gravity);
    velocity.add(acceleration);
    velocity.mult(0.99);
    position.add(velocity);
    acceleration.setMag(0);
  }
}
