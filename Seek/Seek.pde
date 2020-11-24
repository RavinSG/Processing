Vehicle v;
Seeker s;
boolean debug = true;

float d = 25;

void setup() {
  size(640, 360);
  v = new Vehicle(width/2, height/2);
  s = new Seeker(20, 20);
}

void draw() {
  background(255);
   
  PVector dist = PVector.sub(s.position,v.position);
  dist.limit(100);
  //s.arrive(v.position);
  s.arrive(PVector.add(v.position,PVector.mult(v.velocity,dist.mag())));
  s.update();
  s.display();
  if (debug) {
    stroke(175);
    noFill();
    rectMode(CENTER);
    rect(width/2, height/2, width-d*2, height-d*2);
  }

  v.boundaries();
  v.run();
}
