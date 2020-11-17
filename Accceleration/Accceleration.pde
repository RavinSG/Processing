PVector location;
PVector acceleration;
PVector velocity;
Mover[] movers;

void setup(){
  size(800,800);
  movers = new Mover[5];
  for (int i=0; i < movers.length; i++){
    movers[i] = new Mover();
  }
}


void draw(){
  background(255);
  for (Mover m: movers){
    
    if (mousePressed) {
      m.applyForce(new PVector(1,0));
    }
    
    m.update();
    m.edge();
    m.display();
  }
}
