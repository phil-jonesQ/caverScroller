class Terrain {

  float xLower;
  float yLower;
  float xUpper;
  float yUpper;
  float xOffset;
  float noiseElement;
  float speed;

  Terrain(float xIn, float time) {
    noiseElement=noise(time);
    //noiseElement=0.5;
    yLower = height;
    xUpper = xIn;
    yUpper = height-150*noiseElement;
    xLower = xIn;
    speed = 10;
  }

  void show() {

    stroke(165, 42, 42);
    line (xLower, yLower, xUpper, yUpper);
  }

  void update() {
    xUpper-=0.1*speed;
    xLower-=0.1*speed;
  }
  
  boolean hits(Ship ship) {
    float shipX = ship.x;
    float shipY = ship.y;
    float d = dist(shipX, yUpper, shipX, shipY+57);
    //println ("Terrain Y = " + yUpper + "Ship x = " + shipX + "Ship y = " + shipY);
    //println ("Distance is " +d);

    //Collision detection is hacky and hard wired but works for this game.

    if (d < 1 || ship.y > yUpper-57 || ship.y < 1) {
      return true;
    }
    return false;
  }
}