/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 sample svg file for a specific color and draw closest lines network
 
 key map:
 
 g  regenerates points
 +,-  increase/decrease distance renage within which drawing lines
 i  save transparent background PNG
 p  save PDF file
 r  save both PNG and PDF in one go
 
 Method
 
 An SVG file is sampled for a specific color and a network of distance-based lines is drawn
 
 */

import toxi.geom.*;
import processing.pdf.*;

PGraphics p, pg, pdf;
PShape logo;
Vec2D point;
int nPoints = 5000;
Vec2D[] pts = new Vec2D[nPoints];

color col = color(0);
float thres = 20;
String fileName = "PDF/logo_RUFA.pdf";
String fileNamePNG = "images/lines_";

boolean drawDots = true;

void setup() {
  size(800, 800);

  p = createGraphics(width, height, JAVA2D);

  pg = createGraphics(width, height);

  // creo il canvas per la registrazione in pdf
  pdf = createGraphics(width, height, PDF, fileName);

  // carico il logo .svg
  logo = loadShape("logo_trim_black.svg");
  logo.scale(2);
  logo.translate(-logo.width*.5, -logo.height*.5);

  // disegno gli oggetti sulla PGraphics p
  p.beginDraw();
  p.shape(logo, p.width*.5, p.height*.5);
  p.endDraw();



  //image(p, 0, 0);
  rectMode(CENTER);

  // generiamo i punti
  generate(pg, col, thres);
}

void draw() {
  background(230);
  image(pg, 0, 0);
}

void generate(PGraphics pg, color col, float thres) {
  for (int i=0; i<nPoints; i++) {
    pts[i] = getPosition(col); // posizione su colore esatto - da usare con il logo svg
  }
  pg.clear();
  display(pg, thres);
}

void display(PGraphics pg, float thres) {
  // pg = createGraphics(width, height);
  pg.beginDraw();
  closestLines(pg, thres);
  if (drawDots) displayPoints(pg);
  pg.endDraw();
}

void displayPoints(PGraphics pg) {
  pg.beginDraw();
  pg.stroke(0);
  pg.strokeWeight(3);
  for (int i=0; i<nPoints; i++) {
    pg.point(pts[i].x, pts[i].y);
  }
  pg.endDraw();
}

void closestLines(PGraphics pg, float thres) {
  pg.stroke(20, 60);
  for (int i=0; i< nPoints; i++) {
    // strokeWeight is mapped on y
    pg.strokeWeight(map(pts[i].y, 0, height, 0.01, 2));
    for (int j=i+1; j<nPoints; j++) {
      if (pts[i].distanceTo(pts[j]) < thres) {
        pg.line(pts[i].x, pts[i].y, pts[j].x, pts[j].y);
      }
    }
  }
}

Vec2D getPosition(color col) {
  Vec2D loc = new Vec2D(random(width), random(height));
  while ( !inside (p, loc, col)) 
    loc = new Vec2D(random(width), random(height));
  return loc;
}

boolean inside(PGraphics p, Vec2D loc, color c) {
  return p.get(int(loc.x), int(loc.y)) == c;
}

void recordPDF() { // un altro modo di registrare in pdf, tramite PGraphics
  // in pratica è come per il .png
  // ri-disegno tutto su una PGraphics dedicata
  pdf.beginDraw();
  display(pdf, thres);
  pdf.dispose(); // chiude il file (IMPORTANTE - non dimenticare)
  pdf.endDraw();
}

void keyPressed() {
  if (key == '+') constrain(++thres, 0, 50);
  if (key == '-') constrain(--thres, 0, 50);
  if (key == 'd') drawDots = !drawDots;
  if (key=='g') {
    generate(pg, col, thres);
  } else {
    pg.clear();
    display(pg, thres);
  }
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
