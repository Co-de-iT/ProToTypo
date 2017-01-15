
/*

P5 ws RUFA

tutor: Alessio Erioli - Co-de-iT
 
 particles with brightness field influence
 
 */

import toxi.geom.*;

int nPts = 5000;
ArrayList <Particle> pts; // flagged ArrayList
PImage img;
String imgName = "32bits-channels-gradient-bw.jpg";
float[] pixBri; // pixels brightness
float is = 1.3; // image scale factor

void setup() {
  img = loadImage(imgName); // load the sample image
  img.resize(int(img.width*is), int(img.height*is)); //resize (if necessary)
  size(800,600);
  surface.setSize(img.width, img.height); // processing window the same size of the sample image
  smooth();

  pixBri = new float[width*height]; // array for pixel brightness
  
  for(int i=0; i< width*height; i++){
   pixBri[i] = brightness(img.pixels[i]);
  }

  pts = new ArrayList <Particle>();

  for (int i=0; i<nPts; i++) {
    Vec3D v = new Vec3D(random(50,width-50), random(50,height-50), 0); // random scatter
    //Vec3D v = new Vec3D(width/2, height/2,0);
    Particle p = new Particle(v);
    pts.add(p);
  }
  background(0);
}


void draw() {
  //background(0);
  //background(100,0,0);

  for (Particle p : pts) {
    p.update();
  }

  if (mousePressed && mouseButton == LEFT) {
      Particle p = new Particle(new Vec3D(mouseX, mouseY, 0));
      pts.add(p);
  }

  //fill(0,10);
  //rect(0,0,width, height);
}

void keyPressed(){
 if (key=='i') saveFrame("images/silk2_####.png");
}