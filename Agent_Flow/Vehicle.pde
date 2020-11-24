class Vehicle {
  PVector position;
  PVector velocity;
  PVector acceleration;

  float r;
  float maxSpeed;
  float maxForce;

  Vehicle(PVector pos, float ms, float mf) {
    position = pos.copy();
    maxSpeed = ms;
    maxForce = mf;

    r = 5;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(position);
    desired.mult(maxSpeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void run() {
    update();
    borders();
    display();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void borders() {
    if (position.x < -r) position.x = width+r;
    else if (position.y < -r) position.y = height+r;

    if (position.x > width+r) position.x = -r;
    else if (position.y > height+r) position.y = -r;
  }

  void display() {
    float theta = velocity.heading() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
}
