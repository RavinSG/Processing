ArrayList<Blob> blobs;
color pixelArray[];

void setup() {
  size(800, 800);
  colorMode(HSB);
  blobs = new ArrayList();
  for (int i=0; i<1; i++) {
    //blobs.add(new Blob(random(width), random(height), PVector.random2D()));
    blobs.add(new Blob(width/2, height/2, new PVector(0, 0), 0));
  }
}

void draw() {
  background(0);
  loadPixels();

  if (mousePressed) {
    blobs.add(new Blob(mouseX, mouseY, new PVector(0, 0), 0));
  }

  pixelArray = pixels;
  //for (Blob blob : blobs) {
  //  blob.colourArea();
  //}
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      int index = x + y * width;
      float total = 0;
      for (Blob b : blobs) {
        float d = b.illumination*b.r*b.r/pow(dist(x, y, b.pos.x, b.pos.y),2);
        total += d;
      }

      pixelArray[index] = color(total%255,255,255);
    }
  }
  pixels=pixelArray;
  updatePixels();

  for (int i=blobs.size()-1; i>-1; i--) {
    Blob blob=blobs.get(i);
    blob.update();
    if (blob.illumination > 200) {
      blobs.remove(blob);
      PVector oldPos = blob.pos;
      float oldLife = blob.lifetime;
      blobs.add(new Blob(oldPos.x, oldPos.y, PVector.random2D(), 0));
      blobs.add(new Blob(oldPos.x, oldPos.y, PVector.random2D(), oldLife));
    }

    if (blob.lifetime > 1000 && !blob.cytosis) {
      blob.startCellDeath();
      println("Cell is dying");
    }
    
    if (blob.cytosis){
      if (blob.illumination >0){
        blob.illumination -= 1;
      } else {
        blobs.remove(blob);
      }
    }
  }
}
