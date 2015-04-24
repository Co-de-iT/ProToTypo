
class Bug {

  // fields
  Vec2D loc, speed;
  float diam, life, lifeRate;
  color col, col2;

  // constructor
  Bug( float _diam, float _lifeRate, 
  color _col, color _col2) {

    getPosition();
    speed = new Vec2D(1.5, 0);
    diam = _diam;
    col = _col;
    col2 = _col2;
    life=1;
    lifeRate = _lifeRate;
  }


  // methods

  void getPosition() {
    while (loc == null || !inside (pg, color (0))) 
      loc = new Vec2D(random(width), random(height));
  }

  void update() {
    if (frameCount % 1 == 0) speed.rotate(random(-QUARTER_PI, QUARTER_PI));
    loc.addSelf(speed);
    life -= lifeRate;  //life = life-lifeRate;
    respawn();
  }

  // ______________ check functions

  void respawn() {

    if (life <=0 || bounds() /*|| !inside(pg, color (0))*/) {
      life = 1;
      getPosition();
      //loc = new Vec2D(width*0.5, height*0.5);
    }
  }

  boolean bounds() {
    return (loc.x + diam*life *0.5 < 0 || loc.x - diam*life * 0.5 > width ||
      loc.y + diam*life * 0.5 < 0 || loc.y - diam*life * 0.5 > height);
  }

  boolean inside(PGraphics p, color c) {
    if (loc == null) {
      return false;
    } else {
      return p.get(int(loc.x), int(loc.y)) == c;
    }
  }

  // _______________ display functions

  void display(PGraphics p) {
    // p.noStroke();
    p.fill(lerpColor(col, col2, 1-life));
    p.ellipse(loc.x, loc.y, diam*life, diam*life);
  }
}

