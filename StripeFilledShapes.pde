StripeFilledRect shape_1_rect;
StripeFilledEllipse shape_2_ellipse;
StripeFilledRect shape_3_rect;
StripeFilledEllipse shape_4_ellipse;
StripeFilledEllipse shape_5_ellipse;

float mouse_theta;

void setup() {
  // Set the size of the sketch
  size(1000, 1000);
  frameRate(30);
  
  shape_1_rect    = new StripeFilledRect(250, 500, 200, 200);
  shape_2_ellipse = new StripeFilledEllipse(500, 500, 200, 200);
  shape_3_rect    = new StripeFilledRect(750, 500, 300, 200);
  shape_4_ellipse = new StripeFilledEllipse(500, 250, 150, 250);
  shape_5_ellipse = new StripeFilledEllipse(500, 750, 250, 150);
}

void draw() {
  // Clear the stage
  background(255);
  
  // Set Stroke
  stroke(0);
  
  // Draw Lines
  line(0, 500, 1000, 500);
  line(500, 0, 500, 1000);

  // Update theta
  mouse_theta = atan2(mouseY - height / 2, mouseX - width / 2);

  // Draw Shapes
  shape_1_rect.display();
  shape_2_ellipse.display();
  shape_3_rect.display();
  shape_4_ellipse.display();
  shape_5_ellipse.display();
  
  //noLoop();
}
