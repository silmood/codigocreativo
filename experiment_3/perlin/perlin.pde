void setup() {
  size(540, 540); 
}

void draw() {
  translate(0, height/2.0);
  background(0); 

  stroke(255);
  line(0.0, 0.0, width, 0.0);

  for (int particle = 0; particle < 100; ++particle) {
    float x = map(particle, 0, 100, 0.0, width);

    // Gráfica de función senoidal
    // float angleOffset = frameCount * PI/50;
    // float angle = angleOffset + map(x, 0.0, width, 0.0, TWO_PI);
    // float y = height/4 * sin(angle);

    // Gráfica de función noise
    float amplitude = height/2;
    float noiseScale = 0.01;
    float xOffset = frameCount * noiseScale;
    float y = amplitude * map(noise(x * noiseScale + xOffset), 0.0, 1.0, -1, 1);

    noStroke();
    fill(255);
    circle(x, y, 5.0);
  }
}
