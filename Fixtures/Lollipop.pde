class Lollipop {
  Body body;
  float w;
  float h;
  float r;

  Lollipop(float x, float y) {
    w = 8;
    h = 24;
    r = 8;

    makeBody(new Vec2(x, y));
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);

    if (pos.y > height + w + h) {
      killBody();
      return true;
    } else {
      return false;
    }
  }
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(127);
    stroke(0);
    strokeWeight(2);

    rect(0, 0, w, h);
    ellipse(0, -h/2, r*2, r*2);
    popMatrix();
  }

  void makeBody(Vec2 center) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    CircleShape circle = new CircleShape();
    circle.m_radius = box2d.scalarPixelsToWorld(r);
    Vec2 offset = new Vec2(0, -h/2);
    offset = box2d.vectorPixelsToWorld(offset);
    circle.m_p.set(offset.x, offset.y);

    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);

    body.createFixture(ps, 1.0);
    //body.createFixture(circle, 1.0);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = circle;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Attach Fixture to body
    body.createFixture(fd);


    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));
  }
}
