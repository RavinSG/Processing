class Pendulum {
  PVector position = new PVector(0, 0);
  PVector origin = new PVector(0, 0);
  float angle;
  float aVel = 0;
  float r;
  float g = 0.3;

  Pendulum(float angle_, float r_) {
    r = r_;
    angle = angle_;
  }

  void display() {
    stroke(255);
    

    position.x = origin.x + r * sin(angle);
    position.y = origin.y + r * cos(angle);

    float force = -g * sin(angle) / r;
    aVel += force;
    aVel *= 1;
    angle += aVel;

    line(origin.x, origin.y, position.x, position.y);
    ellipse(position.x, position.y, 20, 20);
  }
}
