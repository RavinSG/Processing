boolean debug = true;
FlowField flowfield;
ArrayList<Vehicle> vehicles;

void setup() {
  size(800, 800);
  flowfield = new FlowField(20);
  vehicles = new ArrayList<Vehicle>();
}

void draw() {
  println("Agent Count:", vehicles.size());
  background(255);
  if (debug) flowfield.display();
  if (mousePressed) {
    vehicles.add(new Vehicle(new PVector(mouseX, mouseY), random(2, 5), random(0.1, 0.5)));
  }
  for (Vehicle v : vehicles) {
    v.follow(flowfield);
    v.run();
  }
  flowfield.update();
}

void keyPressed() {
  if (key == ' ') {
    debug = !debug;
  }
}
