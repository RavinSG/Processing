import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


Box2DProcessing box2d;

ArrayList<Boundary> boundaries;
ArrayList<Lollipop> pops;

void setup() {
  size(640, 360);
  box2d = new Box2DProcessing(this, 20);
  box2d.createWorld();
  box2d.setGravity(0, -20);

  pops = new ArrayList<Lollipop>();
  boundaries = new ArrayList<Boundary>();
  
  boundaries.add(new Boundary(width/3-30, height/3, width/4, 10, 3*PI/4));
  boundaries.add(new Boundary(width/4, height-5, width/2-50, 10, 0));
  boundaries.add(new Boundary(3*width/4, height-50, width/2- 50, 10, 0));
  boundaries.add(new Boundary(width-5, height/2, 10, height, 0));
  boundaries.add(new Boundary(5, height/2, 10, height, 0));
}

void draw() {
  background(255);

  box2d.step();

  for (Boundary wall : boundaries) {
    wall.display();
  }

  //for (Lollipop pop : pops) {
  //  pop.display();
  //}

  //for (int i = pops.size()-1; i >= 0; i--) {
  //  Lollipop p = pops.get(i);
  //  if (p.done()) {
  //    pops.remove(i);
  //  }
  //}
}

//void mousePressed() {
//  Lollipop p = new Lollipop(mouseX, mouseY);
//  pops.add(p);
//}
