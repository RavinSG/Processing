Pendulum[] pendulums;

void setup() {
  size(800, 800);
  int numPen = 20;
  pendulums = new Pendulum[numPen];
  for (int i=0; i<numPen; i++) {
    pendulums[i] = new Pendulum(PI/4, 30*(i+1));
  }
}

void draw() {
  background(0);
  translate(width/2, height/4);
  for (Pendulum p : pendulums) {
    p.display();
  }
}
