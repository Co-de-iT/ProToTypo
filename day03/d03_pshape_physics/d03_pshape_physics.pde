
/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 SVG importer + Verlet physics 2D example
 
 d  toggles point density sampling (adaptive - uniform step - uniform length)
 v  toggles video frames recording
 s  toggles spring display
 i  save transparent background PNG
 p  save PDF file
 r  save both PNG and PDF in one go
 
 click on tab class_SVGimporter for detailed explanations
 
 */

import processing.pdf.*;
import toxi.geom.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.*;
import toxi.physics2d.constraints.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;
import toxi.processing.*;

// custom created class (see class_SVGimporter tab)
SVGImporter svg;

// external libraries classes
RPoint[][] points; // from geomerative (imported in the class_SVGimporter tab)
Vec2D[][] pts; // from toxi

VerletPhysics2D physics; // toxi physics library
AttractionBehavior attractor; // behavior for physics

// Processing internal classes
PGraphics p, pg, pdf;
PShape logo;

// primitives
int nParts = 150;
int nSprings = 150;
int nPoints = 5000;
int ptCount=0;
int poly = 0; // polygonizer type (0 adaptive, 1 uniform steps, 2 uniform length)
int count = 2; // counter for sliding
float primarySpringLength = 55;
float secondarySpringLength = 5;
float partRadius = 50;

boolean ignStyle = false;
boolean rec = false; // controls frame recording
boolean border = false;
boolean go = false;
boolean sprDisp = false;

String fileName = "PDF/physics.pdf";
String fileNamePNG = "images/physics_";

void setup() {
  size(800, 800, P2D); // you must use P2D in order to use PShapes

  pg = createGraphics(width, height);

  // creo il canvas per la registrazione in pdf
  pdf = createGraphics(width, height, PDF, fileName);

  // load shape and centers it in the PGraphics
  svg = new SVGImporter(this, "logo_trim_black.svg");
  svg.centerShape(this.g, 50, 1, 1);

  // creates a PShape for the logo from chosen point subdivision
  getPts(poly);
  // init physics
  initPhysics_text();
}

void draw() {
  background(230);
  stroke(20);
  strokeWeight(3);
  if (go) {
    attractor.setAttractor(new Vec2D(mouseX-width*.5, mouseY-width*.5));
    physics.update();
    if (border) {
      borderCond(physics, pts[1]);
    } else {
    }
  }

  //pg.clear();
  display(this.g);
  //image(pg,0,0);


  if (frameCount%1==0) count++; // increases counter - increase number for slower update
  if (rec) {
    saveFrame("images/logo_RUFA_geom_####.jpg");
    // draws a red rectangle when recording
    pushStyle();
    fill(255, 0, 0);
    noStroke();
    rect(width-50, height-50, 30, 30);
    popStyle();
  }
}

void display (PGraphics pg) {
  pg.beginDraw();

  pg.pushMatrix(); // enters custom coordinate system mode
  pg.translate(width*.5, height*.5);

  // shape(logo, 0, 0);

  drawParts(pg, physics);
  if (sprDisp) drawSprings(pg, physics);

  pg.popMatrix(); // back to global coordinates mode

  pg.endDraw();
}

void getPts(int poly) {
  // switches among different polygonizer methods
  switch(poly) {
  case 0: // adaptative automatically gets points, more points in curved segments
    pts = svg.getPtsAdaptive();
    logo = svg.getShape(pts);
    break;
  case 1: // uniform step samples shapes at equal parametric intervals (faster)
    pts = svg.getPtsUniformStep(0.1);
    logo = svg.getShape(pts);
    break;
  case 2: // uniform length samples at equal length intervals (slower)
    pts = svg.getPtsUniformLength(10);
    logo = svg.getShape(pts);    
    break;
  }
}


// _________________________________ export functions

void recordPDF() { // un altro modo di registrare in pdf, tramite PGraphics
  // in pratica è come per il .png
  // ri-disegno tutto su una PGraphics dedicata
  pdf.beginDraw();
  display(pdf);
  pdf.dispose(); // chiude il file (IMPORTANTE - non dimenticare)
  pdf.endDraw();
}

// _________________________________ key functions

void keyPressed() {
  if (key == 'd') {
    poly = (poly+1)%3;
    // updates point sampling & physics engine
    getPts(poly);
    initPhysics_text();
  }
  if (key == 'v') rec = !rec;
  if (key == 'b') border = !border;
  if (key=='s') sprDisp = !sprDisp;
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
    pg.clear();
    display(pg);
    pg.save(fileNamePNG+ nf(frameCount, 4) +".png");
    println("PNG image saved as: "+ fileNamePNG + nf(frameCount, 4) +".png");
    recordPDF();
    println("PDF file saved as: "+ fileName);
  }
}
