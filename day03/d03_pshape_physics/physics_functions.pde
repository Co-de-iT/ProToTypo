// initialise physics and adds particles, springs and behaviors
void initPhysics_text() {

  physics = new VerletPhysics2D();
  ptCount=0;
  VerletParticle2D[][] parts = new VerletParticle2D[pts.length][];
  VerletParticle2D[][] parts1 = new VerletParticle2D[pts.length][];
  int i, j;
  
  for (i=0; i< pts.length; i++) {
    parts[i] = new VerletParticle2D[pts[i].length];
    parts1[i] = new VerletParticle2D[pts[i].length];
    ptCount += pts[i].length;
    for (j=0; j< pts[i].length; j++) {
      parts[i][j] = new VerletParticle2D(pts[i][j].x, pts[i][j].y);
      parts1[i][j] = new VerletParticle2D(parts[i][j].x+random(-10, 10), parts[i][j].y+random(-10, 10));

      parts[i][j].lock();
      physics.addParticle(parts[i][j]);
    }
  }

  // adds secondary springs
  for (i=0; i< parts.length; i++) {
    for (j=0; j< parts[i].length; j++) {
      int j1 = (j+1)%parts[i].length;
      // repulsive behavior - attraction behavior with negative force
      //                                 attractor, radius,  strength,  jitter
      physics.addBehavior(new AttractionBehavior(parts1[i][j], partRadius, -1, 0.001)); // repulsive behavior
      physics.addParticle(parts1[i][j]);
      // primary strings
      //                                           pA            pB           length    strength
      //                                            |             |              |           |
      VerletSpring2D s = new VerletSpring2D(parts[i][j], parts1[i][j], primarySpringLength, .001);
      physics.addSpring(s);
      // secondary springs
      s = new VerletSpring2D(parts1[i][j], parts1[i][j1], secondarySpringLength, .1);
      physics.addSpring(s);
    }
  }
  attractor = new AttractionBehavior(new VerletParticle2D(0, 0), 800, 1);
  physics.addBehavior(attractor);
}



// ______________________ border conditions functions

// border conditions function (lock closest to circle)

void borderCond(VerletPhysics2D ph, Vec2D[] pts) {
  VerletParticle2D p;
  Vec2D pos;

  for (int i=ptCount; i< ph.particles.size (); i++) {
    p = ph.particles.get(i);
    pos = new Vec2D (p.x, p.y);
    for (int j=0; j<pts.length; j++) {
      if (pos.distanceTo(pts[j])<5) {
        p.lock();
        break;
      }
    }
  }
}

// ______________________ display functions

void drawParts(PGraphics pg, VerletPhysics2D ph) {
  pg.pushStyle();

  for (int i=ptCount; i< ph.particles.size (); i++) {
    VerletParticle2D pa = ph.particles.get(i);
    pg.fill(0, 20);
    pg.noStroke();
    pg.ellipse(pa.x, pa.y, partRadius, partRadius);
    pg.noFill();
    pg.stroke(255, 0, 255);
    pg.strokeWeight(5);
    pg.point(pa.x, pa.y);
  }
  pg.popStyle();
}

void drawSprings(PGraphics pg, VerletPhysics2D ph) {
  pg.pushStyle();
  pg.stroke(20,90);
  pg.strokeWeight(.5);
  VerletSpring2D s;
  for (int i=0; i< ph.springs.size (); i++) {
    s = ph.springs.get(i);
    pg.line(s.a.x, s.a.y, s.b.x, s.b.y);
  }
  pg.popStyle();
}

// ______________________ alternate and old version for init physics


// initialise physics and adds particles, springs and behaviors
void initPhysics_OLD() {

  physics = new VerletPhysics2D();

  Vec2D pos;
  VerletParticle2D p;
  int i1, j=0;
  while ( j< nParts) {
    pos = new Vec2D (random(-width*.5, width*.5), random(-height*.5, height*.5));
    if (svg.rShape.contains(pos.x, pos.y)) {
      p = new VerletParticle2D(pos.x, pos.y);
      // repulsive behavior - attraction behavior with negative force
      //                               attractor, radius,  strength,  jitter
      physics.addBehavior(new AttractionBehavior(p, 20, -1, 0.001)); // repulsive behavior
      physics.addParticle(p);
      if (j>0) { 
        // from the second particle on, search for the closest one and make a spring
        i1 = getClosest(p, physics.particles);
        //                                          point A                     point B          length  strength
        //                                               |                          |                |   |
        VerletSpring2D s = new VerletSpring2D(physics.particles.get(j), physics.particles.get(i1), 55, .1);
        physics.addSpring(s);
      }
      j++;
    }
  }
  physics.addBehavior(new AttractionBehavior(new VerletParticle2D(0, 0), 800, .01));
}

// get closest particle from an arraylist of particles
int getClosest(VerletParticle2D p, ArrayList<VerletParticle2D> parts) {
  int pInd=-1;
  float dist, minDist = Float.MAX_VALUE;

  for (int i=0; i< parts.size (); i++) {
    dist = p.distanceTo(parts.get(i));
    if (dist > 0 && dist < minDist) {
      minDist = dist;
      pInd = i;
    }
  }

  return pInd;
}


// initialise physics and adds particles, random springs and behaviors
void initPhysics_randomSprings() {

  physics = new VerletPhysics2D();

  Vec2D pos;
  int i1, i2, j=0;
  while ( j< nParts) {
    //VerletParticle p = new VerletParticle(pts[1][j].x, pts[1][j].y, 0);
    pos = new Vec2D (random(-width*.5, width*.5), random(-height*.5, height*.5));
    if (svg.rShape.contains(pos.x, pos.y)) {
      VerletParticle2D p = new VerletParticle2D(pos.x, pos.y);
      physics.addBehavior(new AttractionBehavior(p, 50, -5, 0.001)); // repulsive behavior
      physics.addParticle(p);
      j++;
    }
  }
  println(physics.particles.size());
  j=0;
  while (j<nSprings) {
    i1 = (int) random(nParts);
    i2 = (int) random(nParts);
    //                                          point A                     point B          length  strength
    //                                               |                          |                |   |
    VerletSpring2D s = new VerletSpring2D(physics.particles.get(i1), physics.particles.get(i2), 65, .1);
    physics.addSpring(s);
    j++;
  }
}
