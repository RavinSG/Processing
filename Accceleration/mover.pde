class Mover{
  PVector location;
  PVector velocity;
  PVector gravity;
  float mass;
  
  Mover(){
    location = new PVector(random(0,width),height/2);
    mass = random(5,25);
    velocity = new PVector(0,0);
    velocity.limit(5);
    gravity = new PVector(0,0.1);
  }
  
  void update(){
    PVector mouse = new PVector(mouseX, mouseY);
    mouse.sub(location);
    velocity.add(gravity);
    location.add(velocity);
  }
  
  void display(){
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,mass*2,mass*2);
  }
  
  void applyForce(PVector force){
    PVector acceleration = PVector.div(force,mass);
    velocity.add(acceleration);
  }
  
  void edge(){
    if (location.x > width){
      location.x = width;
      velocity.x = - velocity.x;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x = - velocity.x;
    }
    
    if (location.y > height){
      location.y = height;
      velocity.y = - velocity.y;
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y = - velocity.y;
    }
  }
}
