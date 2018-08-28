class StripeFilledRect extends StripeFilledShape {
  float DIAGONAL;
  float HALF_DIAGONAL;
  int PATTERN_AMOUNT;
  PVector[] RECT_CORNERS = new PVector[4];
  Edge[] edges           = new Edge[4];
  Stripe[] stripes       = new Stripe[0];
  
  float perpendicular_theta;
    
  StripeFilledRect(float _x, float _y, float _width, float _height, float _pattern_width, float _pattern_gap) {
    super(_x, _y, _width, _height, _pattern_width, _pattern_gap);
    initializeConstants();
  }
  
  StripeFilledRect(PVector _origin, float _width, float _height, float _pattern_width, float _pattern_gap) {
    super(_origin, _width, _height, _pattern_width, _pattern_gap);
    initializeConstants();
  }
  
  void initializeConstants() {
    DIAGONAL       = sqrt((SHAPE_WIDTH) * (SHAPE_WIDTH) + (SHAPE_HEIGHT) * (SHAPE_HEIGHT));
    HALF_DIAGONAL  = DIAGONAL / 2;
    PATTERN_AMOUNT = round(DIAGONAL / (PATTERN_WIDTH + PATTERN_BUFFER));
    println(PATTERN_AMOUNT);
  }
  
  void display() {
    float x1;
    float y1;
    float x2;
    float y2;;
    
    rectMode(CENTER);
    noStroke();
    
    pushMatrix();
    translate(ORIGIN.x, ORIGIN.y);
    rotate(rotation_theta);
    rect(0, 0, SHAPE_WIDTH, SHAPE_HEIGHT, 0.25);
    popMatrix();
   
    perpendicular_theta = mouse_theta + HALF_PI;
   
    findCorners();
    
    edges[0] = new Edge(RECT_CORNERS[0], RECT_CORNERS[1]);
    edges[1] = new Edge(RECT_CORNERS[1], RECT_CORNERS[2]);
    edges[2] = new Edge(RECT_CORNERS[2], RECT_CORNERS[3]);
    edges[3] = new Edge(RECT_CORNERS[3], RECT_CORNERS[0]);

    stroke(255, 0, 0);
 
    // Get perpendicular line
    x1 = (HALF_DIAGONAL * cos(perpendicular_theta)) + ORIGIN.x;
    y1 = (HALF_DIAGONAL * sin(perpendicular_theta)) + ORIGIN.y;
    x2 = (-HALF_DIAGONAL * cos(perpendicular_theta)) + ORIGIN.x;
    y2 = (-HALF_DIAGONAL * sin(perpendicular_theta)) + ORIGIN.y;
    line(x1, y1, x2, y2);

    // Draw Edges
    for (int i = 0; i < edges.length; i++) {
      edges[i].display();
    }

    stroke(0);
    // Draw Pattern
    int toggle = -1;
    int offset_count = 0;
    ellipse(ORIGIN.x, ORIGIN.y, 5, 5);
    for (int i = 1; i < PATTERN_AMOUNT; i++) {
      Stripe stripe;
      int offset;
      
      offset = round((PATTERN_WIDTH + PATTERN_BUFFER) * offset_count) * toggle;
      x1 = (offset * cos(perpendicular_theta)) + ORIGIN.x;
      y1 = (offset * sin(perpendicular_theta)) + ORIGIN.y;
      x2 = (HALF_DIAGONAL * cos(mouse_theta)) + x1;
      y2 = (HALF_DIAGONAL * sin(mouse_theta)) + y1;
      stripe = new Stripe(x1, y1, x2, y2);
      
      stripes = (Stripe[]) append(stripes, stripe);
      
      if (toggle == -1) {
        offset_count++;
      }
      toggle = toggle * -1;

      strokeWeight(PATTERN_WIDTH);

      stripe.findClosestEdge(edges);
    }
    
    /*for (int i = 0; i < edges.length; i++) {
      fill(0);
      ellipse(edges[i][6], edges[i][7], 10, 10);
    }*/
    
    incrementRotation();    
  }
  
  void findCorners() {
    float x;
    float y;

    x = ORIGIN.x - HALF_DIAGONAL * cos(-SHAPE_THETA + rotation_theta);
    y = ORIGIN.y - HALF_DIAGONAL * sin(-SHAPE_THETA + rotation_theta);
    RECT_CORNERS[0] = new PVector(x, y);

    x = ORIGIN.x + HALF_DIAGONAL * cos(SHAPE_THETA + rotation_theta);
    y = ORIGIN.y + HALF_DIAGONAL * sin(SHAPE_THETA + rotation_theta);
    RECT_CORNERS[1] = new PVector(x, y);

    x = ORIGIN.x + HALF_DIAGONAL * cos(-SHAPE_THETA + rotation_theta);
    y = ORIGIN.y + HALF_DIAGONAL * sin(-SHAPE_THETA + rotation_theta);
    RECT_CORNERS[2] = new PVector(x, y);
    
    x = ORIGIN.x - HALF_DIAGONAL * cos(SHAPE_THETA + rotation_theta);
    y = ORIGIN.y - HALF_DIAGONAL * sin(SHAPE_THETA + rotation_theta);
    RECT_CORNERS[3] = new PVector(x, y);
  }
}
