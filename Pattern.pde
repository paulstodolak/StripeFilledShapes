class Pattern {
  PVector START_POINT;
  PVector END_POINT;
  float SLOPE;
  float Y_INTERCEPT;
  
  Pattern(float _x1, float _y1, float _x2, float _y2) {
    START_POINT = new PVector(_x1, _y1);
    END_POINT   = new PVector(_x2, _y2);
    
    setSlope(START_POINT, END_POINT);
    setYIntercept(START_POINT, SLOPE);
  }
  
  Pattern(PVector _start_point, PVector _end_point) {
    START_POINT = _start_point;
    END_POINT   = _end_point;
    
    setSlope(START_POINT, END_POINT);
    setYIntercept(START_POINT, SLOPE);
  }
  
  PVector getStartPoint() {
    return START_POINT;
  }
  
  PVector getEndPoint() {
    return END_POINT;
  }
  
  void setSlope(PVector start_point, PVector end_point) {
    SLOPE = (end_point.y - start_point.y) / (end_point.x - start_point.x);
  }
  
  float getSlope() {
    return SLOPE;
  }
  
  void setYIntercept(PVector point, float slope) {
    Y_INTERCEPT = point.y - (point.x * slope);
  }
  
  float getYIntercept() {
    return Y_INTERCEPT;
  }
}

float getX(float m1, float b1, float m2, float b2) {
  return (b1 - b2) / (m2 - m1);
}

float getY(float x1, float m, float b) {
  return (m * x1) + b;
}
