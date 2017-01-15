/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 sample an image in grayscale range and draw closest lines network
 
 key map:
 
 g  regenerates points
 +,-  increase/decrease distance range within which drawing lines
 i  save transparent background PNG
 p  save PDF file
 r  save both PNG and PDF in one go
 
 Method
 
 An image is sampled in a grayscale value range and a network of distance-based lines is drawn
 
 */

import toxi.geom.*;
import processing.pdf.*;

PGraphics p, pg, pdf;
PImage img;
Vec2D point;
int nPoints = 5000;
Vec2D[] pts = new Vec2D[nPoints];

float minBri = 90, maxBri = 190, thres = 20;
boolean drawDots = true;
String fileName = "PDF/grayscale_mapped.pdf";
String fileNamePNG = "images/lines_";

void setup() {
  size(800, 800);

  p = createGraphics(width, height, JAVA2D);
  
  pg = createGraphics(width, height);
  
  // creo il canvas per la registrazione in pdf
  pdf = createGraphics(width, height, PDF, fileName);

  // carico l'immagine grayscale
  img = loadImage("Plane turbulence.jpg");
  img.resize(p.width, p.height);

  // disegno gli oggetti sulla PGraphics p
  p.beginDraw();
  p.image(img, 0, 0);
  p.endDraw();

  //image(p, 0, 0);
  rectMode(CENTER);

  // generiamo i punti

  generate(pg, minBri, maxBri, thres);
}

void draw() {
  background(230);
  image(pg, 0, 0);
}

void generate(PGraphics pg, float minBri, float maxBri, float thres) {
  for (int i=0; i<nPoints; i++) {
    pts[i] = getRange(minBri, maxBri); // posizione su range di luminosità - da usare con l'immagine grayScale
  }
  pg.beginDraw();
  pg.clear();
  pg.endDraw();
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


Vec2D getRange(float minBri, float maxBri) {
  Vec2D loc = new Vec2D(random(width), random(height));
  while ( !insideImg (p, loc, minBri, maxBri)) 
    loc = new Vec2D(random(width), random(height));
  return loc;
}

boolean insideImg(PGraphics p, Vec2D loc, float minBri, float maxBri) {
  float bri = brightness(p.get(int(loc.x), int(loc.y)));
  return (bri > minBri && bri < maxBri);
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
    generate(pg, minBri, maxBri, thres);
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