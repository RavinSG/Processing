class Box {
  Body body;
  float w, h;

  Box(float x, float y) {
    w = 16;
    h = 16;

    // Body related to physics
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));

    body = box2d.createBody(bd);
    // Polygon shape
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2); // Box2d considers width and height as
    float box2dH = box2d.scalarPixelsToWorld(h/2); // values from center.
    ps.setAsBox(box2dW, box2dH);

    // Attaches a shape to a body and sets properties such as density, friction, and restitution.
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    // Physics parameters
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Attach Fixture to body
    body.createFixture(fd);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height + h) {
      killBody();
      return true;
    }
    return false;
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(127);
    stroke(0);
    strokeWeight(2);
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
}
