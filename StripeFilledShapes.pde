StripeFilledRect shape_1_rect;
StripeFilledEllipse shape_2_ellipse;
StripeFilledRect shape_3_rect;

void setup() {
  // Set the size of the sketch
  size(1000, 1000);
  frameRate(30);
  
  shape_1_rect    = new StripeFilledRect(250, 500, 200, 200);
  shape_2_ellipse = new StripeFilledEllipse(500, 500, 200, 200);
  shape_3_rect    = new StripeFilledRect(750, 500, 200, 200);
}

void draw() {
  // Clear the stage
  background(255);
  
  // Set Stroke
  stroke(0);
  
  // Draw Lines
  line(0, 500, 1000, 500);
  line(500, 0, 500, 1000);
  
  // Draw Shapes
  shape_1_rect.display();
  shape_2_ellipse.display();
  shape_3_rect.display();
}

class StripeFilledRect {
  int x;
  int y;
  int w;
  int h;
  long diagonal;
  
  StripeFilledRect(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    diagonal = Math.round(Math.sqrt((w * w) + (h * h)));
    println(diagonal);
  }
  
  void display() {
    rectMode(CENTER);
    noStroke();
    rect(x, y, w, h);
    stroke(0);
    line(x, y, x, y + diagonal);
  }
}

class StripeFilledEllipse {
  int x;
  int y;
  int w;
  int h;
  int diameter;
  
  StripeFilledEllipse(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    if (w >= h) {
      diameter = w;
    }else {
      diameter = h;
    }
  }
  
  void display() {
    ellipseMode(CENTER);
    fill(155, 30, 200);
    noStroke();
    ellipse(x, y, w, h);
    stroke(0);
    line(x, y, x, y + diameter);
  }
}
