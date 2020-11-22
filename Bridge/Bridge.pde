import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Particle> bridgeParticles;
ArrayList<Particle> dropParticles;
PVector startPos;
PVector endPos;

void setup() {
  size(800, 500);
  float gap = 10;

  Particle p1;
  Particle p2;

  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  startPos = new PVector(0, 50);
  endPos = new PVector(width, 50);
  bridgeParticles = new ArrayList<Particle>();
  dropParticles = new ArrayList<Particle>();

  Particle start = new Particle(startPos.x, startPos.y, BodyType.STATIC, 4);
  bridgeParticles.add(start);

  for (float x=gap; x < width; x += gap) {
    Particle p = new Particle(x, 50, BodyType.DYNAMIC, 4);
    bridgeParticles.add(p);
  }

  Particle end = new Particle(endPos.x, endPos.y, BodyType.STATIC, 4);
  bridgeParticles.add(end);

  for (int i=0; i<bridgeParticles.size()-1; i++) {

    p1 = bridgeParticles.get(i);
    p2 =  bridgeParticles.get(i+1);

    DistanceJointDef djd = new DistanceJointDef();

    djd.bodyA = p1.body;
    djd.bodyB = p2.body;

    djd.length = box2d.scalarPixelsToWorld(gap);
    djd.frequencyHz = 0;
    djd.dampingRatio = 1;
    box2d.createJoint(djd);
  }
}

void draw() {
  background(255);
  box2d.step();
  PVector pos1 = endPos.copy();
  PVector pos2;

  if (mousePressed) {
    BodyType type = BodyType.DYNAMIC;
    Particle p = new Particle(mouseX, mouseY, type, 8);
    dropParticles.add(p);
  }

  for (Particle p : bridgeParticles) {
    p.display();
  }

  for (Particle p : dropParticles) {
    p.display();
  }
  
  for (int i = bridgeParticles.size()-1; i >= 0; i--) {
    Particle p = bridgeParticles.get(i);
    pos2 = box2d.coordWorldToPixelsPVector(p.body.getPosition());
    line(pos1.x, pos1.y, pos2.x, pos2.y);
    if (p.done()) {
      bridgeParticles.remove(i);
    }
    pos1 = pos2.copy();
  }
}

//void mousePressed() {
//}
