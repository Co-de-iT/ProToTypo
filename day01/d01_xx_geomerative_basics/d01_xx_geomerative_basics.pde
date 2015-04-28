/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 geomerative library basics - extract text as shape, extract points from shape
 
 */

import geomerative.*;

RFont font; // define basic font
RShape shape; // define basic shape
RPoint[][] tPoints;

PImage logo;

float step;
String text = "GATTACA";
float segLen = 5; // segmentator length

void setup()
{
  size(600, 800);
  smooth();

  logo = loadImage("RUFA_logo_80.png");

  // VERY IMPORTANT: Always initialize the library in the setup
  RG.init(this); // init Geomerative library

  font = new RFont( "OpenSans-Light.ttf", 80, RFont.CENTER);
  shape = font.toShape(text);

  // set Segmentator (read: point retrieval) settings
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH); // use a uniform distance between points
  RCommand.setSegmentLength(segLen); // set segmentLength between points
  // extract paths and points from the base shape using the above Segmentator settings
  tPoints = shape.getPointsInPaths();

  step = 3.5*font.size;
}

void draw()
{
  background(240);
  noFill();
  stroke(0);
  strokeWeight(1);
  pushMatrix();
  translate(width/2, step); // translates coordinate system
  // draws a text using the RFont
  font.draw(text);
  translate(0, step);
  fill(0);
  noStroke();
  // draws the shape extracted from the font (curves)
  shape.draw();

  translate(0, step);
  stroke(0);
  strokeWeight(3);
  noFill();
  // draws the points extracted from the shape
  beginShape(POINTS);
  for (int i=0; i<tPoints.length; i++) {
    for (int j=0; j<tPoints[i].length; j++) {
      vertex(tPoints[i][j].x, tPoints[i][j].y);
    }
  }
  endShape();

  translate(0, step);
  stroke(0);
  strokeWeight(1);
  noFill();
  // draws shapes from extracted points
  for (int i=0; i<tPoints.length; i++) {
    beginShape();
    for (int j=0; j<tPoints[i].length; j++) {
      vertex(tPoints[i][j].x, tPoints[i][j].y);
    }
    endShape();
  }
  popMatrix();
  image(logo, width-100, height-100);
}
