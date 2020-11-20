import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

ArrayList<Box> boxes;
Box2DProcessing box2d;  
Surface surface;

void setup() {
  size(1000, 800);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  box2d.setGravity(0, -10);

  boxes = new ArrayList<Box>();
  surface = new Surface();
}

void draw() {
  background(255);
  box2d.step();

  if (mousePressed) {
    Box b = new Box(mouseX, mouseY);
    boxes.add(b);
  }

  for (Box box : boxes) {
    box.display();
  }
  surface.display();

  for (int i = boxes.size()-1; i >= 0; i--) {
    Box p = boxes.get(i);
    if (p.done()) {
      boxes.remove(i);
    }
  }
}
