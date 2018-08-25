class StripeFilledRect {
  float shape_width;
  float shape_height;
  float shape_theta;
  float diagonal;
  float rotation_theta;
  float[] center   = new float[2]; // [x][y]
  float[] corner_1 = new float[2]; // [x][y]
  float[] corner_2 = new float[2]; // [x][y]
  float[] corner_3 = new float[2]; // [x][y]
  float[] corner_4 = new float[2]; // [x][y]
  float[] line_1   = new float[6]; // [x1][y1][x2][y2][slope][y-intercept]
  float[][] edges  = {new float[9], new float[9], new float[9], new float[9]}; // [[x1][y1][x2][y2][slope][y-intercept][x3][y3][distance]]
  
  StripeFilledRect(float _x, float _y, float _width, float _height) {
    center[0]    = _x;
    center[1]    = _y;
    line_1[0]    = _x;
    line_1[1]    = _y;
    shape_width  = _width;
    shape_height = _height;
    shape_theta  = atan2(shape_height / 2, shape_width / 2);
    diagonal     = sqrt((shape_width / 2) * (shape_width / 2) + (shape_height / 2) * (shape_height / 2));
  }
  
  void display() {
    float _x;
    float _y;
    float _x2;
    float _y2;
    int shortest_distance;
    int short_distance;
    
    rectMode(CENTER);
    noStroke();
    
    pushMatrix();
    translate(center[0], center[1]);
    rotate(rotation_theta);
    rect(0, 0, shape_width, shape_height);
    popMatrix();
   
    findCorners();
   
    stroke(0);
    
    _x = center[0];
    _y = center[1];
    _x2 = (diagonal * cos(mouse_theta)) + _x;
    _y2 = (diagonal * sin(mouse_theta)) + _y;
    line_1[2] = _x2;
    line_1[3] = _y2;
    
    line_1[4] = getSlope(line_1[0], line_1[1], line_1[2], line_1[3]);
    line_1[5] = getYIntercept(line_1[0], line_1[1], line_1[4]);
    
    for (int i = 0; i < edges.length; i++) {
      edges[i][4] = getSlope(edges[i][0], edges[i][1], edges[i][2], edges[i][3]);
      edges[i][5] = getYIntercept(edges[i][0], edges[i][1], edges[i][4]);
      
      if (!Float.isFinite(edges[i][4]) && !Float.isFinite(line_1[4])) {
         println("PARALLEL VERTICAL");
        edges[i][6] = center[0];
        edges[i][7] = edges[i][1];
      }else if (!Float.isFinite(edges[i][4])) {
         println("EDGE VERTICAL");
        edges[i][6] = edges[i][0];
        edges[i][7] = (line_1[4] * edges[i][6]) + line_1[5];
      }else if (!Float.isFinite(line_1[4])) {
         println("PATTERN VERTICAL");
        edges[i][6] = center[0];
        edges[i][7] = (edges[i][4] * edges[i][6]) + edges[i][5];
      }else if (line_1[4] == 0) {
         println("PATTERN HORIZONTAL");
         edges[i][6] = (line_1[5] - edges[i][5]) / (edges[i][4] - line_1[4]);
         edges[i][7] = center[1];
      }else {
         println("NORMAL");
        edges[i][6] = (line_1[5] - edges[i][5]) / (edges[i][4] - line_1[4]);
        edges[i][7] = (line_1[4] * edges[i][6]) + line_1[5];
      }
      
      edges[i][8] = dist(line_1[0], line_1[1], edges[i][6], edges[i][7]);
      
      printArray(edges[i]);
      println("--");
    }
    
    for (int i = 0; i < edges.length; i++) {
      fill(0);
      ellipse(edges[i][6], edges[i][7], 10, 10);
    }
    
    rotation_theta += 0.01;
    if (rotation_theta > 360) {
      rotation_theta = 0; 
    }

    shortest_distance = -1;
    short_distance = -1;
    for (int i = 0; i < edges.length; i++) {
      if (edges[i][8] == edges[i][8]) {
        if (shortest_distance == -1 || edges[i][8] <= edges[shortest_distance][8]) {
          shortest_distance = i;
        }
      }
    }
    
    if (shortest_distance == 0 || shortest_distance == 2) {
      shortest_distance = 0;
      short_distance = 2;
    }else if (shortest_distance == 1 || shortest_distance == 3) {
      shortest_distance = 1;
      short_distance = 3; 
    }

    //_x = (edges[shortest_distance][8] * cos(mouse_theta)) + edges[shortest_distance][6];
    //_y = (edges[shortest_distance][8] * sin(mouse_theta)) + edges[shortest_distance][7];
    //_x2 = (edges[short_distance][8] * cos(mouse_theta)) + edges[short_distance][6];
    //_y2 = (edges[short_distance][8] * sin(mouse_theta)) + edges[short_distance][7];
    _x = round(edges[shortest_distance][6]);
    _y = round(edges[shortest_distance][7]);
    _x2 = round(edges[short_distance][6]);
    _y2 = round(edges[short_distance][7]);
    //println(round(edges[shortest_distance][8]));
    //println(_x);
    //println(_y);
    //println(_x2);
    //println(_y2);
    //println("--");
    strokeWeight(2);
    line(_x, _y, _x2, _y2);
        
  }
  
  void findCorners() {
    float _x;
    float _y;
    float _x2;
    float _y2;

    _x = center[0] - diagonal * cos(-shape_theta + rotation_theta);
    _y = center[1] - diagonal * sin(-shape_theta + rotation_theta);
    corner_1[0] = _x;
    corner_1[1] = _y;
    edges[0][0] = _x;
    edges[0][1] = _y;
    edges[3][2] = _x;
    edges[3][3] = _y;
    
    _x = center[0] + diagonal * cos(shape_theta + rotation_theta);
    _y = center[1] + diagonal * sin(shape_theta + rotation_theta);
    corner_2[0] = _x;
    corner_2[1] = _y;
    edges[0][2] = _x;
    edges[0][3] = _y;
    edges[1][0] = _x;
    edges[1][1] = _y;
    
    _x = center[0] + diagonal * cos(-shape_theta + rotation_theta);
    _y = center[1] + diagonal * sin(-shape_theta + rotation_theta);
    corner_3[0] = _x;
    corner_3[1] = _y;
    edges[1][2] = _x;
    edges[1][3] = _y;
    edges[2][0] = _x;
    edges[2][1] = _y;
    
    _x = center[0] - diagonal * cos(shape_theta + rotation_theta);
    _y = center[1] - diagonal * sin(shape_theta + rotation_theta);
    corner_4[0] = _x;
    corner_4[1] = _y;
    edges[2][2] = _x;
    edges[2][3] = _y;
    edges[3][0] = _x;
    edges[3][1] = _y;
    
    strokeWeight(4);
    stroke(155, 155, 255);
    
    for (int i = 0; i < edges.length; i++) {
      _x = edges[i][0];
      _y = edges[i][1];
      _x2 = edges[i][2];
      _y2 = edges[i][3];
      line(_x, _y, _x2, _y2);
    }
  }
  
  float getSlope(float x1, float y1, float x2, float y2) {
    float slope;
    
    slope = (y2 - y1) / (x2 - x1);
    
    return slope;
  }
  
  float getYIntercept(float x, float y, float slope) {
    float y_intercept;
    
    y_intercept = y - (x * slope);
    
    return y_intercept;
  }
}
