float calcRadius(float theta, float n) {
  return cos(PI / n) / cos( theta - (TWO_PI / n) * floor( (n * theta + PI) / TWO_PI) );
}

float easeInOutCubic(float x) {
  return x < 0.5 ? 4 * x * x * x : 1 - pow(-2 * x + 2, 3) / 2;
}

void setup() {
  size(540, 540);
}

void draw() {
  background(0);
  translate(width/2.0, height/2.0);

  float maxRadius = (4 * width/5)/2.0;
  float minRadius = maxRadius / 20.0;
  int vertexCount = 6;
  int duration = 120;
  float vertexAngle = TWO_PI / vertexCount;

  // Dibujado de segmentos
  int segments = round(maxRadius * 0.5);
  float segmentAngle = TWO_PI / segments;

  for (int trail = 0; trail < 10; trail ++) {
    float trailFrameOffset = trail * 10.5;

    for(int segment = 0; segment < segments; segment++) {
      float originAngle = segment * segmentAngle;
      float originPolygonRadius = calcRadius(originAngle, vertexCount);
      float originX = maxRadius * originPolygonRadius * cos(originAngle);
      float originY = maxRadius * originPolygonRadius * sin(originAngle);
      float distance = dist(originX, originY, 0.0, 0.0);

      // Variables de tiempo 
      float linearFrameOffset = segment * 3.5;
      float toCenterFrameOffset = distance * 7.2;
      float sinFrameOffset = sin(segment * segments/PI) * 12.0;
      float randomFrameOffset = random(0.0, 5.0);

      float segmentFrameOffset = sinFrameOffset; // segment * 3.5;
      float frames = (frameCount + trailFrameOffset + segmentFrameOffset) % duration;
      float time = map(frames, 0.0, 120.0, 0.0, 1.0);
      float ease = easeInOutCubic(time);

      float rotation = map(ease, 0.0, 1.0, 0.0, PI);
      float radius = map(ease, 0.0, 1.0, maxRadius, minRadius);
      float angle = segment * segmentAngle;
      float polygonRadius = calcRadius(angle, vertexCount);

      float x = radius * polygonRadius * cos(angle + rotation);
      float y = radius * polygonRadius * sin(angle + rotation);

      float alpha = sin(map(ease, 0.0, 1.0, 0.0, PI)) * 255;
      color c = lerpColor(color(245, 37, 176, alpha), color(78, 239, 244), ease);

      float r = map(ease, 0.0, 1.0, 10.0, 1.0);

      noStroke();
      fill(c);
      circle(x, y, r);
    }
  }

  // Versión 1 sobre dibujado de contornos en poligono
  // Comenzamos a dibujar una figura
  /*
  beginShape();

  for(int vertex = 0; vertex < vertexCount; vertex++) {
    // Vertice A
    float angle = vertex * vertexAngle;
    float x = maxRadius * cos(angle);
    float y = maxRadius * sin(angle);

    // Vertice B
    float nextAngle = angle + vertexAngle;
    float nextX = maxRadius * cos(nextAngle);
    float nextY = maxRadius * sin(nextAngle);

    // Calcular distancias
    float distX = abs(x - nextX);
    float distY = abs(y - nextY);

    // Determinar dirección
    int directionX = x > nextX ? -1 : 1;
    int directionY = y > nextY ? -1 : 1;

    // Dimensión entre punto y punto
    float offsetX = distX/segments * directionX;
    float offsetY = distY/segments * directionY;

    for (int segment = 0; segment < segments; segment++) {
      float segmentX = x + (segment * offsetX);
      float segmentY = y + (segment * offsetY);

      noStroke();
      fill(255, 0, 0);
      circle(segmentX, segmentY, 10.0);
    }

    // Declarar vertice
    vertex(x, y);
  }

  // Definir el estilo de dibujado de la figura
  stroke(255);
  noFill();
  endShape(CLOSE);

  */

}