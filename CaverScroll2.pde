//Sidescrolling 
// Generate a random 2D landscape with perlin noise



//Objects

ArrayList<Terrain> terrain = new ArrayList<Terrain>();
ArrayList<TerrainRoof> terrainroof = new ArrayList<TerrainRoof>();
Ship ship;


//Track Xposition of landscape element
float posXLowerTerrain;
float posXupperTerrain;

//perlin noise seed timers
float t;
float t1;
float noiseOffsetLower;
float noiseOffsetHigher;
float amount;
boolean hit;


void setup() {
  size(800, 300);
  amount=width;
  t=0;
  t1=0;
  posXLowerTerrain =0;
  posXupperTerrain =0;
  populateLandscape(amount);
  ship = new Ship();
  hit=false;
}

//Reset
void mouseClicked() {
  noLoop();
  init();
  loop();
}


//Control ship against gravity
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      ship.up();
    }
  }
}

void draw() {
  background(27);
  drawLandscape();
  scrollLandscape();
  appendLandscape();
  checkCollision();
  if (hit) {
    ship.show(true);
  } else {
    ship.show(false);
  }
  ship.update();
  
}

void populateLandscape(float max) {
  //Floor
  for (int i = 0; i < max; i++) {
    terrain.add(new Terrain(posXLowerTerrain, t));
    posXLowerTerrain++;
    //Increment t for perlin noise
    t += 0.01;
  }
  //Roof
  for (int i = 0; i < max; i++) {
    terrainroof.add(new TerrainRoof(posXupperTerrain, t1));
    posXupperTerrain++;
    //Increment t for perlin noise
    t1 += 0.05;
  }
}

void drawLandscape() {
  for (int i = 0; i < terrain.size(); i++) {
    terrain.get(i).show();
    terrainroof.get(i).show();
  }
}

void scrollLandscape() {
  for (int i = 0; i < terrain.size(); i++) {
    terrain.get(i).update();
    terrainroof.get(i).update();
  }
}

//Method appends to the array list and imediately removes the landscape off screen
void appendLandscape() {
  t += 0.01;
  terrain.add(new Terrain(posXLowerTerrain-1, t));  
  t1 += 0.05;
  terrainroof.add(new TerrainRoof(posXupperTerrain-1, t1));
  //Destroy 1st index as now shifted off screen
  terrain.remove(0);
  terrainroof.remove(0);
}


//Collision detection called from here but handled in Terrain Class
void checkCollision() {

  //Check a range of elements as ourship does not move on xPlane
  int startElement=terrain.size() - width+40;
  int endElement=terrain.size() - width+80;
  //println(startElement + "    " + endElement);
  for (int i = endElement; i >= startElement; i--) {
    //println(i);
    if (terrain.get(i).hits(ship)) {
      hit=true;
      ship.up();
    } else {
      hit=false;
    }
  }
}

//Reset method
void init() {
  //Clearlist of terrain objects
  for (int i = terrain.size()-1; i >= 0; i--)
  { 
    terrain.remove(i);
    terrainroof.remove(i);
  }
  //println(terrain.size());
  amount=width;
  t=0;
  t1=0;
  posXLowerTerrain =0;
  posXupperTerrain =0;
  ship = new Ship();
  populateLandscape(amount);
  hit=false;
  //println(terrain.size());
}