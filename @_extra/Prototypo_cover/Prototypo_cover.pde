/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 cover design with Geomerative library
 
 Method
 
 generates ws cover
 . convert text to shapes
 . sample shapes for points
 . adds random points throughout the page
 . creates connections (3 orders of varying thickness according to distance range)
 
 */

// import the required libraries
import processing.pdf.*;        // library for PDF export
import geomerative.*;           // library for text manipulation and point extraction

float nextPointSpeed = 0.65;    // speed at which the sketch cycles through the points
boolean saveOneFrame = false;   // variable used to save a single frame as a PDF page
RShape shape, shape1;                   // holds the base shape created from the text
RPoint[][] allPaths, allPaths1;            // holds the extracted points
RPoint[] rPts;
ArrayList <RPoint> rPt = new ArrayList<RPoint>();
ArrayList <Stick> lines = new ArrayList <Stick>();
PImage logo;

float lThres = 0.6;
float nRandPts = 400;

void setup() {
  //size(1280, 720);
  size(780, 1040);
  smooth();

  // loads RUFA logo
  logo = loadImage("RUFA_logo_80.png");

  // initialize the Geomerative library
  RG.init(this);
  // create font used by Geomerative
  RFont font = new RFont("neuropol x rg.ttf", 120);
  // create base shapes from text using the loaded font
  shape = font.toShape("PRO-to");
  shape1 = font.toShape("T1P0");
  // center the shapes in the middle of the screen
  //shape.translate(width/2 - shape.getWidth()/2, height/2 - shape.getHeight());
  //shape1.translate(width/2 - shape1.getWidth()/2, height/2 + shape1.getHeight());

  // align shapes to the right
  shape.translate(width - shape.getWidth()-50, height/2 - shape.getHeight());
  shape1.translate(width - shape1.getWidth() -50, height/2 + shape1.getHeight());
  // set Segmentator (read: point retrieval) settings
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH); // use a uniform distance between points
  RCommand.setSegmentLength(5); // set segmentLength between points
  // extract paths and points from the base shape using the above Segmentator settings
  allPaths = shape.getPointsInPaths();
  allPaths1 = shape1.getPointsInPaths();

  initPoints();
  calcPoints();
}

void draw() {
  // begin recording to PDF
  if (saveOneFrame == true) {
    beginRecord(PDF, "Prototypo cover_" + timestamp() + ".pdf");
  }

  // clear the background
  background(255);

  // draw the whole set of lines
  noFill();
  for (Stick l : lines) l.display();

  // draws points
  stroke(0, 180);
  strokeWeight(2);
  for (RPoint p : rPt) point(p.x, p.y);

  // end recording to PDF
  if (saveOneFrame) {
    endRecord();
    saveOneFrame = false;
  }

  // the logo won't appear in saved images
  image(logo, width-100, height-100);
}

void keyPressed() {
  if (key == 's') {
    saveOneFrame = true; // set the variable to true to save a single frame as a PDF file / page
  }
  if (key=='i') saveFrame("images/Prorotypo cover_####.png");
  if (key==' ') {
    initPoints();
    calcPoints();
  }
}

// _______________________________________________________________________________

String timestamp() {
  return year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
}

float distance(RPoint a, RPoint b) {
  float d;
  d = sqrt(pow((b.x-a.x), 2)+pow((b.y-a.y), 2));

  return d;
}

void initPoints() {
  rPt.clear();
  lines.clear();

  for (int i=0; i<allPaths.length; i++) {
    for (int j=0; j<allPaths[i].length; j++) {
      if (random(1) > lThres)  rPt.add(allPaths[i][j]); // add random points from text
    }
  }

  for (int i=0; i<allPaths1.length; i++) {
    for (int j=0; j<allPaths1[i].length; j++) {
      if (random(1) > lThres)  rPt.add(allPaths1[i][j]); // add random points from text
    }
  }

  RPoint z;
  for (int i=0; i<nRandPts; i++) {
    z = new RPoint(random(width), random(100, height-100));
    rPt.add(z);
  }
}

void calcPoints() {

  RPoint r, r1;
  Stick l;
  for (int i=0; i<rPt.size (); i++) {
    r = rPt.get(i);
    for (int j=i+1; j<rPt.size (); j++) {
      r1 = rPt.get(j); 
      strokeWeight(.5);
      if (distance(r, r1)< 40) {
        l = new Stick(r, r1, color(80, 0, 0, 160), .5);
        lines.add(l);
      }
      if (distance(r, r1)> 30 && distance(r, r1)< 60) {
        l = new Stick(r, r1, color(140, 0, 0, 40), .5);
        lines.add(l);
      }
      if (distance(r, r1) > 50 && distance(r, r1)< 120) {
        l = new Stick(r, r1, color(200, 0, 0, 20), .5);
        lines.add(l);
      }
    }
  }
}
