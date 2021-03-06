class FlowField {

  PVector[][] field;
  int cols, rows;
  int resolution;
  float zoff = 0;

  FlowField(int r) {
    resolution = r;
    cols = width / resolution;
    rows = height / resolution;

    field = new PVector[cols][rows];
    init();
  }


  void init() {
    noiseSeed((int)random(10000));
    update();
    //float xoff = 0;
    //for (int i = 0; i < cols; i++) {
    //  float yoff = 0;
    //  for (int j = 0; j < rows; j++) {
    //    float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);
    //    field[i][j] = new PVector(cos(theta), sin(theta));
    //    yoff += 0.1;
    //  }
    //  xoff += 0.1;
    //}
  }

  void update() {
    float xoff = 0;
    for (int i=0; i < cols; i++) {
      float yoff = 0;
      for (int j=0; j < rows; j++) {
        float theta = map(noise(xoff, yoff,zoff), 0, 1, 0, TWO_PI);
        field[i][j] = new PVector(cos(theta), sin(theta));
        yoff += 0.1;
      }
      xoff += 0.1;
    }
    zoff += 0.01;
  }

  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        drawVector(field[i][j], i*resolution, j*resolution, resolution-2);
      }
    }
  }

  void drawVector(PVector v, float x, float y, float scale) {
    pushMatrix();
    //float arrowSize = 4;
    translate(x, y);
    stroke(0, 150);
    rotate(v.heading());

    float len = v.mag()*scale;
    line(0, 0, len, 0);
    popMatrix();
  }


  PVector lookup(PVector pos) {
    int column = int(constrain(pos.x/resolution, 0, cols-1));
    int row = int(constrain(pos.y/resolution, 0, rows-1));
    return field[column][row].copy();
  }
}
