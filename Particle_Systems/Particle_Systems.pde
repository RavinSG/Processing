ArrayList<ParticleSystem> particleSystems;

void setup() {
  size(640, 360);
  particleSystems = new ArrayList<ParticleSystem>();
}

void draw() {
  background(255);

  for (ParticleSystem ps : particleSystems) {
    if (mousePressed) {
      ps.distaceForce(new PVector(mouseX, mouseY), 50);
    }

    PVector gravity = new PVector(0, 0.1);
    ps.applyForce(gravity);

    ps.addParticle();
    ps.run();
  }
}

void keyPressed() {
  particleSystems.add(new ParticleSystem(new PVector(mouseX, mouseY)));
}
