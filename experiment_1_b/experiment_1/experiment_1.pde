
// Inicializar configuraciones del dibujo
void setup() {
  size(540, 540);
}

//
void draw() {
  background(0.0);
  translate(width/2.0, height/2.0);

  float rectSize = 4 * width/5.0;
  rectMode(CENTER);
  fill(0.0);
  stroke(255.0);
  // rect(0.0, 0.0, rectSize, rectSize);

  // Dibujado de matriz
  int rows = 5;
  int cols = 5;
  float rowSize = rectSize/rows;
  float colSize = rectSize/cols;

  for (int row = 0; row < rows; row++) {
    float y = -rectSize/2.0 + (row * rowSize) + rowSize/2.0; 
    for (int col = 0; col < cols; col++) {
      float x = -rectSize/2.0 + (col * colSize) + colSize/2.0;

      int tile = (row * cols) + col;
      float variation = map(mouseY, 0, height, -100, 100);
      float tileFrameOffset = tile * variation;

      pushMatrix();
      translate(x, y);
      drawTile(rowSize, tileFrameOffset);
      popMatrix();
    }
  }

}

void drawTile(float rectSize, float frameOffset) {
  int lines = 30;
  float totalFrames = 180;
  float lineOffset = rectSize/lines;

  for (int line = 0; line <= lines; ++line) {
    float xStart = -rectSize/2.0;
    float yStart = -rectSize/2.0 + (line * lineOffset);
    float xEnd = rectSize/2.0;
    float yEnd = -rectSize/2.0 + (line * lineOffset);

    // Variable que nos permita evaluar una diferencia entre particula y particula
    float variation = map(mouseX, 0.0, width, -100.0, 100.0);
    float particleFrameOffset = line * variation;
    float particleFrame = (frameCount + frameOffset + particleFrameOffset) % totalFrames;
    float particleTime = map(particleFrame, 0.0, 180.0, 0.0, 1.0);

    float theta = map(particleTime, 0.0, 1.0, 0.0, TWO_PI);
    float particleX = map(sin(theta), -1.0, 1.0, xStart, xEnd);
    float radius = pow(cos(theta), 2.0) * 5.0;
    float c = pow(cos(theta), 2.0) * 255.0;

    fill(c);
    circle(particleX, yStart, radius);
  }
}
