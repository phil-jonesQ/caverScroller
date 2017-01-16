class Ship {
  float x;
  float y;
  float velocity;
  float gravity;
  float lift;
  PImage shipImg;
  PImage shipImgDamage;

  Ship() {

    shipImg = loadImage("blueshipsSmaller.png");
    shipImgDamage = loadImage("blueshipsDamage.png");
    x = 50;
    y = 40;
    velocity=0.1;
    gravity = 0.3;
    lift = -0.9;
    velocity = 0;
  }

  void show(boolean damage) {
    if (damage) {
      image(shipImgDamage, x, y);
    } else {
      image(shipImg, x, y);
    }
  }

  void up() {
    velocity+=lift+random(0.1);
  }

  void down() {
    velocity-=lift;
  }

  void update() {
    velocity += gravity;
    velocity *= 0.9;
    y += velocity;
    //println(velocity);
    if (y > height) {
      velocity=0;
      y=height-15;
    }
    if (y < 0) {
      y=5;
      velocity-=lift;
    }
  }
}