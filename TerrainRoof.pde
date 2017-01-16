class TerrainRoof {

  float xLower;
  float yLower;
  float xUpper;
  float yUpper;
  float xOffset;
  float noiseElement;
  float speed;

  TerrainRoof(float xIn, float time) {
    noiseElement=noise(time);
    yLower = 0;
    xUpper = xIn;
    yUpper = 0+150*noiseElement;
    xLower = xIn;
    speed = 10;
  }

  void show() {
    stroke(145,42,42);
    line (xLower, yLower, xUpper, yUpper);
  }
  
  void update() {
    xUpper-=0.1*speed;
    xLower-=0.1*speed;
  }
}