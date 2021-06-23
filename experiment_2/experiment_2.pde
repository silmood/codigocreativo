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

    float maxRadius = (7 * width/5) / 2.0;
		float minRadius = maxRadius / 10.0;
		int duration = 120;
		int vertex = 3;
    int segments = round(maxRadius * 0.5);
    float segmentAngle = TWO_PI / segments;

		for (int trail = 0; trail < 30; trail++) {
			float trailFrameOffset = trail * 0.25;

			for (int segment = 0; segment < segments; ++segment) {
				// Determinar offset con respecto a la distancia entre el punto y el centro
				float originalAngle = segment * segmentAngle;
				float originX = maxRadius * calcRadius(originalAngle, vertex) * cos(originalAngle);
				float originY = maxRadius * calcRadius(originalAngle, vertex) * sin(originalAngle);
				float distance = sqrt(pow(originX, 2) + pow(originY, 2));
				float toCenterFrameOffset = distance * random(0.0, 4.0); //map(mouseX, 0.0, width, -20.0, 20.0);

				// Determinar offset con función senoidal
				float sinOffset = sin(segment * segments / PI) * map(mouseX, 0.0, width, -50.0, 50.0);

				// Determinar variables de tiempo
				float linearFrameOffset = segment * map(mouseX, 0.0, width, 0.0, 20.0);
				float segmentFrameOffset = linearFrameOffset;

				float frames = (frameCount + trailFrameOffset + segmentFrameOffset) % duration;
				float time = map(frames, 0.0, duration, 0.0, 1.0);
				// Ease 0.0 -> 1.0
				float ease = easeInOutCubic(time);

				float rotation = map(ease, 0.0, 1.0, 0.0, PI * 2.0);
				float radius = map(ease, 0.0, 1.0, minRadius, maxRadius);
				float angle = segmentAngle * segment;    
				float polygonRadius = calcRadius(angle, vertex);

				float x = radius * polygonRadius * cos(angle + rotation);
				float y = radius * polygonRadius * sin(angle + rotation);

				float theta = sin(map(ease, 0.0, 1.0, 0, PI));

				float r = map(ease, 0.0, 1.0, 1.0, 10.0);
				float alpha = 255.0 * theta; // map(theta, 0.0, 1.0, 0.0, 255.0);
				color cyan = color(6, 245, 248, alpha);
				color magenta = color(245, 37, 176, alpha);
				color c = lerpColor(cyan, magenta, ease);

				noStroke();
				fill(c);
				circle(x, y, r);
			}
		}
}















/* void setup() {
	size(540, 540);	
}

void draw() {
	background(0);	
	translate(width/2.0, height/2.0);

	float radius = (4 * width/5) / 2.0;
	int vertexCount = 3;
	float vertexAngle = TWO_PI / vertexCount;
	int segments = 20;

	beginShape();
	for (int vertex = 0; vertex < vertexCount; ++vertex) {
		float angle = vertexAngle * vertex;	
		float x = radius * cos(angle);
		float y = radius * sin(angle);

		float nextAngle = angle + vertexAngle;
		float nextX = radius * cos(nextAngle);
		float nextY = radius * sin(nextAngle);

		float distX = abs(x - nextX);
		float distY = abs(y - nextY);

		int directionX = x > nextX ? -1 : 1;
		int directionY = y > nextY ? -1 : 1;

		float offsetX = distX / segments * directionX;
		float offsetY = distY / segments * directionY;

		for (int segment = 0; segment < segments; ++segment) {
			float segmentX = x + (offsetX * segment);
			float segmentY = y + (offsetY * segment);

			fill(255, 0, 0);
			circle(segmentX, segmentY, 5.0);
		}

		vertex(x, y);
	}

	// Estilo figura
	noStroke();
	noFill();
	endShape(CLOSE);

} */
