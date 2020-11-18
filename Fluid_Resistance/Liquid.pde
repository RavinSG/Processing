class Liquid{
   float x,y,w,h;
   float c;
   
   Liquid(float x_, float y_, float w_, float h_, float c_){
     x = x_;
     y = y_;
     w = w_;
     h = h_;
     c = c_;
   }

    void display() {
      noStroke();
      fill(50);
      rect(x, y, w, h);
    }
    
   boolean contains(Mover m){
     PVector l = m.position;
     if (l.y > y){
       return true;
     }
     else {
       return false;
     }
   }
   
   PVector drag(Mover m){
     PVector dragForce = m.velocity.copy();
     dragForce.normalize();
     dragForce.mult(-1 * c * pow(m.velocity.mag(),2));
     return dragForce;
   }
}
