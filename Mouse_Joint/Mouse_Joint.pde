import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


Box2DProcessing box2d;
ArrayList<Boundary> boundaries;
ArrayList<Box> boxes;
Spring spring;

void setup() {
  size(640, 360);

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();

  boundaries = new ArrayList();
  boundaries.add(new Boundary(width/2, height-5, width, 10, 0));
  boundaries.add(new Boundary(width/2, 5, width, 10, 0));
  boundaries.add(new Boundary(width-5, height/2, 10, height, 0));
  boundaries.add(new Boundary(5, height/2, 10, height, 0));

  boxes = new ArrayList();
  boxes.add(new Box(width/2, height/2));

  spring = new Spring();
}

void mouseReleased() {
  spring.destroy();
}

void mousePressed() {
  for (Box box : boxes) {
    if (box.contains(mouseX, mouseY)) {
      spring.bind(mouseX, mouseY, box);
      break;
    }
  }
}

void draw() {
  background(255);
  box2d.step();
  spring.update(mouseX,mouseY);
  //spring.display();
  for (int i = 0; i < boundaries.size(); i++) {
    Boundary wall = (Boundary) boundaries.get(i);
    wall.display();
  }

  for (Box box : boxes) {
    box.display();
  }
}

void keyPressed() {
  boxes.add(new Box(mouseX, mouseY));
}

void beginContact(Contact cp){
  Body b1 = cp.getFixtureA().getBody();
  Body b2 = cp.getFixtureB().getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if (o1==null || o2==null)
     return;
     
  if (o1.getClass() == Box.class && o2.getClass() == Box.class){
    Box box1 = (Box) o1;
    Box box2 = (Box) o2;
    box1.change();
    box2.change();
  }
   
}

void endContact(Contact cp) {
}
