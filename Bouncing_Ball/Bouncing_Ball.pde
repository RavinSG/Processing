PVector location;
PVector velocity;


void setup() {
  size(800,800);
  background(255);
  location = new PVector(width/2,height/2);
  velocity = new PVector(2, -2);
}

void draw() {
  background(255);
  //println(PVector.random2D());
  location = location.add(velocity);
  
  if ((location.x > width) || (location.x < 0)) { 
    velocity.x = velocity.x * -1;
  }
  if ((location.y > height) || (location.y < 0)) {
    velocity.y = velocity.y * -1;
  }
  
  stroke(0);
  fill(175);
  ellipse(location.x,location.y,16,16); 
}
