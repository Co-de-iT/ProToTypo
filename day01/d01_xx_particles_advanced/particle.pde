class Particle {

  // fields

  Vec3D loc;
  Vec3D speed = new Vec3D (random(-1f, 1f), random(-1f, 1f), 0);
  float maxSpeed = 1.5;
  float diam = 8;

  // constructor(s)

  Particle(Vec3D _loc) {
    loc = _loc;
  } // end Particle


  /////////////
  // _________________________________ methods
  /////////////

  void update() {
    //move();
    moveB();
    //bounce();
    wrap();
    if (mousePressed && mouseButton == RIGHT) seekMouse(-0.05);
    display();
  } // end update


  // __________________ movement methods

  void move() {
    speed.limit(maxSpeed);
    loc.addSelf(speed);
  } // end move

  void moveB() {

    int i = index(loc);
    float ang;
    if (i>0 && i< pixBri.length) {
      // try these settings (one at the time)
       ang = map(pixBri[i], 0, 255, -(PI/2+frameCount/50.0), PI/2+frameCount/20.0); // cool one!
      // ang = map(pixBri[i], 0, 255, -(PI/2+frameCount/10.0), 0);
      // ang = map(pixBri[i], 0, 255, -PI/2, PI/2);
      //ang = map(pixBri[i], 0, 255, -PI/8, PI/2);
    } 
    else {
      ang = 0;
    } 

    Vec3D vBri = new Vec3D(cos(ang)*maxSpeed*0.5, sin(ang)*maxSpeed*0.5, 0);
    //speed.rotateZ(ang);
    speed.addSelf(vBri);

    speed.limit(maxSpeed);
    loc.addSelf(speed);
  } // end moveB

  void seekMouse(float strength) {
    // store mouse position
    Vec3D mousePos = new Vec3D(mouseX, mouseY, 0);
    // calc steer vector
    Vec3D steer = mousePos.sub(loc);
    if (steer.magnitude()<100) {
      steer.normalizeTo(strength);
      // add steer to speed
      speed.addSelf(steer);
    }
  } // end seekmouse

  void bounce() {
    if (loc.x <= diam/2 || loc.x >= width-diam/2) speed.x *= -1;
    if (loc.y <= diam/2 || loc.y >= height-diam/2) speed.y *= -1;
  } // end bounce

  void wrap() {

    if (loc.x <0) loc.x = width;
    if (loc.x > width) loc.x = 0;
    if (loc.y<0) loc.y = height;
    if (loc.y> height) loc.y = 0;
  } // end wrap

  // __________________ display methods

  void display() {
    pushStyle();
    noStroke();
    int i = index(loc);
    float amp, bri;
    if (i>0 && i< pixBri.length) {
      bri = map(pixBri[i], 0, 255, 50, 255);
      fill(bri, 30);
      stroke(bri, 30);
      amp = map(pixBri[i], 0, 255, 0.1, 0.3); // particle thickness
    } 
    else {
      fill(0, 50);
      stroke(0);
      amp = 0.1;
    }

    //ellipse(loc.x, loc.y, diam*amp, diam*amp);
    strokeWeight(diam*amp); // instead of an ellipse, we use a point (faster display)
    point(loc.x, loc.y);
    popStyle();
  } // end display


  // __________________ utilities

  int index(Vec3D loc) {
    return int(loc.y)*width+int(loc.x);
  }
} // end class
