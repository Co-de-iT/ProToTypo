/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 logo Fugue style - https://www.behance.net/gallery/24391255/Fugue
 
 key map
 
 s  toggles point sampling (adaptive - uniform step - uniform length)
 t  toggles shape diplay
 v  toggles video frames recording
 i  save transparent background PNG
 p  save PDF file
 r  save both PNG and PDF in one go
 
 click on tab class_SVGimporter for detailed explanations
 
 */

import processing.pdf.*;
import toxi.geom.*;

// custom created class (see class_SVGimporter tab)
SVGImporter svg;

// external libraries classes
RPoint[][] points; // from geomerative (imported in the class_SVGimporter tab)
Vec2D[][] pts; // from toxi

ArrayList <Spot> spots = new ArrayList<Spot>();
Spot s;

// Processing internal classes
PGraphics p, pg, pdf;
PShape logo;

// primitives
int nPoints = 5000;
int poly = 0; // polygonizer type
int count = 0; // counter for sliding
boolean ignStyle = true;
boolean rec = false; // controls frame recording
boolean go = true;
boolean dispShape = true;

String fileName = "PDF/geomerative.pdf";
String fileNamePNG = "images/geomerative_";

void setup() {
  size(800, 800, P2D); // you must use P2D in order to use PShapes

  pg = createGraphics(width, height);

  // creo il canvas per la registrazione in pdf
  pdf = createGraphics(width, height, PDF, fileName);

  // load shape and centers it in the PGraphics
  svg = new SVGImporter(this, "logo_trim_black.svg");
  svg.centerShape(this.g, 50, 1, 1);

  // creates a PShape for the logo from adaptive point subdivision
  pts = svg.getPtsUniformLength(3);
  logo = svg.getShape(pts);
  count=10;
}

void draw() {
  background(230);
  if (frameCount % 50 == 0 && frameCount < 500) {
    for (int i=0; i< pts.length; i++) {
      if (random(1)<0.5){
      //                     tail      life   maxDiam         minAlpha,          speed        pts         type
      //                       |         |        |               |                 |          |            |
      s = new Spot((int) random(40, 80), 3, random(10, 40), random(5, 20), (int) random(1, 3), pts[i], (int) random(2));
      spots.add(s);
      }
    }
    count+=(int)random(100);
  }
  pg.beginDraw();
  pg.clear(); // clears the PGraphics content
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

void sample(int poly) {
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


Vec2D[] evaluate(float t) { 
  // evaluates shape at parameter t
  // returns a Vec2D array with 2 elements:
  // 0 - point
  // 1 - tangent
  Vec2D[] result = new Vec2D[2];
  // get point and tangent at parameter (begin 0<>1 end) - mapped to mouseX
  result[0] = svg.getPointAt(t);
  result[1] = svg.getTanAt(t);
  return result;
}

// _________________________________ display functions


void display(PGraphics pg) {

  pg.noFill();
  pg.stroke(20);
  pg.strokeWeight(.5);
  pg.pushMatrix(); // enters custom coordinate system mode
  pg.translate(width*.5, height*.5);
  // draws shape
  if (dispShape) pg.shape(logo, 0, 0);

  if (go) drawLines(pg);

  // sampling the shape (only if not recording frames)
  if (!rec) {
    Vec2D[] pt = evaluate(map(mouseX, 0, (float)width, 0, 1)); // evaluation parameter is mapped on mouseX
    lineSDL(pg, pt[0], pt[1], map(mouseY, 0, (float)height, 30, 100)); // line length is mapped on mouseY
  }

  pg.popMatrix(); // back to global coordinates mode
}


void drawLines(PGraphics pg) {
  for (int i=0; i< pts.length; i++) {
    if (pts[i] != null) {
      for (int j=0; j<pts[i].length; j++) {
        int j2 = (j+count)%pts[i].length;
        pg.strokeWeight(3);
        pg.stroke(20);
        pg.point(pts[i][j].x, pts[i][j].y);
        if (i!=1) { // excludes the outer circle
          pg.stroke(20, 100);
          pg.strokeWeight(.5);
          pg.line(pts[i][j].x, pts[i][j].y, pts[i][j2].x, pts[i][j2].y);
        }
      }
    }
  }
}

// draws a line with Start point, Direction and Length (SDL)
void lineSDL(PGraphics pg, Vec2D p, Vec2D tg, float len) {
  // angle for tangent drawing
  float angle = atan2(tg.y, tg.x);
  // point at parameter
  pg.stroke(255, 0, 0);
  pg.strokeWeight(5);
  pg.point(p.x, p.y);

  // tangent line at parameter
  pg.strokeWeight(.5);
  pg.line(p.x, p.y, p.x+cos(angle)*len, p.y+sin(angle)*len);
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
    poly = (poly+1)%3;
    sample(poly);
  }
  if (key == 'v') rec = !rec;
  if (key == 't') dispShape = !dispShape;
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
