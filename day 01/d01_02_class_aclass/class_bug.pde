
class Bug {

  // field
  Vec2D loc, speed;
  float life, lifeRate;

  // constructor
  Bug(float x, float y) {
    loc = new Vec2D(x, y);
    speed = new Vec2D(3,0);
    life = 1;
    lifeRate = 0.01;
  }

  // methods

  void update() {
    if (frameCount % 1 == 0) speed.rotate(random(-QUARTER_PI, QUARTER_PI));
    loc.addSelf(speed);
    life -= lifeRate;
    respawn();
  }

  void respawn() {
    if (life <= 0) {
      loc = new Vec2D (random(width), random(height));
      life=1;
      randomSeed((long)random(10000));
      fill(random(255), random(255), random(255));
    }
    
    //if (bounds()) loc = new Vec2D (random(width), random(height));
  }

  void display() {
    
    ellipse(loc.x, loc.y, 20*life, 20*life);
  }
}

