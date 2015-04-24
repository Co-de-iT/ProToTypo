class PRad {

  Vec2D loc, speed;
  float rad, maxSpeed;
  int maxConn;
  boolean locked;

  PRad(Vec2D loc, Vec2D speed, float rad, float maxSpeed, int maxConn) {
    this.loc = loc;
    this.speed = speed;
    this.rad = rad;
    this.maxSpeed = maxSpeed;
    this.maxConn = maxConn;
    locked= false;
  }

  PRad(Vec2D loc, float rad, float maxSpeed) {
    //this(loc, new Vec2D( width*.5, height*.5).sub(loc).normalizeTo(maxSpeed)/*.rotate(PI*.4)*/, rad, 1, 2);
    this(loc, new Vec2D( random(-1,1), random(-1,1)).normalizeTo(maxSpeed)/*.rotate(PI*.4)*/, rad, 1, 3);
  }

  void display(PGraphics pg) {
    pg.pushStyle();
    pg.noStroke();
    if (locked) pg.fill(0, alpha);
    pg.ellipse(loc.x, loc.y, rad*2, rad*2);
    pg.popStyle();
  }

  void update() {
    if (!locked) {
      move();
      // update radius
      rad = map (loc.y, 100, height-100, minRad, maxRad);
    }
  }

  void move() {
    //speed.rotate(-PI*0.002);
    loc.addSelf(speed);
  }

  void lock() {
    locked = true;
  }

  void unlock() {
    locked = false;
  }
}
