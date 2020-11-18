PVector location;
PVector acceleration;
PVector velocity;
Mover[] movers;

void setup(){
  size(500,1000);
  movers = new Mover[5];
  for (int i=0; i < movers.length; i++){
    movers[i] = new Mover(i);
  }
}


void draw(){
  background(255);
  for (Mover m: movers){
    // Air resistance
    PVector friction = m.velocity.copy();
    friction.normalize();
    friction.mult(-0.5 * pow(m.velocity.mag(),2) * 0.03 * pow(m.mass,2/3));
    m.applyForce(friction);
    //if (mousePressed) {
      //m.applyForce(new PVector(1,0));    
    //}
    
    m.update();
    m.edge(0.8);
    m.display();
  }
}
