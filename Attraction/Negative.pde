class Negative{
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  Negative(){
    position = new PVector(random(0,width),random(0,height));
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = 1;
  }
  
  void applyForce(PVector force){
    force.div(mass);
    acceleration.add(force);
  }
  
  void update(){
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }
    
  void edge(){
    if (position.x > width){
      position.x = width;
      velocity.x = - velocity.x;
    } else if (position.x < 0) {
      position.x = 0;
      velocity.x = - velocity.x;
    }
    
    if (position.y > height){
      position.y = height;
      velocity.y = - velocity.y;
    } else if (position.y < 0) {
      position.y = 0;
      velocity.y = - velocity.y;
    }
  }
  void display(){
    stroke(0);
    fill(0,0,255);
    ellipse(position.x, position.y,20,20);
  }
}
