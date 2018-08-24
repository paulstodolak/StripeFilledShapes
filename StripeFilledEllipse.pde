class StripeFilledEllipse {
  int x;
  int y;
  int w;
  int h;
  int distance;
  float x2;
  float y2;
  float rotation_theta;
  
  StripeFilledEllipse(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    if (w >= h) {
      distance = w / 2;
    }else {
      distance = h / 2;
    }
  }
  
  void display() {
    ellipseMode(CENTER);
    fill(155, 30, 200);
    noStroke();
    
    pushMatrix();
    translate(x, y);
    rotate(rotation_theta);
    ellipse(0, 0, w, h);
    popMatrix();
    
    stroke(0);
    
    x2 = (distance * cos(theta)) + x;
    y2 = (distance * sin(theta)) + y;
    
    line(x, y, x2, y2);
    
    x2 = (-distance * cos(theta)) + x;
    y2 = (-distance * sin(theta)) + y;
    
    line(x, y, x2, y2);
    
    rotation_theta += 0.01;
    if (rotation_theta > 360) {
      rotation_theta = 0; 
    }
  }
}
