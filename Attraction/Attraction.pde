Positive[] positives;
Negative[] negatives;
float G = 5;

void setup() {
  size(800,800);
  int num_pos = 5;
  int num_neg = 10;
  
  positives = new Positive[num_pos];
  negatives = new Negative[num_neg];
  for (int i=0; i < positives.length; i++){
    positives[i] = new Positive();
  }
  for (int i=0; i < negatives.length; i++){
    negatives[i] = new Negative();
  }
   
}

void draw() {
  background(255);
  
  
  for (Positive pos: positives){
    for (Positive n_pos: positives){
      if (pos != n_pos) {
        PVector force = PVector.sub(n_pos.position, pos.position);
        float d = force.mag();
        d = constrain(d, 5, 25.0);
        force.normalize();
        force.mult(-1 * pos.mass * n_pos.mass * G / pow(d, 2));
        pos.applyForce(force);
      }
    }
    for (Negative n_neg: negatives){
      PVector force = PVector.sub(n_neg.position, pos.position);
      float d = force.mag();
      d = constrain(d, 5, 25.0);
      force.normalize();
      force.mult(pos.mass * n_neg.mass * G / pow(d, 2));
      pos.applyForce(force);
    }
    pos.edge();
    pos.update();
    pos.display();

  }
  
  for (Negative neg: negatives){
    for (Positive n_pos: positives){
      PVector force = PVector.sub(n_pos.position, neg.position);
      float d = force.mag();
      d = constrain(d, 5, 25.0);
      force.normalize();
      force.mult(neg.mass * n_pos.mass * G / pow(d, 2));
      neg.applyForce(force);
    }
     for (Negative n_neg: negatives){
      PVector force = PVector.sub(n_neg.position, neg.position);
      float d = force.mag();
      d = constrain(d, 5, 25.0);
      force.normalize();
      force.mult(-1 * neg.mass * n_neg.mass * G / pow(d, 2));
      neg.applyForce(force);
    }
   
    neg.edge();
    neg.update();
    neg.display();
  }
  
}
