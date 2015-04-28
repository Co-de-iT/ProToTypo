class Spot {

  int tail, life, currLife;
  float maxDiam, minAlpha;
  boolean alive;
  Vec2D[] pts;
  float[] diams;
  int[] inds;
  ArrayList <Vec2D> pts2 = new ArrayList<Vec2D>();
  int speed, currPt, type;

  Spot(int tail, int life, float maxDiam, float minAlpha, int speed, Vec2D[] pts, int type) {
    this.speed = speed;
    this.pts = pts;
    this.tail = constrain(tail, 0, pts.length);
    this.life = life;
    this.currLife = life;
    this.maxDiam = maxDiam;
    this.minAlpha = minAlpha;
    this.type = type;
    currPt = 0;
    alive = true;

    // initialize diameters & indices
    diams = new float[tail];
    inds = new int[tail];
    for (int i=0; i< tail; i++) {
      diams[i] = map (i, 0, tail, 0, maxDiam);
      inds[i] = speed*i;
    }
  }


  void update() {
    // if I am in 0 and there is life
    if (currPt == 0 && currLife > 0) {
      pts2.clear();
      pts2.add(pts[0]);
      currPt++;
    } else if (currPt>0 && currPt < pts.length && pts2.size() < tail) {
      if (currPt%speed==0) pts2.add(pts[currPt]);
      currPt++;
    } else if (pts2.size()==tail && currPt < pts.length) {
      if (currPt%speed==0) {
        pts2.add(pts[currPt]);
        pts2.remove(0);
      }
      currPt++;
    } else if (pts2.size()>0) {
      currPt++; 
      if (currPt%speed==0) pts2.remove(0);
    } else if (pts2.size()==0 && currLife>0) {
      currLife-= 1;
      currPt = 0;
    }
    if (currLife <= 0) alive = false;
  }

  void display(PGraphics pg) {
    pg.pushStyle();
    if (type ==0) {
      pg.noStroke();
    } else {
      pg.noFill();
      pg.stroke(0);
      pg.strokeWeight(1);
    }

    float diam, alpha;

    Vec2D pt;
    for (int i=pts2.size () - 1; i>=0; i--) {
      pt = pts2.get(i);
      // diam = map(i, 0, tail, 0, maxDiam);
      if (currPt < pts.length) {
        diam = map(pts2.size()-1-i, 0, tail, maxDiam, 0);
        alpha = map(pts2.size()-1-i, 0, tail, 255, minAlpha);
      } else {
        diam = map(i, 0, tail, 0, maxDiam);
        alpha = map(i, 0, tail, minAlpha, 255);
      }
      if (type ==0) pg.fill(0, alpha); 
      else pg.stroke(0, alpha);
      //diam = map(i, 0, pts2.size(), 0, maxDiam);
      pg.ellipse(pt.x, pt.y, diam, diam);
      //count++;
    }
    pg.popStyle();
  }

  // __________________________________________ alternate version
  //
  // CHUNKY - diameters should be calculated smoothly and not pre-stored in array
  //  
  void update_CHUNKY() {
    currPt++;
    if (currPt > pts.length+tail*speed) {
      currLife -=1;
      currPt = 0;
    }
    if (currLife <= 0) alive = false;
  }

  void display_CHUNKY(PGraphics pg) {
    pg.pushStyle();
    pg.noStroke();
    float diam, alpha;
    int ind;
    for (int i=0; i<inds.length; i++) {
      ind = currPt-inds[i];
      if (ind > 0 && ind <pts.length) {
        diam = map(i, 0, inds.length, maxDiam, 0);
        alpha = map(i, 0, inds.length, 255, minAlpha);
        pg.fill(0, alpha);
        pg.ellipse(pts[ind].x, pts[ind].y, diam, diam);
      }
    }
    pg.popStyle();
  }

  void respawn() {
    alive = true;
    currLife = life;
    currPt = 0;
  }
}
