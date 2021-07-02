float noiseScale = 0.0015;
int duration = 120;

float easeInOutCubic(float x) {
	return x < 0.5 ? 4 * x * x * x : 1 - pow(-2 * x + 2, 3) / 2;
}

void setup() {
  size(540, 540);
}

void draw() {
  blendMode(ADD);
  background(142, 163, 255);
  randomSeed(150);

  for (int flow = 0; flow < 500; ++flow) {
    float flowFrameOffset = flow * 1.0;
    
    float startX = random(width);
    float startY = random(height);
    int dimension = 100;

    for (int col = 0; col < 3; ++col) {
      float colorFrameOffset = col * 4.5;
      
      float previousX = startX;
      float previousY = startY;

      for (int particle = 0; particle < dimension; ++particle) {
        float frames = (frameCount + flowFrameOffset + colorFrameOffset) % 120;
        float time = map(frames, 0.0, 120.0, 0.0, 1.0);
        float ease = easeInOutCubic(time);

        float angle = TWO_PI * noise(previousX * noiseScale, previousY * noiseScale);
        float x = previousX + cos(angle);
        float y = previousY + sin(angle);

        previousX = x;
        previousY = y;

        int particleIndex = (int) map(ease, 0.0, 1.0, 0.0, dimension);
        int lowIndex = particleIndex - 20;
        int upIndex = particleIndex + 20;

        boolean drawParticle = particle >= lowIndex && particle <= upIndex;

        float maxAlpha = sin(map(ease, 0.0, 1.0, 0.0, PI)) * 70.0;

        if (drawParticle) {
          float alpha = map(particle, lowIndex, upIndex, 0.0, maxAlpha);

          int red = col == 0 ? 255 : 0;
          int green = col == 1 ? 255 : 0;
          int blue = col == 2 ? 255 : 0;

          noStroke();
          fill(red, green, blue, alpha);
          circle(x, y, 20.0);
        }
      }
    }
  }
}
