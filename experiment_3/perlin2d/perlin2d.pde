void setup() {
  size(540, 540); 
}

void draw() {
  translate(width/2.0, height/2.0); 
  background(0);

  int count = 100;
  float diam = width/count;
  float r = diam/2.0;

  for (int row = 0; row < count; ++row) {
    for (int col = 0; col < count; ++col) {
      float x = -width/2.0 + (diam * col) + r;
      float y = -height/2.0 + (diam * row) + r;

      float noiseScale = 0.0075;
      float offset = frameCount * noiseScale;
      float c = noise(x * noiseScale + offset, y * noiseScale + offset) * 255.0;

      noStroke();
      fill(c, c);
      circle(x, y, diam);
    }
  }
}
