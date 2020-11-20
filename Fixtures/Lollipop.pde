class Lollipop{
  Body body;
  float w;
  float h;
  float r;
  
  Lollipop(float x, float y) {
    w = 8;
    h = 24;
    r = 8;
    
    makeBody(new Vec2(x,y));
  
  }
  
  void killBody(){
    box2d.destroyBody(body);
  }
  
}
