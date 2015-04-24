
/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 Jitterbug - simple class example with cascade constructors and save as png with transparent bg
 
 */

import toxi.geom.*;

PGraphics tr;
PImage logo;

JitterBug bug, bug2, spencer, hill;

void setup() {
  //size(displayWidth, displayHeight);

  size(400, 700);
  tr = createGraphics(width, height, JAVA2D);
  smooth();
  tr.smooth();
  // loads RUFA logo
  logo = loadImage("RUFA_logo_80.png");

  //                         loc             diam  speed     col
  bug = new JitterBug (new Vec2D(150, 450), 80, 3, color(200, 8, 50));
  bug2 = new JitterBug (new Vec2D(150, 450), 30, 5, color(#FFFF00));
  spencer = new JitterBug(new Vec2D(random(width), random(height)), 50, 4, color(210, 210, 210));
  hill = new JitterBug();
  tr.beginDraw();
  tr.endDraw();
  background(130);
  //noStroke();
  //println("new Jitterbug created in x: ", bug.loc.x, ", y: ", bug.loc.y);
}

void draw() {

  tr.beginDraw();
  bug.update();
  bug2.update();
  spencer.update();
  hill.update();
  bug.display(tr);
  bug2.display(tr);
  spencer.display(tr);
  hill.display(tr);
  tr.endDraw();
  image(tr, 0, 0);
  // the logo won't appear in saved images
  image(logo, width-100, height-100);
}

void keyPressed() {
  if (key=='i') tr.save("images/JitterBugs_t_"+ nf(frameCount, 4) +".png");
  //saveFrame("images/JitterBugs_t_####.png");
}

