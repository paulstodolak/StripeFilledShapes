class StripeFilledShape {
  PVector ORIGIN;
  float SHAPE_WIDTH;
  float SHAPE_HEIGHT;
  float SHAPE_THETA;
  float PATTERN_WIDTH;
  float PATTERN_BUFFER;
  
  float rotation_theta;
  
  StripeFilledShape(float _x, float _y, float _width, float _height, float _pattern_width, float _pattern_buffer) {
    ORIGIN         = new PVector(_x, _y);
    SHAPE_WIDTH    = _width;
    SHAPE_HEIGHT   = _height;
    SHAPE_THETA    = atan2(SHAPE_HEIGHT / 2, SHAPE_WIDTH / 2);
    PATTERN_WIDTH  = _pattern_width;
    PATTERN_BUFFER = _pattern_buffer;
  }
  
  StripeFilledShape(PVector _origin, float _width, float _height, float _pattern_width, float _pattern_buffer) {
    ORIGIN         = _origin;
    SHAPE_WIDTH    = _width;
    SHAPE_HEIGHT   = _height;
    SHAPE_THETA    = atan2(SHAPE_HEIGHT / 2, SHAPE_WIDTH / 2);
    PATTERN_WIDTH  = _pattern_width;
    PATTERN_BUFFER = _pattern_buffer;
  }
  
  void display() {

  }
  
  void incrementRotation() {
    rotation_theta += 0.01;
    if (rotation_theta > 360) {
      rotation_theta = 0; 
    }
  }
}
