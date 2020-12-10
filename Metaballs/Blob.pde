class Blob {

  PVector pos;
  float r;
  PVector vel;
  float range;
  float illumination;
  float lifetime;
  float growthRate;
  boolean cytosis;

  Blob(float x, float y, PVector _vel, float _lifetime) {
    pos = new PVector(x, y);
    vel = _vel;
    cytosis = false;
    lifetime = _lifetime;
    r = 60;
    range = r *1.5;
    illumination = 100;
    growthRate = random(12, 20)/100;
  }

  void colourArea() {
    int topMargin = (int)max(0, pos.y-range);
    int botMargin = (int)min(height, pos.y+range);
    int leftMargin = (int)max(0, pos.x-range);
    int rightMargin = (int)min(width, pos.x+range);

    for (int x=leftMargin; x<rightMargin; x++) {
      for (int y=topMargin; y<botMargin; y++) {
        int index = x + y * width;
        float d = dist(x, y, pos.x, pos.y);
        if (d < range) {
          pixelArray[index] = color(min((16777216 + pixelArray[index])/65793 + illumination*r*r/(d*d), 255),255,255);
        }
      }
    }
  }

  void show() {
    noFill();
    stroke(255);
    strokeWeight(10);
    ellipse(pos.x, pos.y, 2*r, 2*r);
  }

  void startCellDeath() {
    cytosis = true;
  }

  void update() {
    pos.add(vel);
    if (!cytosis) { 
      illumination = illumination + growthRate;
    }
    lifetime += 1;
    if (pos.x<0 || pos.x > width) {
      vel.x = -vel.x;
    }
    if (pos.y<0 || pos.y > height) {
      vel.y = -vel.y;
    }
  }
}
