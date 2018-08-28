class Edge extends Pattern {
 
  Edge(float _x1, float _y1, float _x2, float _y2) {
    super(_x1, _y1, _x2, _y2);
  }
  
  Edge(PVector _start_point, PVector _end_point) {
    super(_start_point, _end_point);
  }
  
  void display() {
    strokeWeight(4);
    stroke(155, 155, 255);
    
    line(START_POINT.x, START_POINT.y, END_POINT.x, END_POINT.y);
  }
}
