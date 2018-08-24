class StripeFilledRect {
  int x;
  int y;
  int w;
  int h;
  float distance;
  float x2;
  float y2;
  float rotation_theta;
  float[] line_1 = new float[2];
  float[] line_2 = new float[2];
  float[] line_3 = new float[2];
  float[] line_4 = new float[2];
  
  StripeFilledRect(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    distance = sqrt((w / 2) * (w / 2) + (h / 2) * (h / 2));
  }
  
  void display() {
    rectMode(CENTER);
    noStroke();
    
    pushMatrix();
    translate(x, y);
    rotate(rotation_theta);
    rect(0, 0, w, h);
    popMatrix();
   
    findCorners();
   
    stroke(0);
    
    x2 = (distance * cos(theta)) + x;
    y2 = (distance * sin(theta)) + y;
    
    findIntersect();
    
    //x2 = (-distance * cos(theta)) + x;
    //y2 = (-distance * sin(theta)) + y;
    
    //findIntersect();
        
    rotation_theta += 0.01;
    if (rotation_theta > 360) {
      rotation_theta = 0; 
    }
  }
  
  void findCorners() {
    float rectAngle = atan2(h / 2, w / 2);

    line_1[0] = x - distance * cos(-rectAngle + rotation_theta);
    line_1[1] = y - distance * sin(-rectAngle + rotation_theta);
    line_2[0] = x + distance * cos(rectAngle + rotation_theta);
    line_2[1] = y + distance * sin(rectAngle + rotation_theta);
    line_3[0] = x + distance * cos(-rectAngle + rotation_theta);
    line_3[1] = y + distance * sin(-rectAngle + rotation_theta);
    line_4[0] = x - distance * cos(rectAngle + rotation_theta);
    line_4[1] = y - distance * sin(rectAngle + rotation_theta);
    
    stroke(255, 0, 0);
    line(line_1[0], line_1[1], line_2[0], line_2[1]);
    line(line_2[0], line_2[1], line_3[0], line_3[1]);
    line(line_3[0], line_3[1], line_4[0], line_4[1]);
    line(line_4[0], line_4[1], line_1[0], line_1[1]);
  }
  
  void findIntersect() {
    float[] intersect_1 = new float[2];
    float[] intersect_2 = new float[2];
    float[] intersect_3 = new float[2];
    float[] intersect_4 = new float[2];
    
    line(x, y, x2, y2);
  }
}
