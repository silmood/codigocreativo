// Inicializar valores
// Establecer configuraciones
int totalFrames;

void setup() {
  size(540, 540);
  smooth();
  pixelDensity(displayDensity());

  totalFrames = 220;
}

void draw() {
  translate(width / 2.0, height / 2.0);
  background(color(0.0, 0.0, 0.0));

  float squareSize = 4 * width / 5.0;
  int lines = 20;
  int rows = 5;
  int cols = 5;

  fill(0.0);
  strokeWeight(2.0);
  stroke(255.0);
  rectMode(CENTER);
  rect(0.0, 0.0, squareSize, squareSize);

  for (int row = 0; row < rows; ++row) {
    float tileHeight = squareSize / rows;
    float tileY = -squareSize/2.0 + (tileHeight * row) + tileHeight/2.0;

    for (int col = 0; col < cols; ++col) {
      float tileWidth = squareSize / cols; 
      float tileX = -squareSize/2.0 + (tileWidth * col) + tileWidth / 2.0;

      //fill(0);
      //stroke(255);
      //rect(tileX, tileY, tileHeight, tileWidth);

      int tileIndex = (row * cols) + col;
      float variation = map(mouseY, 0.0, height, -100.0, 100.0);
      float tileFrameOffset = tileIndex * variation;

      pushMatrix();
      translate(tileX, tileY);
      drawTile(tileWidth, lines, tileFrameOffset);
      popMatrix();
    }

  }


  // Procedimiento de dibujado de un Tile
  //drawTile(squareSize, lines);
}

void drawTile(float tileSize, int lines, float tileFrameOffset) {
  float lineOffset = tileSize / lines;
    for (int line = 0; line <= lines; line++) {
    // Dibujado de lineas
    float startX = -tileSize/2.0;
    float endX = tileSize / 2.0;
    float y = -tileSize/2.0 + (line * lineOffset);

    // Particulas

    // Calculo del tiempo de la animación por particula
    float variation = map(mouseX, 0.0, width, -100.0, 100.0);
    float particleFrameOffset = line * variation;
    float particleFrame = (frameCount + particleFrameOffset + tileFrameOffset) % totalFrames;
    float particleTime = map(particleFrame, 0, totalFrames, 0.0, 1.0);

    // Identificar coordanada de particula
    float theta = map(particleTime, 0.0, 1.0, 0.0, TWO_PI);
    float particleX = map(sin(theta), -1.0, 1.0, startX, endX);//map(time, 0, 1.0, startX, endX);
    float particleY = y;

    // Asignar propiedades de particulas
    float particleColor = pow(cos(theta), 2.0) * 255.0;
    float radius = pow(cos(theta), 2.0) * 10.0;

    fill(particleColor);
    noStroke();
    circle(particleX, particleY, radius);
  }
}
