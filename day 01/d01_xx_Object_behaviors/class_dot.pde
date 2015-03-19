// this is how you define a class

class Dot { // this is how you name a class - by convention the name's first letter is capital

  // fields
  Vec3D loc;
  color col, initCol;
  float initRad, rad, dec, decRad, speed, acc, ang, cen;
  int lifeSpan, count;
  boolean alive;

  // constructors - handling multiple constructors
  Dot(Vec3D loc, float rad, color col, int lifeSpan, float speed, float acc) {
    // 
    this.col = col; // assign a predefined value
    initCol = this.col;
    this.loc = loc;             // assign a value from outside
    this.rad = rad;
    initRad=rad;
    this.lifeSpan = lifeSpan;
    this.speed = speed;
    this.acc = acc;
    alive = true;
    count = 0;
    ang=0;
    dec = (this.rad)/(float) lifeSpan;
    decRad = 1/(float) lifeSpan;
  }

  Dot(Vec3D loc) {
    this(loc, 50, color(255, 0, 0, 20), 800, 0.1, -0.0005); // call the main constructor
  }

  Dot(Vec3D loc, float rad, color col, float speed, float acc) {
    this(loc, rad, col, 800, speed, acc); // calls the main constructor
  }

  // update methods
  void update() {
    if (alive && count < lifeSpan) {
      count++;
      rad -= dec;
      cen = initRad*0.6*sqrt(decRad*(lifeSpan-count));
      speed += acc;
      ang+=speed;
      col = lerpColor(initCol, color(0), count/(float) lifeSpan);
    } else {
      alive = false;
    }
  }

  // display methods

  void display() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(ang);
    translate(cen, 0);
    ellipse(0, 0, rad*2, rad*2);
    popMatrix();
    stroke(255);
    strokeWeight(2);
    //displayDot();
    noStroke();
  }

  void displayDot() {
    point(loc.x, loc.y);
  }
}

