var w;
var x1 = 14;
var x2 = 75;
var x3 = 123;

function setup() {
 createCanvas(640, 360); 
 w = new Walker();
}

function draw() {
  background(51);
  w.display();
  w.update();
}



function Walker(){
  this.pos = createVector(width/2, height/2);
  this.vel = createVector(0,0);
  this.acc = createVector(0,0);

  this.display = function(){
    fill(color(noise(x1) * 255,noise(x2) * 255,noise(x3) * 255));
    x1 = x1 + 0.005;
    x2 = x2 + 0.005;
    x3 = x3 + 0.005;
    ellipse(this.pos.x, this.pos.y, 48, 48)
  }
  
  this.update = function(){
    this.mousePos = createVector(mouseX, mouseY);
    console.log(this.mousePos);
    this.acc = p5.Vector.sub(this.mousePos, this.pos);
    //this.acc.normalize();
    //this.acc.mult(5);
    this.acc.setMag(0.4);
    this.vel.add(this.acc);
    this.pos.add(this.vel);

  }
  
}
