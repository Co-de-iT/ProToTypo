/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 use of the mesh library by Lee Byron
 
 Key map
 
 i  save .png image with transparent background
 p  save .pdf file
 r  save both a .png and a .pdf
 
 Method
 
 . load logo or image in separate PGraphics
 . select points by precise color or brightness range
 . generate Voronoi and/or other point-based drawing
 
 be patient as this sketch takes time to generate the Voronoi... the more points the
 slower it will be.
 
 */

import megamu.mesh.*; // imports mesh library to generate Voronoi - http://www.leebyron.com/else/mesh/
import processing.pdf.*;
import toxi.geom.*;

// toggles

boolean loadImage = false; // to load image instead of logo put this to true
boolean densMap = true; // activate density-based mapping (or else uses brightness range)

// primitives
boolean pdfRec = false;
int nPoints = 5000;
color checkCol = color(0); // color to check for to be inside the logo
float minDens = 0.9;
float maxDens = 0.1;
float minBri = 90;
float maxBri = 190;
float[][] ptsVor = new float[nPoints][2]; // point array for Voronoi
float deg = 3; // degree for density-variation sampling (less difference 1 <> 3 more difference between black & white)

// Processing internal classes
PGraphics p, tr;
PShape logo, voronoi;
PImage img;

// external libraries classes
Voronoi vor;
MPolygon[] vorPoly;
Vec2D[] pts = new Vec2D[nPoints];

void setup() {
  size(800, 800, P2D);

  // creo il canvas nascosto da cui campionare i dati
  p = createGraphics(width, height, JAVA2D);
  // creo e inizializzo il canvas nascosto su cui disegnare con sfondo trasparente
  tr = createGraphics(width, height, JAVA2D);
  tr.beginDraw();
  tr.endDraw();
  // creo il canvas per la registrazione in pdf
  // pdf = createGraphics(width, height, PDF, "PDF/logo_RUFA.pdf");


  // ________________________ load logo/image
  //
  // loading logo in svg format
  logo = loadShape("logo_trim_black.svg");
  logo.scale(2);
  logo.translate(-logo.width*.5, -logo.height*.5);

  // loaing greyscale image
  // img = loadImage("test gradient.png"); // loads gradient test image
  img = loadImage("Plane turbulence.jpg");
  img.resize(p.width, p.height);

  // drawing object on PGraphics p
  p.beginDraw();
  if (loadImage) { 
    p.image(img, 0, 0);
  } else { 
    p.shape(logo, p.width*.5, p.height*.5);
  }
  p.endDraw();

  //image(p, 0, 0);
  rectMode(CENTER);

  // generiamo i punti
  print("calculating points.....");
  if (loadImage) {
    if (densMap) {
      for (int i=0; i<nPoints; i++) {
        pts[i] = getDensity(minDens, maxDens, deg); // position on brightness range
      }
    } else {
      for (int i=0; i<nPoints; i++) {
        pts[i] = getRange(minBri, maxBri); // position on brightness range
      }
    }
  } else {
    for (int i=0; i<nPoints; i++) {
      pts[i] = getPosition(checkCol); // position on exact color
    }
  }
  println("done.");

  for (int i=0; i<nPoints; i++) {
    ptsVor[i][0] = pts[i].x;
    ptsVor[i][1] = pts[i].y;
  }

  // crea il diagramma di Voronoi
  print("creating Voronoi diagram.....");
  vor = new Voronoi(ptsVor);
  vorPoly = vor.getRegions();
  voronoi = createShape(GROUP);
  for (int i=0; i<vorPoly.length; i++) {
    PShape vv = createShape();
    float[][] regPts = vorPoly[i].getCoords();
    if (regPts.length > 0) {
      // begins cell shape drawing
      vv.beginShape();
      vv.noFill();
      vv.strokeWeight(0.5);

      // in logo mode only cells that are inside the logo are retained
      // to perform this check, we verify if the area centroid of each cell
      // is inside the logo shape and keep those who are in

      // calculate centroid
      Vec2D centroid = new Vec2D();
      for (int j=0; j<regPts.length; j++) {
        vv.vertex(regPts[j][0], regPts[j][1]);
        centroid.addSelf(new Vec2D(regPts[j][0], regPts[j][1]));
      }
      vv.endShape();
      centroid.scaleSelf(1/(float)regPts.length);

      // check if centroid is inside our shape or if an image is loaded
      if (inside(p, centroid, checkCol) || loadImage) voronoi.addChild(vv);
    }
  }
  println("done.");

  // disegna sull PGraphics tr
  tr.shape(voronoi, 0, 0);
  //closestLines(tr);
  //displayPts(tr);

  image(tr, 0, 0);
}

void draw() {
  // draw lo lasciamo solo perchè in questo modo lo sketch continua a
  // monitorare l'eventuale pressione di un tasto
}



// ___________________________ other functions _______________________


void displayPts(PGraphics tr) {
  tr.beginDraw();
  tr.stroke(0);
  tr.strokeWeight(3);
  for (int i=0; i<nPoints; i++) {
    tr.point(pts[i].x, pts[i].y);
  }
  tr.endDraw();
}

void randomLines(PGraphics tr) {
  tr.beginDraw();
  tr.stroke(20, 20);
  tr.strokeWeight(0.5);
  int a = int(random(nPoints-1));
  int b = int(random(nPoints-1));
  tr.line(pts[a].x, pts[a].y, pts[b].x, pts[b].y);
  tr.endDraw();
}

void closestLines(PGraphics tr) {
  tr.beginDraw();
  tr.stroke(20, 90);
  for (int i=0; i< nPoints; i++) {
    tr.strokeWeight(map(pts[i].y, 0, height, 0.01, 2));
    for (int j=i+1; j<nPoints; j++) {
      if (pts[i].distanceTo(pts[j]) < 20) {
        tr.line(pts[i].x, pts[i].y, pts[j].x, pts[j].y);
      }
    }
  }
  tr.endDraw();
}

// ___________________________ export functions _______________________

void record(PGraphics tr, String fileName) {
  savePNG(tr, fileName);
  recordPDF(fileName);
}

void savePNG(PGraphics tr, String fileName) {
  tr.save("images/"+fileName+"_"+nf(frameCount, 4)+".png");
}


void recordPDF(String fileName) {

  // un altro modo di registrare in pdf, tramite PGraphics
  // in pratica è come per il .png
  // ri-disegno tutto su una PGraphics dedicata

  PGraphics pdf; 

  // creo il canvas per la registrazione in pdf
  pdf = createGraphics(width, height, PDF, "PDF/"+ fileName +".pdf");

  pdf.beginDraw();
  pdf.shape(voronoi, 0, 0);

  // activate the ones you prefer
  // closestLines(pdf);  
  // displayPts(pdf);

  pdf.dispose(); // chiude il file (IMPORTANTE - non dimenticare)
  pdf.endDraw();
}

// ___________________________ keyboard functions _______________________

void keyPressed() {
  if (key == 'i') savePNG(tr, "RUFA_logo"); 
  if (key == 'p') recordPDF("RUFA_logo");
  if (key == 'r') record (tr, "RUFA_logo");
}
