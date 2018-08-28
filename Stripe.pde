class Stripe extends Pattern {
  PVector START_POINT_LIMIT;
  PVector END_POINT_LIMIT;
 
  Stripe(float _x1, float _y1, float _x2, float _y2) {
    super(_x1, _y1, _x2, _y2);
  }
  
  Stripe(PVector _start_point, PVector _end_point) {
    super(_start_point, _end_point);
  }
  
  void display() {
    strokeWeight(4);
    stroke(155, 155, 255);
    
    line(START_POINT_LIMIT.x, START_POINT_LIMIT.y, END_POINT_LIMIT.x, END_POINT_LIMIT.y);
  }
  
  void findClosestEdge(Edge[] _edges) {
    PVector targets[] = new PVector[_edges.length];
    float shortest_distance;
    float target_index;
    
    shortest_distance = -1;
    target_index = -1;
    
    for (int i = 0; i < _edges.length; i++) {
      float edge_slope;
      float edge_y_intercept;
      PVector point_a;
      PVector point_b;
      float x1;
      float y1;
      float x2;
      float y2;
      float distance;
      
      point_a = getStartPoint();
      point_b = _edges[i].getStartPoint();
      
      edge_slope       = _edges[i].getSlope();
      edge_y_intercept = _edges[i].getYIntercept();
      
      x1 = START_POINT.x;
      y1 = START_POINT.y;
        
      if (!Float.isFinite(edge_slope) && !Float.isFinite(SLOPE)) {
        // println("PARALLEL VERTICAL");
        x2 = x1;
        y2 = point_b.y;
      }else if (!Float.isFinite(edge_slope)) {
        // println("EDGE VERTICAL");
        x2 = point_b.x;
        y2 = getY(x2, SLOPE, Y_INTERCEPT);
      }else if (!Float.isFinite(SLOPE)) {
        // println("PATTERN VERTICAL");
        x2 = x1;
        y2 = getY(x2, edge_slope, edge_y_intercept);
      }else if (SLOPE == 0) {
        // println("PATTERN HORIZONTAL");
        x2 = getX(SLOPE, Y_INTERCEPT, edge_slope, edge_y_intercept);
        y2 = y1;
      }else {
        // println("NORMAL");
        x2 = getX(SLOPE, Y_INTERCEPT, edge_slope, edge_y_intercept);
        y2 = getY(x2, SLOPE, Y_INTERCEPT);
      }
      
      distance = dist(x1, y1, x2, y2);
      
      targets[i] = new PVector(x2, y2);
      
      if (shortest_distance == -1 || distance < shortest_distance) {
        shortest_distance = distance;
        target_index = i;
      }
    }
    
    if (target_index == 0 || target_index == 2) {
      START_POINT_LIMIT = new PVector(targets[0].x, targets[0].y);
      END_POINT_LIMIT = new PVector(targets[2].x, targets[2].y);
    }else if (target_index == 1 || target_index == 3) {
      START_POINT_LIMIT = new PVector(targets[1].x, targets[1].y);
      END_POINT_LIMIT = new PVector(targets[3].x, targets[3].y);
    }
    
    line(START_POINT_LIMIT.x, START_POINT_LIMIT.y, END_POINT_LIMIT.x, END_POINT_LIMIT.y);
  }
}
