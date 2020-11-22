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
ArrayList<Pair> pairs;

void setup() {
  size(640, 360);

  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  boundaries = new ArrayList<Boundary>();
  pairs = new ArrayList<Pair>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/4, height-5, width/2-50, 10));
  boundaries.add(new Boundary(3*width/4, height-50, width/2-50, 10));
}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();

  for (Pair p : pairs) {
    p.display();
  }

  for (Boundary wall : boundaries) {
    wall.display();
  }

  fill(0);
}

void mousePressed() {
  Pair p = new Pair(mouseX, mouseY);
  pairs.add(p);
}
