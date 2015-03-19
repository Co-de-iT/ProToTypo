/*
   geomerative basics
 
 extract text as shape, extract points from shape
 
 */

import geomerative.*;

RFont font; // define basic font
RShape shape; // define basic shape
RPoint[][] tPoints;

PImage logo;

float step;

void setup()
{
  size(600, 800);
  smooth();
  
  logo = loadImage("RUFA_logo_80.png");
  
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this); // init Geomerative library

  font = new RFont( "OpenSans-Light.ttf", 80, RFont.CENTER);
  shape = font.toShape("Hello");

  // set Segmentator (read: point retrieval) settings
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH); // use a uniform distance between points
  RCommand.setSegmentLength(8); // set segmentLength between points
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
  translate(width/2, step);

  font.draw("Hello");
  translate(0, step);
  fill(0);
  noStroke();
  shape.draw();

  translate(0, step);
  stroke(0);
  strokeWeight(2);
  noFill();
  beginShape(POINTS);
  for (int i=0; i<tPoints.length; i++) {
    for (int j=0; j<tPoints[i].length; j++) {
      vertex(tPoints[i][j].x, tPoints[i][j].y);
    }
  }
  endShape();

  translate(0, step);
  stroke(0);
  strokeWeight(2);
  noFill();

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

