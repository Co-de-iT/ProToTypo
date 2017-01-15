/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 pointilisme effect based on image sampling
 
 key map:
 
 1,2,3 - toggles between rectangles/circles/stars
 space -  cleans screen
 
 Method
 
 An image is sampled and a geometric shape (circle, square) is drawn with the color (or
 brightness) data value sampled.
 
 */

PImage img;
PShape star;
PVector p;

float scale = 1;
float minDiam = 5;
float maxDiam = 20;
float diam;

int shape = 3; // 1 = rect, 2 = circle, 3 = star

void setup() {
  
  size(150, 150); // Processing 3 requires fixed values in size();
  surface.setResizable(true); // then you have to resize it later by setting it as resizable
  
  // load image and scales it
  img = loadImage("bat elegance - Tim Flach.jpg");
  img.resize(int(img.width*scale), int(img.height*scale));

  // define canvas size by image size
  surface.setSize(img.width, img.height); // this is how it's done in Processing 3
  
  // load a svg in a shape (you can do this for any custom shape)
  star = loadShape("star.svg"); // just downloaded this from wikipedia: https://commons.wikimedia.org/wiki/File:Five-pointed_star.svg
  // disable shape native style so you can set stroke and fill in the sketch
  star.disableStyle();
  
  noStroke();
  image(img, 0, 0);
  // img.filter(INVERT); // uncommenting this one will invert the image colors
  img.loadPixels();
  /*
  //tint(color(255,0,0,50)); // tints the canvas
  loadPixels(); // there's a bug in P3.0.2 when loading pixels from resizable surface
  for (int i=0; i<pixels.length; i++) {
    img.pixels[i]=pixels[i];
  }
  */
  background(0);
  ellipseMode(CENTER);
  rectMode(CENTER);
  shapeMode(CENTER);
}

void draw() {
  pointil(shape);
}

void pointil(int shape) {
  diam = map(mouseX, 0, width, minDiam, maxDiam);
  for (int i=0; i<100; i++) {
    p = new PVector (random(width), random(height));
    fill (img.get(int(p.x), int(p.y)));
    switch(shape) {
    case 1:
      rect(p.x, p.y, diam, diam);
      break;
    case 2:
      ellipse(p.x, p.y, diam, diam);
      break;
    case 3:
      // for more complex shapes you should define a custom PShape or load an .svg in a PShape (see init1)
      shape(star, p.x, p.y, diam*2, diam*2);
      break;
    }
  }
}

void keyPressed() {
  if (key =='i') saveFrame("imgs/frame_####.png");
  if (key >'0' && key <'4') shape = int (key-'0');
  if (key == ' ') background(0);
}