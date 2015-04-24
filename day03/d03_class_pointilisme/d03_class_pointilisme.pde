/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 pointilisme effect on image based on image sampling
 
 key map:
 
 space bar - toggles between circles/rectangles
 
 Method
 
 An image is sampled and a geometric shape (circle, square) is drawn with the color (or
 brightness) data value sampled.
 
 */

import toxi.geom.*;

PImage img;
Vec2D p;

float scale = 1;
float minDiam = 5;
float maxDiam = 50;
float diam;

boolean circle = false;

void setup() {

  // load image and scales it
  img = loadImage("bat elegance - Tim Flach.jpg");
  img.resize(int(img.width*scale), int(img.height*scale));
  // define canvas size by image 
  size(img.width, img.height);
  
  noStroke();
  //tint(color(255,0,0,50));
  image(img, 0, 0);
  //filter(INVERT); // uncommenting this one will invert the image colors
  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    img.pixels[i]=pixels[i];
  }
  background(0);
  ellipseMode(CENTER);
  rectMode(CENTER);
}

void draw() {
  //image(img, 0, 0);
  //filter(INVERT);
  //filter (POSTERIZE,int(map(mouseX, 0, width, 2,32)));
  //background(img);
  pointil();
}

void pointil() {
  diam = map(mouseX, 0, width, minDiam, maxDiam);
  for (int i=0; i<100; i++) {
    p = new Vec2D(random(width), random(height));
    fill(img.get(int(p.x), int(p.y)));
    if (circle) {
      ellipse(p.x, p.y, diam, diam);
    } else { 
      rect(p.x, p.y, diam, diam);
    }
  }
}

void keyPressed() {
  if (key == ' ') circle = ! circle;
}

