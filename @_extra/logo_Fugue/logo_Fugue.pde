/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 logo Fugue style - https://www.behance.net/gallery/24391255/Fugue
 
 key map
 
 s  toggles between svg and text-based animation
 v  toggles video frames recording
 i  save transparent background PNG
 p  save PDF file
 r  save both PNG and PDF in one go
 
 click on tab class_SVGimporter for detailed explanations
 
 */

import processing.pdf.*;
import toxi.geom.*;

// custom created classes (see class_SVGimporter tab)
SVGImporter svg, sText;

// external libraries classes
RPoint[][] points; // from geomerative (imported in the class_SVGimporter tab)
Vec2D[][] pts, ptsT; // from toxi

ArrayList <Spot> spots = new ArrayList<Spot>();
Spot s;

// Processing internal classes
PGraphics p, pg, pdf;
PShape logo, txt;

// primitives

int count = 0, maxSpots = 20, sampleLen = 3;
boolean rec = false; // controls frame recording
boolean go = true;
boolean isSvg = true;
String fileName = "PDF/geomerative.pdf";
String fileNamePNG = "images/geomerative_";
String svgFile = "logo_trim_black.svg";
String word = "GATTACA";
String font = "machtgth.ttf";

void setup() {
  size(800, 800, P2D); // you must use P2D in order to use PShapes


  pg = createGraphics(width, height);

  // creo il canvas per la registrazione in pdf
  pdf = createGraphics(width, height, PDF, fileName);

  //
  // SVGImporter class can import both SVG and texts. Here's an example for both
  //
  //_____________ SVG
  // load shape and centers it in the PGraphics
  svg = new SVGImporter(this, svgFile);
  svg.centerShape(this.g, 50, 1, 1);

  // creates a PShape for the logo from uniform length point subdivision
  //pts = svg.getPtsUniformLength(3);
  //logo = svg.getShape(pts);

  //
  //_____________ TEXT
  // load text and centers it in the PGraphics
  sText = new SVGImporter(this, word, font, 100);
  sText.centerShape(this.g, 50, 1, 1);

  // creates a PShape for the text from uniform length point subdivision
  // ptsT = sText.getPtsUniformLength(3);
  // txt = sText.getShape(pts);
  
  init(isSvg, sampleLen);
}

void draw() {
  background(230);
  if (frameCount % 50 == 0 && count<maxSpots /*frameCount < 500*/) {
    for (int i=0; i< pts.length; i++) {
      if (random(1)<0.5) {
        //                     tail      life   maxDiam         minAlpha,          speed        pts         type
        //                       |         |        |               |                 |          |            |
        s = new Spot((int) random(40, 80), 3, random(10, 40), random(5, 20), (int) random(1, 3), pts[i], (int) random(2));
        spots.add(s);
        count++;
      }
    }
  }
  pg.beginDraw();
  pg.clear(); // clears the PGraphics content
  display(pg);
  pg.endDraw();
  image(pg, 0, 0);

  //if (frameCount%2==0) count++; // increases counter - increase number for slower update
  if (rec) {
    saveFrame("images/logo_RUFA_geom_####.jpg");
    // shows a red rectangle when recording frames
    pushStyle();
    fill(255, 0, 0);
    noStroke();
    rect(width-50, height-50, 30, 30);
    popStyle();
  }
} // end draw

// _________________________________ other functions

void init(boolean isSvg, int len) {
  spots.clear();
  if (isSvg) {
    pts = svg.getPtsUniformLength(len);
  } else {
    pts = sText.getPtsUniformLength(len);
  }
  count = 0;
}

// _________________________________ display functions


void display(PGraphics pg) {
  pg.pushMatrix(); // enters custom coordinate system mode
  pg.translate(width*.5, height*.5);
  for (int i=spots.size ()-1; i>=0; i--) {
    s = spots.get(i);
    if (s.alive) {
      if (go) s.update();
      s.display(pg);
    } else {
      s.respawn();
      //spots.remove(i);
      //s = new Spot((int) random(20, 50), (int)random(2, 5), 30, 3, pts);
      //spots.add(s);
    }
  }
  pg.popMatrix(); // back to global coordinates mode
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
  if (key == 's') {
    isSvg = !isSvg;
    init(isSvg, sampleLen);
  }
  if (key == 'v') rec = !rec;
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
