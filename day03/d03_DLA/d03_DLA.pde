/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 DLA (Diffusion Limited Aggregation) process on logo
 
 NOTE: the DLA agorithm is rough, sketchy and for sure can be implemented much better,
 but for the time being it works the way I want
 
 key map:
 
 space bar  starts/stops the process
 d  toggle point visualization
 +/-  increase/decrease alpha of points
 l  toggle lines visualization
 m  toggle particle visualization
 i  save transparent background PNG
 p  save PDF file
 r  save both PNG and PDF in one go
 
 */

import toxi.geom.*;
import processing.pdf.*;

PShape logo;
PGraphics p, pg, pdf;
ArrayList<Stick> dlaLines;
ArrayList<PRad> dlaPts;
ArrayList<PRad> movingPts;
PRad part;
Vec2D loc, speed;

float thres = 40;
float minRad = 1;
float maxRad = 5;
float alpha = 50;
float rad;
float maxSpeed = 2;
boolean newPart = false;
int nParts = 1000;
String fileName = "PDF/DLA.pdf";
String fileNamePNG = "images/DLA_";


// keystroke flags

boolean dispPts = false;
boolean dispLines = true;
boolean dispPart = false;
boolean go = false;

void setup() {

  size(800, 800);
  smooth();
  p = createGraphics(width, height, JAVA2D);
  
  pg = createGraphics(width, height);
  
  // creo il canvas per la registrazione in pdf
  pdf = createGraphics(width, height, PDF, fileName);
  
  logo = loadShape("logo_trim_black.svg");
  logo.scale(1.5);
  logo.translate(-logo.width*0.5, -logo.height*0.5);

  // draws logo on separate PGraphics
  p.beginDraw();
  p.shape(logo, width*0.5, height*0.5);
  //  p.filter(BLUR,16);
  p.endDraw();

  // initialize particles
  initParticles();
}



void draw() {
  background(230);
  // image(p, 0, 0);
  // ellipse(width/2, height/2, 470,300);
  noStroke();

  // update phase
  if (go) {
    updateParticles();
  }
  
  // display phase
  pg.beginDraw();
  pg.clear();
  pg.endDraw();
  dlaDisplay(pg);
  image(pg,0,0);
}


// _______________________________________ particles functions _______________________________________


void initParticles(){
    movingPts = new ArrayList<PRad>();
  dlaPts = new ArrayList<PRad>();
  dlaLines = new ArrayList<Stick>();
  
  Vec2D initLoc = getPosIn();
  float initRad = map (initLoc.y, 100, height-100, minRad, maxRad);
  // calculate second point
  Vec2D firstLoc = initLoc.add(new Vec2D(initRad*2, 0).rotate(random(-HALF_PI, HALF_PI)));
  float firstRad = map (firstLoc.y, 100, height-100, minRad, maxRad);
  PRad a = new PRad(initLoc, initRad, maxSpeed);
  a.lock();
  dlaPts.add(a);
  a = new PRad(firstLoc, firstRad, maxSpeed);
  a.lock();
  dlaPts.add(a);
  dlaLines.add(new Stick(initLoc, firstLoc)); // initial anchor
  for (int i=0; i< nParts; i++) {
    loc = getPosOut();
    rad = map (loc.y, 100, height-100, minRad, maxRad);
    part = new PRad(loc, rad, maxSpeed);
    movingPts.add(part);
  }
}

void updateParticles(){
    for (int i = nParts-1; i>=0; i-- ) {
      part = movingPts.get(i);
      part.update();
      if (bounds(part.loc)) {  // respawn if part goes off screen
        newPart = true;
      } else {
        dla(part, 0);
      }
      if (newPart) { // if a new particle should be added
        movingPts.remove(i); // remove the current one
        //loc = getPosOut();
        loc = new Vec2D(random(width), random(height));
        rad = map (loc.y, 100, height-100, minRad, maxRad);
        part = new PRad(loc, rad, maxSpeed);
        movingPts.add(part);
        newPart = false;
      }
      pushStyle();
      fill(255, 0, i+5, 50);
      if (dispPart) part.display(g);
      popStyle();
    }
}

boolean bounds(Vec2D p) { // checks if a position is within the canvas or not
  boolean b = (p.x<0 || p.x > width || p.y<0 || p.y>height);
  return b;
}

Vec2D getPosIn() { // returns a point inside the logo space
  Vec2D loc = new Vec2D(random(width), random(height));
  while ( !inside (p, loc, color (0))) 
    loc = new Vec2D(random(width), random(height));
  return loc;
}

Vec2D getPosOut() { // returns a point outside the logo space
  Vec2D loc = new Vec2D(random(width), random(height));
  while ( inside (p, loc, color (0)) /*|| loc.distanceTo(new Vec2D(width/2, height/2))<235*/) 
    loc = new Vec2D(random(width), random(height));
  return loc;
}


boolean inside(PGraphics p, Vec2D loc, color c) {
  return p.get(int(loc.x), int(loc.y)) == c;
}

// _______________________________________ DLA functions _______________________________________

boolean dla(PRad part, float thres) {
  boolean dlaDone = false;
  boolean intersect = false;
  PRad closestPt = null;

  for (PRad pt : dlaPts) {
    // check if within distance from pt
    if (part.loc.distanceTo(pt.loc)<(pt.rad+part.rad+thres)) {
      // if so, a new particle will be needed
      newPart = true;
      // if it is the first pt encountered activate intersect flag
      if (!intersect) {
        intersect = true;
      } // otherwise exit loop (means we are intersecting with more than one, hence overlap may occur) 
      else {
        dlaDone = false;
        break;
      }
      // assign closest point
      closestPt=pt;
      dlaDone = true;
    }
  }
  // if a closest point is assigned, its number of available connections is > 0 and we are inside the logo attach particle
  if (dlaDone && closestPt != null && closestPt.maxConn > 0 && inside(p, part.loc, color(0))) {
    //part.maxConn -=1;
    closestPt.maxConn -=1;
    // places particle at exact sum radius distance in the same direction
    Vec2D dir = part.loc.sub(closestPt.loc);
    dir.normalizeTo(part.rad+closestPt.rad);
    part.loc = closestPt.loc.add(dir);
    part.lock();
    dlaPts.add(part);
    dlaLines.add(new Stick(part.loc, closestPt.loc));
  }
  return dlaDone;
}


void dlaDisplay(PGraphics pg) {
  pg.beginDraw();
  if (dispLines) {
    for (Stick s : dlaLines) s.display(pg);
  }
  if (dispPts) {
    for (PRad p : dlaPts) p.display(pg);
  }
  pg.endDraw();
}

/*
void addStick(Vec2D p, Vec2D near) {
  Stick s = new Stick(p, near);
}
*/

void recordPDF() { // un altro modo di registrare in pdf, tramite PGraphics
  // in pratica è come per il .png
  // ri-disegno tutto su una PGraphics dedicata
  pdf.beginDraw();
  dlaDisplay(pdf);
  pdf.dispose(); // chiude il file (IMPORTANTE - non dimenticare)
  pdf.endDraw();
}

void keyPressed() {

  if (key == 'd') dispPts = !dispPts;
  if (key == 'l') dispLines = !dispLines;
  if (key == 'm') dispPart = !dispPart;
  if (key == '+') {
  alpha +=5;
  constrain(alpha,0,255);
  }
    if (key == '-') {
  alpha -=5;
  constrain(alpha,0,255);
  }
  if (key == ' ') go = !go;
  
   if (key == 'i') {
    pg.save(fileNamePNG+ nf(frameCount, 4) +".png");
    println("PNG image saved as: "+ fileNamePNG + nf(frameCount, 4) +".png");
  }
  if (key == 'p') { 
    recordPDF();
    println("PDF file saved as: "+ fileName);
  }

  if (key == 'r') {
    pg.save(fileNamePNG+ nf(frameCount, 4) +".png");
    println("PNG image saved as: "+ fileNamePNG + nf(frameCount, 4) +".png");
    recordPDF();
    println("PDF file saved as: "+ fileName);
  }
}