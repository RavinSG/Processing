Mover[] movers = new Mover[8];
Liquid liquid;

void setup(){
  size(600,400);
  smooth();
  reset();
  liquid = new Liquid(0, height/2, width, height/2, 0.1);
}

void draw(){
  background(255);
  liquid.display();
  
  for (Mover mover: movers){
    if (liquid.contains(mover)){
      PVector dragForce = liquid.drag(mover);
      dragForce.mult(pow(mover.mass,2/3));
      mover.applyForce(dragForce);
    }
    mover.update();
    mover.checkEdges();
    mover.display();
  
 }
  
  fill(0);
  text("click mouse to reset", 10, 30);
  
}

void mousePressed() {
  reset();
}

void reset() {
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.5, 3), 40+i*70, 0);
  }
}
