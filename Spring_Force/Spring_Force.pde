Mover bob;
float restLength;
float k;

void setup() {
  size(640,360);
  restLength = 150;
  k = 0.02;
  bob = new Mover(new PVector(width/2,restLength),2);
  
}

void draw() {
  background(255);
  bob.springForce(restLength,k);
  bob.update();
  bob.display();
}

void mousePressed(){
  PVector wind = PVector.sub(bob.position,new PVector(mouseX,mouseY));
  wind.setMag(1000/wind.mag());
  //wind.limit(5);
  bob.applyForce(wind);
}
