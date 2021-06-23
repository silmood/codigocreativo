void setup() {
  size(540, 540);
}

void draw() {
  background(0);
  translate(width/2.0, height/2.0);

  float maxRadius = (4 * width/5)/2.0;
  int segments = round(maxRadius * 0.5);

  for(int segment = 0; segment < segments; segment++) {
    float variation = map(mouseX, 0.0, width, -30, 30);
    float frameOffset = segment * variation;
    float time = (frameCount + frameOffset) % 180.0;

    float thetaTime = map(time, 0.0, 180.0, 0.0, PI);
    float radius = sin(thetaTime) * maxRadius;
    float angle = segment * TWO_PI/segments;
    float x = radius * cos(angle);
    float y = radius * sin(angle);

    circle(x, y, 10.0);
  }

}